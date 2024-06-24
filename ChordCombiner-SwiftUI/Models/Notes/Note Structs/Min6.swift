//
//  Min6.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Min6: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Min6 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(8))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.mi6), short: DegName.Short.mi6, long: DegName.Long(.mi6))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.aB, .gSh)
    case .one:
      return ks.pickKey(.b_bb, .a)
    case .two:
      return .bB
    case .three:
      return ks.pickKey(.cB, .b)
    case .four:
      return ks.pickKey(.d_bb, .c)
    case .five:
      return ks.pickKey(.dB, .cSh)
    case .six:
      return ks.pickKey(.e_bb, .d)
    case .seven:
      return .eB
    case .eight:
      return ks.pickKey(.fB, .e)
    case .nine:
      return .f
    case .ten:
      return ks.pickKey(.gB, .fSh)
    case .eleven:
      return ks.pickKey(.a_bb, .g)
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
    return Min6(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
