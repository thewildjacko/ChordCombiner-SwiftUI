//
//  ChromaticScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct ChromaticScale: ScaleDetails {
  var chromaticRC: ResultChord?
  let scaleType: ScaleType = .chromatic
  var baseType: FNCType
  var root: Root
  var mode: Mode.SevenDeg = .one
  var enharm: Enharmonic
  
  var scaleName: String = "Tension/Polychord"
  
  var name: String {
    if let rc = chromaticRC {
      return rc.upStrctTriad.name + "/" + rc.baseChord.name
    } else {
      fatalError("couldn't find RC!")
    }
  }
  
  var romanNum: String = ""
  
  var allNotes: [Note] {
    get {
      switch baseType {
      case .dom7:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Min3(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Sh_4(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Maj6(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      case .ma7:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Min3(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Sh_4(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Maj6(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      case .mi7:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Min3(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Dim5(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Maj6(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      case .mi7_b5:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Min3(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Dim5(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Maj6(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      case .dim7:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Min3(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Dim5(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Dim7(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      case .ma6:
        return [Root(rootKey),
                Min9(rootKey),
                Maj2(rootKey),
                Sh_9(rootKey),
                Maj3(rootKey),
                P4(rootKey),
                Sh_4(rootKey),
                P5(rootKey),
                Min6(rootKey),
                Maj6(rootKey),
                Min7(rootKey),
                Maj7(rootKey)]
      }
    }
    set {
      ()
    }
  }
  
  var parentScale: ScaleDetails {
    return self
  }
  
  init(_ root: RootGen, chromaticRC: ResultChord?) {
    self.root = Root(root)
    self.chromaticRC = chromaticRC
    if let rc = chromaticRC {
      self.baseType = rc.baseChord.type
    } else {
      fatalError("couldn't find RC!")
    }
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
  }
  
  mutating func shiftMode(by offset: Int) {
  }
  
  func enharmSwapped() -> ScaleDetails {
    let newRoot = root.enharmSwapped()
    let newRootKey = RootGen(newRoot.key)
    if let rc = chromaticRC {
      return ChromaticScale(newRootKey, chromaticRC: rc)
    } else {
      fatalError("couldn't find RC!")
    }
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return [self]
  }
  
  func getParentModes() -> [ScaleDetails] {
    return [self]
  }
}
