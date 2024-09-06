//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

struct Note: NoteProtocol, KSwitch, CustomStringConvertible {
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
      ks.root(rootNum: rootNum)
    }
    set {
      
    }
  }
  
  var key: KeyName {
    switch degree {
    case .root:
      ks.root(rootNum: rootNum)
    case .minor9th:
      ks.minor9th(rootNum: rootNum)
    case .major9th:
      ks.major9th(rootNum: rootNum)
    case .sharp9th:
      ks.sharp9th(rootNum: rootNum)
    case .minor3rd:
      ks.minor3rd(rootNum: rootNum)
    case .major3rd:
      ks.major3rd(rootNum: rootNum)
    case .perfect4th:
      ks.perfect4th(rootNum: rootNum)
    case .sharp4th:
      ks.sharp4th(rootNum: rootNum)
    case .dim5th:
      ks.dim5th(rootNum: rootNum)
    case .perfect5th:
      ks.perfect5th(rootNum: rootNum)
    case .sharp5th:
      ks.sharp5th(rootNum: rootNum)
    case .minor6th:
      ks.minor6th(rootNum: rootNum)
    case .major6th:
      ks.major6th(rootNum: rootNum)
    case .dim7th:
      ks.dim7th(rootNum: rootNum)
    case .minor7th:
      ks.minor7th(rootNum: rootNum)
    case .major7th:
      ks.major7th(rootNum: rootNum)
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
  
  mutating func kSW(ks: KeySwitch) {
    switch noteNum {
    case .zero:
      self.rootKey = ks.pickKey(.c, .bSh, .c, .c)
    case .one:
      self.rootKey = ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .two:
      self.rootKey = .d
    case .three:
      self.rootKey = ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .four:
      self.rootKey = ks.pickKey(.fB, .e, .fB, .e)
    case .five:
      self.rootKey = ks.pickKey(.f, .eSh, .f, .f)
    case .six:
      self.rootKey = ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .seven:
      self.rootKey = .g
    case .eight:
      self.rootKey = ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .nine:
      self.rootKey = .a
    case .ten:
      self.rootKey = ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .eleven:
      self.rootKey = ks.pickKey(.cB, .b, .b, .b)
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
    kSW(ks: KeySwitch(enharm: enharm))
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
