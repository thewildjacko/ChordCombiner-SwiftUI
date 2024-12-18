//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

typealias PitchesByNote = [Note: Int]

/// Defines a single note to be used in a scale, mode, chord or pattern
struct Note: GettableKeyName, Enharmonic, KeySwitch, CustomStringConvertible {
  // MARK: stored properties
  /// the ``NoteNumber`` of the ``Note``'s ``RootKeyNote``
  var rootNumber: NoteNumber {
    didSet {
      noteNumber = degree.noteNumber.plusNoteNum(rootNumber)
      rootKeyName = keySwitcher.root(rootNumber: rootNumber)
      setKeyName()
    }
  }

  /// whether the note is sharp or flat
  var enharmonic: EnharmonicSymbol {
    didSet { keySwitcher = KeySwitcher(enharmonic: enharmonic) }
  }

  /// the ``Degree`` the ``Note`` represents, relative to its root.
  var degree: Degree = .root {
    didSet {
      setDegreeProperties()
      setKeyName()
    }
  }

  /// the ``NoteNumber`` of the ``Note`` itself
  private(set) var noteNumber: NoteNumber

  /// tuplet containing textual descriptions of the ``Degree`` of the ``Chord`` or scale
  private(set) var degreeName: DegreeName

  /// returns a `KeySwitch` set to sharp or flat
  private(set) var keySwitcher: KeySwitcher = KeySwitcher(enharmonic: .flat)

  /// the ``KeyName`` enum value of the ``Note``'s  root
  private(set) var rootKeyName: KeyName

  /// the ``KeyName`` enum value of the ``Note`` (stores letter name, noteNumber, etc.)
  private(set) var keyName: KeyName = .c {
    didSet { noteName = keyName.rawValue }
  }

  /// shorthand for the letter name of the ``Note``
  private(set) var noteName: String = "C"

  // MARK: Initializer
  init(rootNumber: NoteNumber = .zero, enharmonic: EnharmonicSymbol = .flat, degree: Degree) {
    self.rootNumber = rootNumber
    self.enharmonic = enharmonic
    self.degree = degree

    degreeName = DegreeName(
      name: degree.name,
      numeric: degree.numeric,
      long: degree.long)

    noteNumber = degree.noteNumber.plusNoteNum(rootNumber)

    keySwitcher = KeySwitcher(enharmonic: enharmonic)
    rootKeyName = keySwitcher.root(rootNumber: rootNumber)

    setKeyName()
    noteName = keyName.rawValue
  }

  init(_ degree: Degree, of root: RootKeyNote) {
    self.init(
      rootNumber: root.keyName.noteNumber,
      enharmonic: root.keyName.enharmonic,
      degree: degree
    )
  }

  init(_ root: RootKeyNote) {
    self.init(
      rootNumber: root.keyName.noteNumber,
      enharmonic: root.keyName.enharmonic,
      degree: .root
    )
  }

  // MARK: computed properties
  var description: String { "\(degree.name) (\(noteName))" }

  // MARK: Instance methods
  func toStackedPitch(startingOctave: Int, chordType: ChordType) -> Int {
    let pitch = self.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
    let raisedPitch = pitch + 12

    return chordType.baseChordType.degreeTags.contains(degree) ? pitch : raisedPitch
  }

  func isEnharmonicEquivalent(to note: Note) -> Bool {
    if self.noteNumber == note.noteNumber && self.noteName != note.noteName {
      return true
    } else {
      return false
    }
  }
}

// MARK: Property observer helper methods
extension Note {
  mutating func setDegreeProperties() {
    degreeName = DegreeName(
      name: degree.name,
      numeric: degree.numeric,
      long: degree.long)

    noteNumber = degree.noteNumber.plusNoteNum(rootNumber)
  }

  mutating func setKeyName() {
    keyName = degree.getKeyName(using: keySwitcher, rootNumber: rootNumber)
  }
}

extension Note: Equatable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.noteNumber == rhs.noteNumber
  }
}

extension Note: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(noteNumber)
  }
}

extension Note {
  func getDotNotationName() -> String {
    return noteName.toDotNotation()
  }
}
