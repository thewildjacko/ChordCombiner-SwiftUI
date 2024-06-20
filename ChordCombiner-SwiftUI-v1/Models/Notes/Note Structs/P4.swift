//
//  P4.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct P4: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "P4 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(5))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.p4), short: DegName.Short.p4, long: DegName.Long(.p4))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.f, .eSh)
    case .one:
      return ks.pickKey(.gB, .fSh)
    case .two:
      return .g
    case .three:
      return ks.pickKey(.aB, .gSh)
    case .four:
      return ks.pickKey(.b_bb, .a)
    case .five:
      return ks.pickKey(.bB, .aSh)
    case .six:
      return ks.pickKey(.cB, .b)
    case .seven:
      return .c
    case .eight:
      return ks.pickKey(.dB, .cSh)
    case .nine:
      return .d
    case .ten:
      return ks.pickKey(.eB, .dSh)
    case .eleven:
      return ks.pickKey(.fB, .e)
    }
  }
  
  init(rootNum: NoteNum = .zero, enharm: Enharmonic = .flat) {
    self.rootNum = rootNum
    self.enharm = enharm
  }
  
  init(_ root: RootGen) {
    self.rootNum = root.r.noteNum
    self.enharm = root.r.enharm
  }
  
  mutating func swapEnharm() {
    enharm = enharm == .flat ? .sharp : .flat
  }
  
  func enharmSwapped() -> Note {
    return P4(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
