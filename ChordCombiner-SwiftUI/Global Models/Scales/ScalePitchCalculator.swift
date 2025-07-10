//
//  ScalePitchCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

struct ScalePitchCalculator: GettableKeyName, SettableNotesByNoteNumber, DegreeNumbers {
  static let initialPC: ScalePitchCalculator = ScalePitchCalculator(
    notes: [],
    rootNote: Root(.c),
    scaleType: .major,
    startingOctave: 4,
    keyName: .c)

  // MARK: Stored properties
  var rootNote: Root { didSet { setRootProperties() } }
  var root: Note = Note(.c)
  var rootKeyNote: RootKeyNote = .c

  var scaleType: ScaleType = .major
  var startingOctave: Int = 4
  var keyName: KeyName = .c { didSet { setStartingPitch() }}
  var startingPitch: Int = 60

  var notes: [Note] = [] { didSet { setDegreeNumbers() }}

  var notesByNoteNumber: NotesByNoteNumber = [:]

  // MARK: DegreeAndPitchNumberOperator compliance
  var degreeNumbers: [Int] = [] { didSet { setNoteNumbers() }}
  var noteNumbers: [NoteNumber] = []
  var raisedRoot: Int = 60

  // MARK: Computed Properties
  var stackedPitches: [Int] {
    var tempStackedPitches: [Int] = []
    tempStackedPitches.reserveCapacity(8)

    for note in notes {
      let stackedPitch = raisedRoot + note.degree.size
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
    scaleType: ScaleType,
    startingOctave: Int,
    keyName: KeyName) {
      self.notes = notes
      self.rootNote = rootNote
      setRootProperties()

      self.scaleType = scaleType
      self.startingOctave = startingOctave
      self.keyName = keyName
      setStartingPitch()

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
  /*
  func baseChord() -> Chord {
    return Chord(rootKeyNote, scaleType.baseChordType)
  }

  func allChordNotesInKeyFiltered() -> [Note] {
    var allChordNotesInKey = rootKeyNote.allChordNotesInKey()

    for note in notes {
      allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
    }

    return allChordNotesInKey
  }
   */

  func printDegreeNumberArrays() {
    print("degreeNumbers: \(degreeNumbers)")
    print("stackedPitches: \(stackedPitches)")
  }
}
