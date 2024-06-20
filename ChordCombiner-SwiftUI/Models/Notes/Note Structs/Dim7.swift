//
//  Dim7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Dim7: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Dim7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(9))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.d7), short: DegName.Short.d7, long: DegName.Long(.d7))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.b_bb, .a)
    case .one:
      return ks.pickKey(.c_bb, .bB)
    case .two:
      return .cB
    case .three:
      return ks.pickKey(.d_bb, .c)
    case .four:
      return .dB
    case .five:
      return ks.pickKey(.e_bb, .d)
    case .six:
      return ks.pickKey(.f_bb, .eB)
    case .seven:
      return .fB
    case .eight:
      return ks.pickKey(.g_bb, .f)
    case .nine:
      return .gB
    case .ten:
      return ks.pickKey(.a_bb, .g)
    case .eleven:
      return .aB
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
    return Dim7(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
