//
//  FourNoteChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 5/24/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

struct FourNoteChord: ChordProtocol, CustomStringConvertible {
  var type: FNCType {
    didSet {
      refresh()
    }
  }
  
  var chordName: String {
    return type.name
  }
  
  var enharm: Enharmonic
  
  var noteCount: Int {
    return 4
  }
  
  var chordInversion: FNCInversion
  var inversion: ChordInversion {
    get {
      return chordInversion
    }
    set {
      chordInversion = newValue as! FNCInversion
    }
  }
  
  var qualSuffix: QualProtocol {
    get {
      return type
    }
    set {
      type = newValue as! FNCType
    }
  }
  
  var root: Root
  
  var note1: Note {
    switch type {
    case .ma7, .dom7, .ma6:
      return Maj3(rootKey)
    case .mi7, .mi7_b5, .dim7:
      return Min3(rootKey)
    }
  }
  
  var note2: Note {
    switch type {
    case .ma7, .dom7, .mi7, .ma6:
      return P5(rootKey)
    case .mi7_b5, .dim7:
      return Dim5(rootKey)
    }
  }
  
  var note3: Note {
    switch type {
    case .ma7:
      return Maj7(rootKey)
    case .dom7, .mi7, .mi7_b5:
      return Min7(rootKey)
    case .dim7:
      return Dim7(rootKey)
    case .ma6:
      return Maj6(rootKey)
    }
  }
  
  var allNotes: [Note] = []
  
  var convertedDegrees: [Int] = []
  
  var letter: Letter {
    didSet {
      refresh()
    }
  }
  
  var accidental: RootAcc {
    didSet {
      refresh()
    }
  }
  
  var stats: (Letter, RootAcc, FNCType)
  
  init(rootNum: NoteNum = .zero, type: FNCType = .dom7, enharm: Enharmonic = .flat, inversion: FNCInversion = .root) {
    self.type = type
    if type == .mi7 && [2, 7, 9].contains(rootNum.num) {
      self.enharm = .flat
    } else {
      self.enharm = enharm
    }
    self.root = Root(noteNum: rootNum, enharm: enharm)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    self.stats = (letter, accidental, type)
    
    self.chordInversion = inversion
    invertTo(inversion: inversion)
  }
  
  init(_ rootKey: RootGen = .c, _ type: FNCType = .dom7, inversion: FNCInversion = .root) {
    self.type = type
    if type == .mi7 && [2, 7, 9].contains(rootKey.r.num) {
      self.enharm = .flat
    } else {
      self.enharm = rootKey.r.enharm
    }
    self.root = Root(rootKey)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    self.stats = (letter, accidental, type)
    
    self.chordInversion = inversion
    invertTo(inversion: inversion)
  }
  
  func translated(by offset: Int) -> ChordProtocol {
    return FourNoteChord(rootNum: NoteNum(root.num.plusDeg(offset)), type: type, enharm: enharm)
  }
  
  func enharmSwapped() -> ChordProtocol {
    return FourNoteChord(rootNum: root.noteNum, type: type, enharm: enharm == .flat ? .sharp : .flat)
  }
  
  mutating func getAndSetInversion() {
    for (index, _) in allNotes.enumerated() {
      if let _ = allNotes[index] as? Root {
        switch index {
        case 1:
          self.inversion = FNCInversion.second
        case 2:
          self.inversion = FNCInversion.first
        case 3:
          self.inversion = FNCInversion.third
        default:
          self.inversion = FNCInversion.root
        }
      }
    }
  }
  
  mutating func invertTo(inversion: FNCInversion) {
    switch inversion {
    case .root:
      self.allNotes = [root, note1, note2, note3]
    case .first:
      self.allNotes = [note1, note2, note3, root]
    case .second:
      self.allNotes = [note2, note3, root, note1]
    case .third:
      self.allNotes = [note3, root, note1, note2]
    }
    self.chordInversion = inversion
  }
  
  mutating func convertTo(type: FNCType) {
    self.type = type
  }
  
  mutating func refresh() {
    self = FourNoteChord(RootGen(letter, accidental), type, inversion: inversion as! FourNoteChord.FNCInversion)
  }
  
  var description: String {
    return """
        Four Note Chord:
        \troot: \(root.noteName)
        \tletter: \(rootKey.r.letter)
        \taccidental: \(key.accidental)
        \tenharmonic: \(root.enharm)
        \tkey: \(key)
        \ttype: \(type)
        \tname: \(name)
        \tdegrees: \(degrees)
        \tconvertedDegrees: \(convertedDegrees)
        \tnotes: \(noteNames.joined(separator: " "))
        """
  }
}

extension FourNoteChord: Equatable {
  static func == (lhs: FourNoteChord, rhs: FourNoteChord) -> Bool {
    return lhs.type == rhs.type && lhs.root == rhs.root
  }
}
