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
  
  var noteNum: NoteNum {
    get { degree.noteNum.plusDeg(rootNum) }
    set { }
  }
  
  var rootNum: NoteNum
  
  var enharmonic: EnharmonicSymbol
  
  /// degree of the chord or scale
  var degreeName: (name: String, short: String, long: String) {
    (name: degree.name, short: degree.short, long: degree.long)
  }
  
  var degree: Degree
  
  var rootKeyName: KeyName {
    get { keySwitcher.root(rootNum: rootNum) }
    set { }
  }
  
  var keyName: KeyName {
    switch degree {
    case .root:
      keySwitcher.root(rootNum: rootNum)
    case .minor9th:
      keySwitcher.minor9th(rootNum: rootNum)
    case .major9th:
      keySwitcher.major9th(rootNum: rootNum)
    case .sharp9th:
      keySwitcher.sharp9th(rootNum: rootNum)
    case .minor3rd:
      keySwitcher.minor3rd(rootNum: rootNum)
    case .major3rd:
      keySwitcher.major3rd(rootNum: rootNum)
    case .perfect4th:
      keySwitcher.perfect4th(rootNum: rootNum)
    case .sharp4th:
      keySwitcher.sharp4th(rootNum: rootNum)
    case .dim5th:
      keySwitcher.dim5th(rootNum: rootNum)
    case .perfect5th:
      keySwitcher.perfect5th(rootNum: rootNum)
    case .sharp5th:
      keySwitcher.sharp5th(rootNum: rootNum)
    case .minor6th:
      keySwitcher.minor6th(rootNum: rootNum)
    case .major6th:
      keySwitcher.major6th(rootNum: rootNum)
    case .dim7th:
      keySwitcher.dim7th(rootNum: rootNum)
    case .minor7th:
      keySwitcher.minor7th(rootNum: rootNum)
    case .major7th:
      keySwitcher.major7th(rootNum: rootNum)
    }
  }
  
  var noteName: String { keyName.rawValue }
  
  init(rootNum: NoteNum = .zero, enharmonic: EnharmonicSymbol = .flat, degree: Degree) {
    self.rootNum = rootNum
    self.enharmonic = enharmonic
    self.degree = degree
  }
  
  init(_ degree: Degree = .root, of root: RootKeyNote) {
    self.enharmonic = root.keyName.enharmonic
    self.degree = degree
    self.rootNum = root.keyName.noteNum
  }
  
  init(_ root: RootKeyNote) {
    self.enharmonic = root.keyName.enharmonic
    self.rootNum = root.keyName.noteNum
    self.degree = .root
  }
  
  init(_ keyName: KeyName = .c, degree: Degree = .root) {
    self.enharmonic = keyName.enharmonic
    self.degree = degree
    self.rootNum = NoteNum(keyName.noteNum.rawValue.minusDeg(degree.noteNum.rawValue))
    
  }
  
  mutating func kSW(keySwitcher: KeySwitcher) {
    switch noteNum {
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
    
    return Note(rootNum: noteNum, enharmonic: newEnharm, degree: degree)
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
}

extension Note: Equatable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.noteNum == rhs.noteNum
  }
}

extension Note {
  func isEnharmonicEquivalent(to note: Note) -> Bool {
    if self.noteNum == note.noteNum && self.noteName != note.noteName {
      return true
    } else {
      return false
    }
  }
  
  static func enharmonicEquivalents (lhs: Note, rhs: Note) -> Bool {
    if lhs.noteNum == rhs.noteNum && lhs.noteName != rhs.noteName {
      return true
    } else {
      return false
    }
  }
}

extension Note: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(noteNum)
  }
}
