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
  var rootNote: Root {
    didSet {
      root = rootNote.note
      rootKeyNote = rootNote.rootKeyNote
      raisedRoot = rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
    }
  }

  var root: Note
  var rootKeyNote: RootKeyNote

  var chordType: ChordType
  var startingOctave: Int
  var keyName: KeyName {
    didSet {
      startingPitch = keyName.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
    }
  }

  var startingPitch: Int = 0

  var degreeNumbers: [Int] {
    didSet { setDegreeAndPitchNumberOperatorProperties() }
  }

  var notesByNoteNumber: NotesByNoteNumber = [:] {
    didSet {
      notes = Array(notesByNoteNumber.values).sorted { $0.degree.size < $1.degree.size }
    }
  }

  var isSlashChord: Bool = false
  var slashChordBassNote: RootKeyNote?

  var notes: [Note] = []

  var degreeNumbersRaisedAboveRoot: [Int] = []

  // MARK: DegreeAndPitchNumberOperator compliance
  var noteNumbers: [NoteNumber] = []

  var raisedRoot: Int

  var raisedPitches: [Int] = [] {
    didSet {
      pitchesRaisedAboveRoot = raisedPitches.map {
        $0.raiseAbove(pitch: raisedRoot, degreeNumbers: nil)
      }
    }
  }

  var pitchesRaisedAboveRoot: [Int] = []

  // MARK: Computed Properties
  var stackedPitches: [Int] {
    return pitchesRaisedAboveRoot.map {
      $0.raiseAboveDegreesIfAbsent(baseChord().voicingCalculator.pitchesRaisedAboveRoot)
    }
  }

  var stackedPitchesByNote: PitchesByNote {
//    print(notes.noteNames())

    return notes.toPitchesByNote(pitches: stackedPitches)
    //    Dictionary(uniqueKeysWithValues: zip(notes, stackedPitches))
  }

  var stackedPitchesByDegree: [Int] {
    return notes.map { $0.toStackedPitch(startingOctave: startingOctave, chordType: chordType) }
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
      root = rootNote.note
      rootKeyNote = rootNote.rootKeyNote
      raisedRoot = rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)

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

      pitchesRaisedAboveRoot = raisedPitches.map {
        $0.raiseAbove(pitch: raisedRoot, degreeNumbers: nil)
      }

      notes = Array(notesByNoteNumber.values).sorted { $0.degree.size < $1.degree.size }
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

  mutating func setDegreeAndPitchNumberOperatorProperties() {
    noteNumbers = degreeNumbers.map { NoteNumber($0) }
    degreeNumbersRaisedAboveRoot = degreeNumbers.map { $0.raiseAboveRoot(rootKeyNote: rootKeyNote) }
    raisedPitches = degreeNumbers.map { $0.toPitch(startingOctave: startingOctave) }
  }

  mutating func setRootProperties() {
    root = rootNote.note
    rootKeyNote = rootNote.rootKeyNote
    raisedRoot = rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }

  func printDegreeNumberArrays() {
    print("degreeNumbers: \(degreeNumbers)")
    print("degreeNumbersRaisedAboveRoot: \(degreeNumbersRaisedAboveRoot)")
    print("raisedPitches: \(raisedPitches)")
    print("pitchesRaisedAboveRoot: \(pitchesRaisedAboveRoot)")
    print("stackedPitches: \(stackedPitches)")
  }
}
