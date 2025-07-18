//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation
import SwiftUI

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

  /// struct containing textual descriptions of the ``Degree`` of the ``Chord`` or scale
  private(set) var degreeName: DegreeName

  /// returns a `KeySwitch` set to sharp or flat
  private(set) var keySwitcher: KeySwitcher = KeySwitcher(enharmonic: .flat)

  /// the ``KeyName`` enum value of the ``Note``'s  root
  private(set) var rootKeyName: KeyName

  /// the ``KeyName`` enum value of the ``Note`` (stores letter name, noteNumber, etc.)
  private(set) var keyName: KeyName = .c {
    didSet { noteName = keyName.rawValue }
  }

  /// shorthand for the rawValue of the ``KeyName`` 
  private(set) var noteName: String = "C"

  // MARK: Initializers
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

  init(_ degree: Degree, of note: Note) {
    self.init(
      rootNumber: note.rootNumber,
      enharmonic: note.rootKeyName.enharmonic,
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

    return ChordType(chordType.baseChordType).degreeTags.contains(degree) ? pitch : raisedPitch
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

// MARK: Equatable & other equivalence methods
extension Note: Equatable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.noteNumber == rhs.noteNumber &&
    lhs.degree == rhs.degree &&
    lhs.enharmonic == rhs.enharmonic
  }

  // not necessarily same degree
  func hasSameName(as note: Note) -> Bool {
    return self.noteNumber == note.noteNumber && self.noteName == note.noteName
  }

  // only the same noteNumber
  func isEnharmonicEquivalent(to note: Note) -> Bool {
    if self.noteNumber == note.noteNumber && self.noteName != note.noteName {
      return true
    } else {
      return false
    }
  }

  // same noteNumber & degree but different spelling
  func isEnharmonicEquivalentWithSameDegree(to note: Note) -> Bool {
    if self.noteNumber == note.noteNumber &&
        self.degree == note.degree &&
        self.noteName != note.noteName {
      return true
    } else {
      return false
    }
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

struct NoteTestView: View {

  var body: some View {
    List {
      ForEach(Degree.chordTones, id: \.self) { degree in
        let note = Note(degree, of: .eSh)
        Text("\(degree.name): \(note.noteName)")
      }
    }
  }
}

// #Preview {
//  NoteTestView()
// }
