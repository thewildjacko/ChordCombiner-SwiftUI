//
//  MajorScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct MajorScale: ScaleDetails {
  let scaleType: ScaleType = .major
  
  var root: Root
  var mode: Mode.SevenDeg
  var enharm: Enharmonic
  
  var note1: Note {
    switch mode {
    case .one, .two, .four, .five, .six:
      return Maj2(rootKey)
    case .three, .seven:
      return Min9(rootKey)
    }
  }
  
  var note2: Note {
    switch mode {
    case .one, .four, .five:
      return Maj3(rootKey)
    case .two, .three, .six, .seven:
      return Min3(rootKey)
    }
  }
  
  var note3: Note {
    switch mode {
    case .one, .two, .three, .five, .six, .seven:
      return P4(rootKey)
    case .four:
      return Sh_4(rootKey)
    }
  }
  
  var note4: Note {
    switch mode {
    case .one, .two, .three, .four, .five, .six:
      return P5(rootKey)
    case .seven:
      return Dim5(rootKey)
    }
  }
  
  var note5: Note {
    switch mode {
    case .one, .two, .four, .five:
      return Maj6(rootKey)
    case .three, .six, .seven:
      return Min6(rootKey)
    }
  }
  
  var note6: Note {
    switch mode {
    case .one, .four:
      return Maj7(rootKey)
    case .two, .three, .five, .six, .seven:
      return Min7(rootKey)
    }
  }
  
  var scaleName: (short: String, long: String) {
    switch mode {
    case .one:
      return (short: "Major", long: "Major (ionian)")
    case .two:
      return (short: "Dorian", long: "Dorian")
    case .three:
      return (short: "Phrygian", long: "Phrygian")
    case .four:
      return (short: "Lydian", long: "Lydian")
    case .five:
      return (short: "Mixolydian", long: "Mixolydian")
    case .six:
      return (short: "Minor", long: "Natural minor (aeolian)")
    case .seven:
      return (short: "Locrian", long: "Locrian")
    }
  }
  
  var name: String {
    return root.noteName + " " + scaleName.short
  }
  
  var romanNum: String {
    switch mode {
    case .one:
      return "I"
    case .two:
      return "ii"
    case .three:
      return "iii"
    case .four:
      return "IV"
    case .five:
      return "V"
    case .six:
      return "vi"
    case .seven:
      return "vii"
    }
  }
  
  enum RomanNum: String, CaseIterable {
    case I, ii, iii, IV, V, vi, vii
    
    init(deg: Int) {
      switch deg {
      case 0:
        self = .I
      case 1:
        self = .ii
      case 2:
        self = .iii
      case 3:
        self = .IV
      case 4:
        self = .V
      case 5:
        self = .vi
      case 6:
        self = .vii
      default:
        self = .I
      }
    }
  }
  
  var allNotes: [Note] {
    get {
      return [root, note1, note2, note3, note4, note5, note6]
    }
    set {
      ()
    }
  }
  
  var parentScale: ScaleDetails {
    switch mode {
    case .one:
      return self
    case .two:
      return MajorScale(RootGen(allNotes[6].key))
    case .three:
      return MajorScale(RootGen(allNotes[5].key))
    case .four:
      return MajorScale(RootGen(allNotes[4].key))
    case .five:
      return MajorScale(RootGen(allNotes[3].key))
    case .six:
      return MajorScale(RootGen(allNotes[2].key))
    case .seven:
      return MajorScale(RootGen(allNotes[1].key))
    }
  }
  
  init(_ root: RootGen, mode: Mode.SevenDeg = .one) {
    self.root = Root(root)
    self.mode = mode
    self.enharm = root.r.enharm
  }
  
  func translated(by offset: Int) -> ScaleDetails {
    let num = root.num.plusDeg(offset)
    let noteNum = NoteNum(num)
    let newRoot = Root(noteNum: noteNum)
    let newRootKey = RootGen(newRoot.key)
    
    return MajorScale(newRootKey, mode: mode)
  }
  
  mutating func switchMode(mode: Mode.SevenDeg) {
    self.mode = mode
  }
  
  mutating func shiftMode(by offset: Int) {
    let modeOffset = (mode.rawValue + offset).degreeInMode(modeLength: 7)
    self.mode = Mode.SevenDeg(modeOffset)
  }
  
  func enharmSwapped() -> ScaleDetails {
    let newRoot = root.enharmSwapped()
    let newRootKey = RootGen(newRoot.key)
    
    return MajorScale(newRootKey, mode: mode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return Mode.SevenDeg.allCases.map {MajorScale(root, mode: $0)}
  }
  
  mutating func shiftNeighborMode(to newRoot: RootGen) {
    if let rootIndex = parentScale.allNotes.firstIndex(where: { $0.num == self.root.num }), let otherRootIndex = parentScale.allNotes.firstIndex(where: { $0.num == newRoot.r.num }) {
      print(rootIndex, otherRootIndex)
      let diff = otherRootIndex - rootIndex
      print(diff)
      let newRootNum = (rootIndex + diff) % 7
      let newNoteNum = parentScale.allNotes[newRootNum].noteNum
      let newRoot = Root(noteNum: newNoteNum, enharm: enharm)
      print(newRoot)
      self.shiftMode(by: diff)
      self.root = newRoot
    }
  }
  
  func getParentModes() -> [ScaleDetails] {
    var parentModes = [MajorScale]()
    for (index, tonic) in parentScale.allNotes.enumerated() {
      parentModes.append(MajorScale(RootGen(tonic.key), mode: Mode.SevenDeg.allCases[index]))
    }
    return parentModes
  }
}

