//
//  Min9.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Min9: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Min9 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(1))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.mi9), short: DegName.Short.mi9, long: DegName.Long(.mi9))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.dB, .cSh)
    case .one:
      return ks.pickKey(.e_bb, .d)
    case .two:
      return .eB
    case .three:
      return ks.pickKey(.fB, .e)
    case .four:
      return ks.pickKey(.g_bb, .f)
    case .five:
      return ks.pickKey(.gB, .fSh)
    case .six:
      return ks.pickKey(.a_bb, .g)
    case .seven:
      return .aB
    case .eight:
      return ks.pickKey(.b_bb, .a)
    case .nine:
      return .bB
    case .ten:
      return ks.pickKey(.cB, .b)
    case .eleven:
      return ks.pickKey(.d_bb, .c)
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
    return Min9(rootNum: rootNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
