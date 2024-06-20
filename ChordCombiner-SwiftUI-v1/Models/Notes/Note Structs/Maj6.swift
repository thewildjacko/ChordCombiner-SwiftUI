//
//  Maj6.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj6: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Maj6 (\(noteName))"
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
    return (name: DegName.Name(.ma6), short: DegName.Short.ma6, long: DegName.Long(.ma6))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.a, .gX)
    case .one:
      return ks.pickKey(.bB, .aSh)
    case .two:
      return .b
    case .three:
      return ks.pickKey(.c, .bSh)
    case .four:
      return ks.pickKey(.dB, .cSh)
    case .five:
      return ks.pickKey(.d, .cX)
    case .six:
      return ks.pickKey(.eB, .dSh)
    case .seven:
      return .e
    case .eight:
      return ks.pickKey(.f, .eSh)
    case .nine:
      return .fSh
    case .ten:
      return ks.pickKey(.g, .fX)
    case .eleven:
      return ks.pickKey(.aB, .gSh)
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
    return Maj6(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
