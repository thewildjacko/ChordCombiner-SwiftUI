//
//  VoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/12/24.
//

import Foundation

struct VoicingCalculator: GettableKeyName, DegreeAndPitchNumberOperator, SettableNotesByNoteNumber {
  static let initialVC: VoicingCalculator = VoicingCalculator(
    notes: [],
    rootNote: Root(.c),
    chordType: .ma,
    startingOctave: 4,
    keyName: .c,
    isSlashChord: false,
    slashChordBassNote: .c)

  // MARK: Stored properties
  var rootNote: Root { didSet { setRootProperties() } }
  var root: Note = Note(.c)
  var rootKeyNote: RootKeyNote = .c

  var chordType: ChordType = .ma
  var startingOctave: Int = 4
  var keyName: KeyName = .c { didSet { setStartingPitch() }}
  var startingPitch: Int = 60

  var notes: [Note] = [] { didSet { setDegreeNumbers() }}

  var notesByNoteNumber: NotesByNoteNumber = [:]

  var isSlashChord: Bool = false
  var slashChordBassNote: RootKeyNote?

  // MARK: DegreeAndPitchNumberOperator compliance
  var degreeNumbers: [Int] = [] { didSet { setNoteNumbers() }}
  var noteNumbers: [NoteNumber] = []
  var raisedRoot: Int = 60

  // MARK: Computed Properties
  var stackedPitches: [Int] {
    var tempStackedPitches: [Int] = []
    tempStackedPitches.reserveCapacity(8)

    for note in notes {
      var stackedPitch = raisedRoot + note.degree.size
      if ChordType(chordType.baseChordType) == .dim7 && note.degree == .major7th {
        stackedPitch += 12
      }

      tempStackedPitches.append(stackedPitch)
    }

    return tempStackedPitches
  }

  var stackedPitchesByNote: PitchesByNote {
    return notes.toPitchesByNote(pitches: stackedPitches)
  }

  // MARK: Initializer
  init(
    notes: [Note],
    rootNote: Root,
    chordType: ChordType,
    startingOctave: Int,
    keyName: KeyName,
    isSlashChord: Bool = false,
    slashChordBassNote: RootKeyNote? = nil) {
      self.notes = notes
      self.rootNote = rootNote
      setRootProperties()

      self.chordType = chordType
      self.startingOctave = startingOctave
      self.keyName = keyName
      setStartingPitch()

      self.isSlashChord = isSlashChord
      self.slashChordBassNote = slashChordBassNote

      setNotesByNoteNumber(notes.keyed { $0.noteNumber })

      setDegreeNumbers()
      setNoteNumbers()
    }

  // MARK: Initializer helper methods
  mutating func setDegreeNumbers() { degreeNumbers = notes.degreeNumbers() }

  mutating func setNoteNumbers() { noteNumbers = degreeNumbers.noteNumbers() }

  mutating func setStartingPitch() {
    startingPitch = keyName.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }

  mutating func setRootProperties() {
    root = rootNote.note
    rootKeyNote = rootNote.rootKeyNote
    raisedRoot = rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }

  // MARK: Instance methods
  func baseChord() -> Chord {
    return Chord(rootKeyNote, ChordType(chordType.baseChordType))
  }

  func allChordNotesInKeyFiltered() -> [Note] {
    var allChordNotesInKey = rootKeyNote.allChordNotesInKey()

    for note in notes {
      allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
    }

    return allChordNotesInKey
  }

  func printDegreeNumberArrays() {
    print("degreeNumbers: \(degreeNumbers)")
    print("stackedPitches: \(stackedPitches)")
  }
}
