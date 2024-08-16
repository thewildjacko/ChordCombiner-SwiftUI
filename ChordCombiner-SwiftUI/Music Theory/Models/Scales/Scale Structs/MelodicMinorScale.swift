//
//  MelodicMinorScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct MelodicMinorScale: ScaleDetails {
  let scaleType = ScaleType.melodicMinor
  
  static let roots = RootGen.minorRoots
  static let excludedRoots = RootGen.minorExclusions
  static let inAllKeys: [ScaleDetails] = roots.map { MelodicMinorScale($0) }
  
  var root: Root
  var mode: Mode.SevenDeg
  var enharm: Enharmonic
  
  // w h w w w w h
  // h w w w w h w
  // w w w w h w h
  // w w w h w h w
  // w w h w h w w
  // w h w h w w w
  // h w h w w w w
  
  var note1: Note {
    switch mode {
    case .one, .three, .four, .five, .six:
      return Maj2(rootKey)
    case .two, .seven:
      return Min9(rootKey)
    }
  }
  
  var note2: Note {
    switch mode {
    case .one, .two, .six, .seven:
      return Min3(rootKey)
    case .three, .four, .five:
      return Maj3(rootKey)
    }
  }
  
  var note3: Note {
    switch mode {
    case .one, .two, .five, .six:
      return P4(rootKey)
    case .three, .four:
      return Sh_4(rootKey)
    case .seven:
      return Maj3(rootKey)
    }
  }
  
  var note4: Note {
    switch mode {
    case .one, .two, .four, .five:
      return P5(rootKey)
    case .three:
      return Sh_5(rootKey)
    case .six:
      return Dim5(rootKey)
    case .seven:
      return Sh_4(rootKey)
    }
  }
  
  var note5: Note {
    switch mode {
    case .one, .two, .three, .four:
      return Maj6(rootKey)
    case .five, .six:
      return Min6(rootKey)
    case .seven:
      return Sh_5(rootKey)
    }
  }
  
  var note6: Note {
    switch mode {
    case .one, .three:
      return Maj7(rootKey)
    case .two, .four, .five, .six, .seven:
      return Min7(rootKey)
    }
  }
  
  var scaleName: (short: String, long: String) {
    switch mode {
    case .one:
      return (short: "Melodic minor", long: "Melodic minor")
    case .two:
      return (short: "Dorian ♭2", long: "Dorian ♭2")
    case .three:
      return (short: "Lydian augmented", long: "Lydian augmented")
    case .four:
      return (short: "Lydian dominant", long: "Lydian dominant")
    case .five:
      return (short: "Mixolydian ♭6", long: "Mixolydian ♭6")
    case .six:
      return (short: "Locrian ♯2", long: "Locrian ♯2")
    case .seven:
      return (short: "Altered dominant", long: "Altered dominant")
    }
  }
  
  var name: String {
    return root.noteName + " " + scaleName.short
  }
  
  var romanNum: String {
    switch mode {
    case .one:
      return "i"
    case .two:
      return "ii"
    case .three:
      return "III"
    case .four:
      return "IV"
    case .five:
      return "V"
    case .six:
      return "vi"
    case .seven:
      return "VII"
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
  
  var noteNums: [NoteNum] {
    return allNotes.map {NoteNum($0.noteNum.num.minusDeg(root.noteNum.num))}
  }
  
  var notesByNoteNum: [NoteNum:Note] {
    return Dictionary(uniqueKeysWithValues: zip(noteNums, allNotes))
  }
  
  var parentScale: ScaleDetails {
    switch mode {
    case .one:
      return self
    case .two:
      return MelodicMinorScale(RootGen(allNotes[6].key))
    case .three:
      return MelodicMinorScale(RootGen(allNotes[5].key))
    case .four:
      return MelodicMinorScale(RootGen(allNotes[4].key))
    case .five:
      return MelodicMinorScale(RootGen(allNotes[3].key))
    case .six:
      return MelodicMinorScale(RootGen(allNotes[2].key))
    case .seven:
      return MelodicMinorScale(RootGen(allNotes[1].key))
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
    
    return MelodicMinorScale(newRootKey, mode: mode)
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
    
    return MelodicMinorScale(newRootKey, mode: mode)
  }
  
  func getParallelModes(root: RootGen) -> [ScaleDetails] {
    return Mode.SevenDeg.allCases.map {MelodicMinorScale(root, mode: $0)}
  }
  
  func getParentModes() -> [ScaleDetails] {
    var parentModes = [MelodicMinorScale]()
    for (index, tonic) in parentScale.allNotes.enumerated() {
      parentModes.append(MelodicMinorScale(RootGen(tonic.key), mode: Mode.SevenDeg.allCases[index]))
    }
    return parentModes
  }
  
}
