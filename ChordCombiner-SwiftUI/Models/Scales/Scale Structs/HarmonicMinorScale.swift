//
//  HarmonicMinorScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct HarmonicMinorScale: ScaleDetails {
  let scaleType = ScaleType.harmonicMinor
  
  var root: Root
  var mode: Mode.SevenDeg
  var enharm: Enharmonic
  
  // w h w w h m3 h
  // h w w h m3 h w
  // w w h m3 h w h
  // w h m3 h w h w
  // h m3 h w h w w
  // m3 h w h w w h
  // h w h w w h m3
  
  var note1: Note {
    switch mode {
    case .one, .three, .four:
      return Maj2(rootKey)
    case .two, .five, .seven:
      return Min9(rootKey)
    case .six:
      return Sh_9(rootKey)
    }
  }
  
  var note2: Note {
    switch mode {
    case .three, .five, .six:
      return Maj3(rootKey)
    case .one, .two, .four, .seven:
      return Min3(rootKey)
    }
  }
  
  var note3: Note {
    switch mode {
    case .one, .two, .five:
      return P4(rootKey)
    case .three, .four, .six:
      return Sh_4(rootKey)
    case .seven:
      return Maj3(rootKey)
    }
  }
  
  var note4: Note {
    switch mode {
    case .one, .four, .five, .six:
      return P5(rootKey)
    case .three:
      return Sh_5(rootKey)
    case .two, .seven:
      return Dim5(rootKey)
    }
  }
  
  var note5: Note {
    switch mode {
    case .two, .three, .four, .six:
      return Maj6(rootKey)
    case .one, .five, .seven:
      return Min6(rootKey)
    }
  }
  
  var note6: Note {
    switch mode {
    case .one, .three, .six:
      return Maj7(rootKey)
    case .two, .four, .five:
      return Min7(rootKey)
    case .seven:
      return Dim7(rootKey)
    }
  }
  
  var scaleName: (short: String, long: String) {
    switch mode {
    case .one:
      return (short: "Harmonic minor", long: "Harmonic minor")
    case .two:
      return (short: "Locrian (♯6)", long: "Locrian (♯6)")
    case .three:
      return (short: "Major (♯5)", long: "Major (♯5)")
    case .four:
      return (short: "Dorian (♯4)", long: "Dorian (♯4)")
    case .five:
      return (short: "Mixolydian (♭2♭13)", long: "Mixolydian (♭2♭13)")
    case .six:
      return (short: "Lydian (♭2)", long: "Lydian (♭2)")
    case .seven:
      return (short: "Altered (˚7)", long: "Altered (˚7)")
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
      return HarmonicMinorScale(RootGen(allNotes[6].key))
    case .three:
      return HarmonicMinorScale(RootGen(allNotes[5].key))
    case .four:
      return HarmonicMinorScale(RootGen(allNotes[4].key))
    case .five:
      return HarmonicMinorScale(RootGen(allNotes[3].key))
    case .six:
      return HarmonicMinorScale(RootGen(allNotes[2].key))
    case .seven:
      return HarmonicMinorScale(RootGen(allNotes[1].key))
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
    
    return HarmonicMinorScale(newRootKey, mode: mode)
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
    
    return HarmonicMinorScale(newRootKey, mode: mode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return Mode.SevenDeg.allCases.map {HarmonicMinorScale(root, mode: $0)}
  }
  
  func getParentModes() -> [ScaleDetails] {
    var parentModes = [HarmonicMinorScale]()
    for (index, tonic) in parentScale.allNotes.enumerated() {
      parentModes.append(HarmonicMinorScale(RootGen(tonic.key), mode: Mode.SevenDeg.allCases[index]))
    }
    return parentModes
  }
}
