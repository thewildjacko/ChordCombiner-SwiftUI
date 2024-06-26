//
//  HalfWholeDimFlat13Scale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct HalfWholeDimFlat13Scale: ScaleDetails {
  let scaleType = ScaleType.halfWholeDim_b13
  
  var root: Root
  var shadowMode: Mode.SingleDeg
  var mode: Mode.SevenDeg {
    return Mode.SevenDeg(shadowMode.rawValue)
  }
  
  var enharm: Enharmonic
  
  var note1: Note {
    return Min9(rootKey)
  }
  
  var note2: Note {
    return Sh_9(rootKey)
  }
  
  var note3: Note {
    return Maj3(rootKey)
  }
  
  var note4: Note {
    return Sh_4(rootKey)
  }
  
  var note5: Note {
    return P5(rootKey)
  }
  
  var note6: Note {
    return Min6(rootKey)
  }
  
  var note7: Note {
    return Min7(rootKey)
  }
  
  var scaleName: String {
    return "Half-whole diminished (♭13)"
  }
  
  var name: String {
    return root.noteName + " " + scaleName
  }
  
  var romanNum: String {
    return "I"
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
  
  init(_ root: RootGen, shadowMode: Mode.SingleDeg = .one) {
    self.root = Root(root)
    self.shadowMode = shadowMode
    self.enharm = root.r.enharm
  }
  
  func translated(by offset: Int) -> ScaleDetails {
    let num = root.num.plusDeg(offset)
    let noteNum = NoteNum(num)
    let newRoot = Root(noteNum: noteNum)
    let newRootKey = RootGen(newRoot.key)
    
    return HalfWholeDimFlat13Scale(newRootKey, shadowMode: shadowMode)
  }
  
  mutating func switchMode(mode: Mode.SevenDeg) {
    self.shadowMode = Mode.SingleDeg.one
  }
  
  mutating func shiftMode(by offset: Int) {
    self.shadowMode = Mode.SingleDeg.one
  }
  
  func enharmSwapped() -> ScaleDetails {
    let newRoot = root.enharmSwapped()
    let newRootKey = RootGen(newRoot.key)
    
    return HalfWholeDimFlat13Scale(newRootKey, shadowMode: shadowMode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return [self]
  }
  
  func getParentModes() -> [ScaleDetails] {
    return [self]
  }
}
