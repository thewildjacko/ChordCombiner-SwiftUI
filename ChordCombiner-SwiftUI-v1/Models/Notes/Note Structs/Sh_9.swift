//
//  Sh_9.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_9: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Sh_9 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(3))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.sh9), short: DegName.Short.sh9, long: DegName.Long(.sh9))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return .dSh
    case .one:
      return ks.pickKey(.e, .dX)
    case .two:
      return .eSh
    case .three:
      return ks.pickKey(.fSh, .eX)
    case .four:
      return ks.pickKey(.g, .fX)
    case .five:
      return ks.pickKey(.gSh, .gSh)
    case .six:
      return ks.pickKey(.a, .gX)
    case .seven:
      return .aSh
    case .eight:
      return ks.pickKey(.b, .aX)
    case .nine:
      return .bSh
    case .ten:
      return ks.pickKey(.cSh, .bX)
    case .eleven:
      return ks.pickKey(.d, .cX)
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
    return Sh_9(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
