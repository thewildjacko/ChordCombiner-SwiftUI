//
//  DiminishedScale.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct DiminishedScale: ScaleDetails {
  let scaleType = ScaleType.diminished
  
  var root: Root
  var shadowMode: Mode.TwoDeg
  var mode: Mode.SevenDeg {
    return .one
  }
  
  var enharm: Enharmonic
  
  // h w h w h w h w
  // w h w h w h w h
  
  var note1: Note {
    switch shadowMode {
    case .one:
      return Min9(rootKey)
    default:
      return Maj2(rootKey)
    }
  }
  
  var note2: Note {
    switch shadowMode {
    case .one:
      return Sh_9(rootKey)
    default:
      return Min3(rootKey)
    }
  }
  
  var note3: Note {
    switch shadowMode {
    case .one:
      return Maj3(rootKey)
    default:
      return P4(rootKey)
    }
  }
  
  var note4: Note {
    switch shadowMode {
    case .one:
      return Sh_4(rootKey)
    default:
      return Dim5(rootKey)
    }
  }
  
  var note5: Note {
    switch shadowMode {
    case .one:
      return P5(rootKey)
    default:
      return Min6(rootKey)
    }
  }
  
  var note6: Note {
    switch shadowMode {
    case .one:
      return Maj6(rootKey)
    default:
      return Dim7(rootKey)
    }
  }
  
  var note7: Note {
    switch shadowMode {
    case .one:
      return Min7(rootKey)
    default:
      return Maj7(rootKey)
    }
  }
  
  var scaleName: String {
    switch shadowMode {
    case .one:
      return "Half-whole diminished"
    default:
      return "Whole-half diminished"
    }
  }
  
  var name: String {
    return root.noteName + " " + scaleName
  }
  
  var romanNum: String {
    switch shadowMode {
    case .one:
      return "I"
    default:
      return "ii"
    }
  }
  
  var allNotes: [Note] {
    get {
      return [root, note1, note2, note3, note4, note5, note6, note7]
    }
    set {
      ()
    }
  }
  
  var parentScale: ScaleDetails {
    return self
  }
  
  init(_ root: RootGen, shadowMode: Mode.TwoDeg = .one) {
    self.root = Root(root)
    self.shadowMode = shadowMode
    self.enharm = root.r.enharm
  }
  
  func translated(by offset: Int) -> ScaleDetails {
    let num = root.num.plusDeg(offset)
    let noteNum = NoteNum(num)
    let newRoot = Root(noteNum: noteNum)
    let newRootKey = RootGen(newRoot.key)
    
    return DiminishedScale(newRootKey, shadowMode: shadowMode)
  }
  
  mutating func switchMode(mode: Mode.SevenDeg) {
    let modeNum = mode.rawValue % 2
    self.shadowMode = Mode.TwoDeg(modeNum)
  }
  
  mutating func shiftMode(by offset: Int) {
    let modeOffset = (mode.rawValue + offset).degreeInMode(modeLength: 2)
    self.shadowMode = Mode.TwoDeg(modeOffset)
  }
  
  func enharmSwapped() -> ScaleDetails {
    let newRoot = root.enharmSwapped()
    let newRootKey = RootGen(newRoot.key)
    
    return DiminishedScale(newRootKey, shadowMode: shadowMode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return Mode.TwoDeg.allCases.map {DiminishedScale(root, shadowMode: $0)}
  }
  
  func getParentModes() -> [ScaleDetails] {
    var parentModes = [DiminishedScale]()
    for (index, tonic) in parentScale.allNotes.enumerated() {
      parentModes.append(DiminishedScale(RootGen(tonic.key), shadowMode: Mode.TwoDeg.allCases[index]))
    }
    return parentModes
  }
}
