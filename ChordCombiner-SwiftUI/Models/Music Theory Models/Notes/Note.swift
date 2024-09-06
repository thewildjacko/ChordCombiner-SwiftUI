//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

struct Note: NoteProtocol, KeySwitch, CustomStringConvertible {
  var description: String {
    return "\(degree.name) (\(noteName))"
  }
  
  var noteNum: NoteNum {
    get {
      degree.noteNum.plusDeg(rootNum)
    }
    set { }
  }
  
  var rootNum: NoteNum
  
  var enharm: Enharmonic
  
  var degName: (name: String, short: String, long: String) {
    return (name: degree.name, short: degree.short, long: degree.long)
  }
  
  var degree: Degree
  
  var rootKey: KeyName {
    get {
      keySwitcher.root(rootNum: rootNum)
    }
    set {
      
    }
  }
  
  var key: KeyName {
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
  
  init(rootNum: NoteNum = .zero, enharm: Enharmonic = .flat, degree: Degree) {
    self.rootNum = rootNum
    self.enharm = enharm
    self.degree = degree
  }
  
  init(_ degree: Degree = .root, of root: RootGen) {
    self.enharm = root.keyName.enharm
    self.degree = degree
    self.rootNum = root.keyName.noteNum
  }
  
  init(_ root: RootGen) {
    self.enharm = root.keyName.enharm
    self.rootNum = root.keyName.noteNum
    self.degree = .root
  }
  
  init(_ key: KeyName = .c, degree: Degree = .root) {
    self.enharm = key.enharm
    self.degree = degree
    self.rootNum = NoteNum(key.noteNum.rawValue.minusDeg(degree.noteNum.rawValue))
    
  }
  
  mutating func kSW(keySwitcher: KeySwitcher) {
    switch noteNum {
    case .zero:
      self.rootKey = keySwitcher.pickKey(.c, .bSh, .c, .c)
    case .one:
      self.rootKey = keySwitcher.pickKey(.dB, .cSh, .dB, .cSh)
    case .two:
      self.rootKey = .d
    case .three:
      self.rootKey = keySwitcher.pickKey(.eB, .dSh, .eB, .dSh)
    case .four:
      self.rootKey = keySwitcher.pickKey(.fB, .e, .fB, .e)
    case .five:
      self.rootKey = keySwitcher.pickKey(.f, .eSh, .f, .f)
    case .six:
      self.rootKey = keySwitcher.pickKey(.gB, .fSh, .gB, .fSh)
    case .seven:
      self.rootKey = .g
    case .eight:
      self.rootKey = keySwitcher.pickKey(.aB, .gSh, .aB, .gSh)
    case .nine:
      self.rootKey = .a
    case .ten:
      self.rootKey = keySwitcher.pickKey(.bB, .aSh, .bB, .aSh)
    case .eleven:
      self.rootKey = keySwitcher.pickKey(.cB, .b, .b, .b)
    }
  }
  
  func enharmSwapped() -> NoteProtocol {
    var newEnharm: Enharmonic {
      switch enharm {
      case .flat, .sharp:
        return enharm == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Note(rootNum: noteNum, enharm: newEnharm, degree: degree)
  }
  
  mutating func swapEnharm() {
    switch enharm {
    case .flat, .sharp:
      enharm = enharm == .flat ? .sharp : .flat
    case .blackKeyFlats, .blackKeySharps:
      enharm = enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
    }
    kSW(keySwitcher: KeySwitcher(enharm: enharm))
  }
  
  mutating func switchEnharm(to enharm: Enharmonic) {
    self.enharm = enharm
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
