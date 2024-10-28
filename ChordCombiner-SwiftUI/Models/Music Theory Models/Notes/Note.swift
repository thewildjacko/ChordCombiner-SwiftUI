//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

/// Defines a single note to be used in a scale, mode, chord or pattern
struct Note: GettableKeyName, Enharmonic, KeySwitch, CustomStringConvertible {
  var description: String { "\(degree.name) (\(noteName))" }
  
  var noteNumber: NoteNumber {
    get { degree.noteNumber.plusNoteNum(rootNumber) }
    set { }
  }
  
  var rootNumber: NoteNumber
  
  var enharmonic: EnharmonicSymbol
  
  /// degree of the chord or scale
  var degreeName: (name: String, numeric: String, long: String) {
    (name: degree.name, numeric: degree.numeric, long: degree.long)
  }
  
  var degree: Degree
  
  var rootKeyName: KeyName {
    get { keySwitcher.root(rootNumber: rootNumber) }
    set { }
  }
  
  var keyName: KeyName {
    switch degree {
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
  
  var noteName: String { keyName.rawValue }
  
  init(rootNumber: NoteNumber = .zero, enharmonic: EnharmonicSymbol = .flat, degree: Degree) {
    self.rootNumber = rootNumber
    self.enharmonic = enharmonic
    self.degree = degree
  }
  
  init(_ degree: Degree, of root: RootKeyNote) {
    // maj3rd of D -> rootNumber = 2 -> note is F#
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
  
  // FIXME: Currently not using this init
  init(_ keyName: KeyName = .c, degree: Degree = .root) {
    // keyName = D, degree is maj3rd, noteNumber is 2 minusDeg 4 = 10
    let noteNumber = NoteNumber(keyName.noteNumber.rawValue.minusDegreeNumber(degree.noteNumber.rawValue))
    self.init(rootNumber: noteNumber, enharmonic: keyName.enharmonic, degree: degree)
  }
  
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
  
  /// flips a note enharmonically
  func enharmSwapped() -> Note {
    var newEnharm: EnharmonicSymbol {
      switch enharmonic {
      case .flat, .sharp:
        return enharmonic == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharmonic == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Note(rootNumber: noteNumber, enharmonic: newEnharm, degree: degree)
  }
  
  mutating func swapEnharmonic() {
    switch enharmonic {
    case .flat, .sharp:
      enharmonic = enharmonic == .flat ? .sharp : .flat
    case .blackKeyFlats, .blackKeySharps:
      enharmonic = enharmonic == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
    }
    kSW(keySwitcher: KeySwitcher(enharmonic: enharmonic))
  }
  
  mutating func switchEnharmonic(to enharmonic: EnharmonicSymbol) {
    self.enharmonic = enharmonic
  }
  
  func toStackedPitch(startingOctave: Int, chordType: ChordType) -> Int {
    let pitch = self.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
    let raisedPitch = pitch + 12
    
    return chordType.baseChordType.degreeTags.contains(degree) ? pitch : raisedPitch
  }

}

extension Note: Equatable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.noteNumber == rhs.noteNumber
  }
}

extension Note {
  func isEnharmonicEquivalent(to note: Note) -> Bool {
    if self.noteNumber == note.noteNumber && self.noteName != note.noteName {
      return true
    } else {
      return false
    }
  }
  
  static func enharmonicEquivalents (lhs: Note, rhs: Note) -> Bool {
    if lhs.noteNumber == rhs.noteNumber && lhs.noteName != rhs.noteName {
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
