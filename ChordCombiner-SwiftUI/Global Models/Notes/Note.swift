//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

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
  var degree: Degree {
    didSet {
      setDegreeProperties()
      setKeyName()
    }
  }
  
  /// the ``NoteNumber`` of the ``Note`` itself
  private(set) var noteNumber: NoteNumber
  
  /// tuplet containing textual descriptions of the ``Degree`` of the ``Chord`` or scale
  private(set) var degreeName: (name: String, numeric: String, long: String)

  /// returns a `KeySwitch` set to sharp or flat
  private(set) var keySwitcher: KeySwitcher

  /// the ``KeyName`` enum value of the ``Note``'s  root
  private(set) var rootKeyName: KeyName
  
  /// the ``KeyName`` enum value of the ``Note`` (stores letter name, noteNumber, etc.)
  private(set) var keyName: KeyName { didSet { noteName = keyName.rawValue }}

  /// shorthand for the letter name of the ``Note``
  private(set) var noteName: String
  
  // MARK: Initializer
  init(rootNumber: NoteNumber = .zero, enharmonic: EnharmonicSymbol = .flat, degree: Degree) {
    self.rootNumber = rootNumber
    self.enharmonic = enharmonic
    self.degree = degree
    
    degreeName = (name: degree.name, numeric: degree.numeric, long: degree.long)
    noteNumber = degree.noteNumber.plusNoteNum(rootNumber)
    
    keySwitcher = KeySwitcher(enharmonic: enharmonic)
    rootKeyName = keySwitcher.root(rootNumber: rootNumber)
    
    keyName = switch self.degree {
    case .root, .octave, .perfect15th:
      keySwitcher.root(rootNumber: rootNumber)
    case .minor2nd, .flat9th:
      keySwitcher.minor9th(rootNumber: rootNumber)
    case .major2nd, .major9th:
      keySwitcher.major9th(rootNumber: rootNumber)
    case .sharp2nd, .sharp9th:
      keySwitcher.sharp9th(rootNumber: rootNumber)
    case .minor3rd, .minor10th:
      keySwitcher.minor3rd(rootNumber: rootNumber)
    case .major3rd, .major10th:
      keySwitcher.major3rd(rootNumber: rootNumber)
    case .perfect4th, .perfect11th:
      keySwitcher.perfect4th(rootNumber: rootNumber)
    case .sharp4th, .sharp11th:
      keySwitcher.sharp4th(rootNumber: rootNumber)
    case .diminished5th, .flat12th:
      keySwitcher.dim5th(rootNumber: rootNumber)
    case .perfect5th, .perfect12th:
      keySwitcher.perfect5th(rootNumber: rootNumber)
    case .sharp5th, .sharp12th:
      keySwitcher.sharp5th(rootNumber: rootNumber)
    case .minor6th, .flat13th:
      keySwitcher.minor6th(rootNumber: rootNumber)
    case .major6th, .major13th:
      keySwitcher.major6th(rootNumber: rootNumber)
    case .diminished7th, .diminished14th:
      keySwitcher.dim7th(rootNumber: rootNumber)
    case .minor7th, .minor14th:
      keySwitcher.minor7th(rootNumber: rootNumber)
    case .major7th, .major14th:
      keySwitcher.major7th(rootNumber: rootNumber)
    }
    
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
  mutating func kSW(keySwitcher: KeySwitcher) {
    switch noteNumber {
    case .zero:
      self.rootKeyName = keySwitcher.pickKey(.c, .bSh, .c, .c)
    case .one:
      self.rootKeyName = keySwitcher.pickKey(.dB, .cSh, .dB, .cSh)
    case .two:
      self.rootKeyName = .d
    case .three:
      self.rootKeyName = keySwitcher.pickKey(.eB, .dSh, .eB, .dSh)
    case .four:
      self.rootKeyName = keySwitcher.pickKey(.fB, .e, .fB, .e)
    case .five:
      self.rootKeyName = keySwitcher.pickKey(.f, .eSh, .f, .f)
    case .six:
      self.rootKeyName = keySwitcher.pickKey(.gB, .fSh, .gB, .fSh)
    case .seven:
      self.rootKeyName = .g
    case .eight:
      self.rootKeyName = keySwitcher.pickKey(.aB, .gSh, .aB, .gSh)
    case .nine:
      self.rootKeyName = .a
    case .ten:
      self.rootKeyName = keySwitcher.pickKey(.bB, .aSh, .bB, .aSh)
    case .eleven:
      self.rootKeyName = keySwitcher.pickKey(.cB, .b, .b, .b)
    }
  }
        
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
    degreeName = (name: degree.name, numeric: degree.numeric, long: degree.long)
    noteNumber = degree.noteNumber.plusNoteNum(rootNumber)
  }
  
  mutating func setKeyName() {
    keyName = switch self.degree {
    case .root, .octave, .perfect15th:
      keySwitcher.root(rootNumber: rootNumber)
    case .minor2nd, .flat9th:
      keySwitcher.minor9th(rootNumber: rootNumber)
    case .major2nd, .major9th:
      keySwitcher.major9th(rootNumber: rootNumber)
    case .sharp2nd, .sharp9th:
      keySwitcher.sharp9th(rootNumber: rootNumber)
    case .minor3rd, .minor10th:
      keySwitcher.minor3rd(rootNumber: rootNumber)
    case .major3rd, .major10th:
      keySwitcher.major3rd(rootNumber: rootNumber)
    case .perfect4th, .perfect11th:
      keySwitcher.perfect4th(rootNumber: rootNumber)
    case .sharp4th, .sharp11th:
      keySwitcher.sharp4th(rootNumber: rootNumber)
    case .diminished5th, .flat12th:
      keySwitcher.dim5th(rootNumber: rootNumber)
    case .perfect5th, .perfect12th:
      keySwitcher.perfect5th(rootNumber: rootNumber)
    case .sharp5th, .sharp12th:
      keySwitcher.sharp5th(rootNumber: rootNumber)
    case .minor6th, .flat13th:
      keySwitcher.minor6th(rootNumber: rootNumber)
    case .major6th, .major13th:
      keySwitcher.major6th(rootNumber: rootNumber)
    case .diminished7th, .diminished14th:
      keySwitcher.dim7th(rootNumber: rootNumber)
    case .minor7th, .minor14th:
      keySwitcher.minor7th(rootNumber: rootNumber)
    case .major7th, .major14th:
      keySwitcher.major7th(rootNumber: rootNumber)
    }
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
