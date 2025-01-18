//
//  VoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/12/24.
//

import Foundation

struct VoicingCalculator: GettableKeyName {
  static let initialVC: VoicingCalculator = VoicingCalculator(
    degreeNumbers: [],
    rootNote: Root(.c),
    chordType: .ma,
    startingOctave: 4,
    keyName: .c, notesByNoteNumber: [:])

  // MARK: Stored properties
  var rootNote: Root { didSet { setRootProperties() } }
  var root: Note = Note(.c)
  var rootKeyNote: RootKeyNote = .c

  var chordType: ChordType = .ma
  var startingOctave: Int = 4
  var keyName: KeyName = .c {
    didSet {
      startingPitch = keyName.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
    }
  }

  var startingPitch: Int = 0

  var degreeNumbers: [Int] = [] { didSet { setDegreeAndPitchNumberOperatorProperties() }}

  var notesByNoteNumber: NotesByNoteNumber = [:] { didSet { setNotes() }}

  var isSlashChord: Bool = false
  var slashChordBassNote: RootKeyNote?

  var notes: [Note] = []

  // MARK: DegreeAndPitchNumberOperator compliance
  var noteNumbers: [NoteNumber] = []

  var raisedRoot: Int = 60

  // MARK: Computed Properties
  var stackedPitches: [Int] {
    var tempStackedPitches: [Int] = []
    tempStackedPitches.reserveCapacity(8)

    for note in notes {
      var stackedPitch = raisedRoot + note.degree.size
      if chordType.baseChordType == .dim7 && note.degree == .major7th {
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
    degreeNumbers: [Int],
    rootNote: Root,
    chordType: ChordType,
    startingOctave: Int,
    keyName: KeyName,
    notesByNoteNumber: NotesByNoteNumber,
    isSlashChord: Bool = false,
    slashChordBassNote: RootKeyNote? = nil) {

      self.rootNote = rootNote

      setRootProperties()

      self.chordType = chordType
      self.startingOctave = startingOctave
      self.keyName = keyName
      startingPitch = keyName.noteNumber.rawValue.toPitch(startingOctave: startingOctave)

      self.notesByNoteNumber.reserveCapacity(12)
      self.notesByNoteNumber = notesByNoteNumber
      self.isSlashChord = isSlashChord
      self.slashChordBassNote = slashChordBassNote

      self.degreeNumbers = degreeNumbers

      setDegreeAndPitchNumberOperatorProperties()
      setNotes()
    }

  // MARK: Initializer helper methods
  mutating func setDegreeAndPitchNumberOperatorProperties() {
    noteNumbers = degreeNumbers.map { NoteNumber($0) }
  }

  mutating func setNotes() {
    notes = Array(notesByNoteNumber.values).sorted { $0.degree.size < $1.degree.size }
  }

  mutating func setRootProperties() {
    root = rootNote.note
    rootKeyNote = rootNote.rootKeyNote
    raisedRoot = rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }

  // MARK: Instance methods
  func baseChord() -> Chord {
    return Chord(rootKeyNote, chordType.baseChordType)
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
