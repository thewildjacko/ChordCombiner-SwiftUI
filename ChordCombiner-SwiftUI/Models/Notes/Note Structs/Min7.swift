//
//  Min7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Min7: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Min7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(10))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.mi7), short: DegName.Short.mi7, long: DegName.Long(.mi7))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.bB, .aSh)
    case .one:
      return ks.pickKey(.cB, .b)
    case .two:
      return .c
    case .three:
      return ks.pickKey(.dB, .cSh)
    case .four:
      return ks.pickKey(.e_bb, .d)
    case .five:
      return ks.pickKey(.eB, .dSh)
    case .six:
      return ks.pickKey(.fB, .e)
    case .seven:
      return .f
    case .eight:
      return ks.pickKey(.gB, .fSh)
    case .nine:
      return .g
    case .ten:
      return ks.pickKey(.aB, .gSh)
    case .eleven:
      return ks.pickKey(.b_bb, .a)
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
    return Min7(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
