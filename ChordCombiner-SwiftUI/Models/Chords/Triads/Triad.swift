//
//  Triad.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 5/24/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation
import UIKit

struct Triad: ChordProtocol, CustomStringConvertible {
  var id = UUID()
  
  var type: TriadType {
    didSet {
      refresh()
    }
  }
  
  var chordName: String {
    return type.name
  }
  
  var enharm: Enharmonic
  
  var noteCount: Int {
    return 3
  }
  
  var chordInversion: TriadInversion
  
  var inversion: ChordInversion {
    get {
      return chordInversion
    }
    set {
      chordInversion = newValue as! TriadInversion
    }
  }
  
  var qualSuffix: QualProtocol {
    get {
      return type
    }
    set {
      type = newValue as! TriadType
    }
  }
  
  var root: Root
  
  var note1: Note {
    get {
      switch type {
      case .ma, .aug:
        return Maj3(rootKey)
      case .mi, .dim:
        return Min3(rootKey)
      case .sus4:
        return P4(rootKey)
      case .sus2:
        return Maj2(rootKey)
      }
    }
    set {
      ()
    }
  }
  
  var note2: Note {
    get {
      switch type {
      case .ma, .mi, .sus4, .sus2:
        return P5(rootKey)
      case .dim:
        return Dim5(rootKey)
      case .aug:
        return Sh_5(rootKey)
      }
    }
    set {
      ()
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
  
  var stats: (Letter, RootAcc, TriadType)
  
  var description: String {
    return """
        Triad:
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
  
  init(rootNum: NoteNum = .zero, type: TriadType = .ma, enharm: Enharmonic = .flat, inversion: TriadInversion = .root) {
    self.type = type
    self.enharm = enharm
    self.root = Root(noteNum: rootNum, enharm: enharm)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    self.stats = (letter, accidental, type)
    
    self.chordInversion = inversion
    invertTo(inversion: inversion.num)
  }
  
  init(_ rootKey: RootGen = .c, _ type: TriadType = .ma, inversion: TriadInversion = .root) {
    self.type = type
    self.enharm = rootKey.r.enharm
    self.root = Root(rootKey)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    self.stats = (letter, accidental, type)
    
    self.chordInversion = inversion
    invertTo(inversion: inversion.num)
  }
  
  func locationInChord(rootName: String, at location: String, of root: Root) -> String {
    return "\(rootName)\(Suffix.LongUpper(type: self.type).quality) triad on the \(location) of \(root.noteName)"
  }
  
  func translated(by offset: Int) -> ChordProtocol {
    return Triad(rootNum: NoteNum(root.num.plusDeg(offset)), type: type, enharm: enharm)
  }
  
  func enharmSwapped() -> ChordProtocol {
    return Triad(rootNum: root.noteNum, type: type, enharm: enharm == .flat ? .sharp : .flat)
  }
  
  mutating func invertTo(inversion: FNCInversion) {
    switch inversion {
    case .root, .third:
      self.allNotes = [root, note1, note2]
    case .first:
      self.allNotes = [note1, note2, root]
    case .second:
      self.allNotes = [note2, root, note1]
    }
    self.inversion = TriadInversion(inversion.num)
  }
  
  mutating func convertTo(type: TriadType) {
    self.type = type
  }
  
  mutating func getAndSetInversion() {
    for (index, _) in allNotes.enumerated() {
      if let _ = allNotes[index] as? Root {
        switch index {
        case 1:
          self.inversion = TriadInversion.second
        case 2:
          self.inversion = TriadInversion.first
        default:
          self.inversion = TriadInversion.root
        }
      }
    }
  }
  
  mutating func refresh() {
    self = Triad(RootGen(letter, accidental), type, inversion: inversion as! Triad.TriadInversion)
  }
}

extension Triad: Equatable {
  static func == (lhs: Triad, rhs: Triad) -> Bool {
    return lhs.type == rhs.type && lhs.root == rhs.root
  }
}
