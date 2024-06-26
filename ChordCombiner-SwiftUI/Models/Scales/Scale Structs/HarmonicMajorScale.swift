//
//  HarmonicMajorScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct HarmonicMajorScale: ScaleDetails {
  let scaleType = ScaleType.harmonicMajor
  
  var root: Root
  var mode: Mode.SevenDeg
  var enharm: Enharmonic
  
  // w w h w h m3 h
  // w h w h m3 h w
  // h w h m3 h w w
  // w h m3 h w w h
  // h m3 h w w h w
  // m3 h w w h w h
  // h w w h w h m3
  
  var note1: Note {
    switch mode {
    case .one, .two, .four:
      return Maj2(rootKey)
    case .three, .five, .seven:
      return Min9(rootKey)
    case .six:
      return Sh_9(rootKey)
    }
  }
  
  var note2: Note {
    switch mode {
    case .one, .five, .six:
      return Maj3(rootKey)
    case .two, .four, .seven:
      return Min3(rootKey)
    case .three:
      return Sh_9(rootKey)
      
    }
  }
  
  var note3: Note {
    switch mode {
    case .one, .two, .five, .seven:
      return P4(rootKey)
    case .four, .six:
      return Sh_4(rootKey)
    case .three:
      return Maj3(rootKey)
    }
  }
  
  var note4: Note {
    switch mode {
    case .one, .three, .four, .five:
      return P5(rootKey)
    case .six:
      return Sh_5(rootKey)
    case .two, .seven:
      return Dim5(rootKey)
    }
  }
  
  var note5: Note {
    switch mode {
    case .two, .four, .five, .six:
      return Maj6(rootKey)
    case .one, .three, .seven:
      return Min6(rootKey)
    }
  }
  
  var note6: Note {
    switch mode {
    case .one, .four, .six:
      return Maj7(rootKey)
    case .two, .three, .five:
      return Min7(rootKey)
    case .seven:
      return Dim7(rootKey)
    }
  }
  
  var scaleName: (short: String, long: String) {
    switch mode {
    case .one:
      return (short: "Harmonic major", long: "Harmonic major")
    case .two:
      return (short: "Dorian (♭5)", long: "Dorian (♭5)")
    case .three:
      return (short: "Altered (P5)", long: "Altered (P5)")
    case .four:
      return (short: "Melodic minor (♯4)", long: "Melodic minor (♯4)")
    case .five:
      return (short: "Mixolydian (♭2)", long: "Mixolydian (♭2)")
    case .six:
      return (short: "Lydian augmented (♭2)", long: "Lydian augmented (♭2)")
    case .seven:
      return (short: "Locrian (˚7)", long: "Locrian (˚7)")
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
      return "iv"
    case .five:
      return "V"
    case .six:
      return "VI"
    case .seven:
      return "vii"
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
      return HarmonicMajorScale(RootGen(allNotes[6].key))
    case .three:
      return HarmonicMajorScale(RootGen(allNotes[5].key))
    case .four:
      return HarmonicMajorScale(RootGen(allNotes[4].key))
    case .five:
      return HarmonicMajorScale(RootGen(allNotes[3].key))
    case .six:
      return HarmonicMajorScale(RootGen(allNotes[2].key))
    case .seven:
      return HarmonicMajorScale(RootGen(allNotes[1].key))
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
    
    return HarmonicMajorScale(newRootKey, mode: mode)
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
    
    return HarmonicMajorScale(newRootKey, mode: mode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return Mode.SevenDeg.allCases.map {HarmonicMajorScale(root, mode: $0)}
  }
  
  func getParentModes() -> [ScaleDetails] {
    var parentModes = [HarmonicMajorScale]()
    for (index, tonic) in parentScale.allNotes.enumerated() {
      parentModes.append(HarmonicMajorScale(RootGen(tonic.key), mode: Mode.SevenDeg.allCases[index]))
    }
    return parentModes
  }
}
