//
//  Sh_5.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_5: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Sh_5 (\(noteName))"
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
    return (name: DegName.Name(.sh5), short: DegName.Short.sh5, long: DegName.Long(.sh5))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.gSh, .gSh)
    case .one:
      return ks.pickKey(.a, .gX)
    case .two:
      return .aSh
    case .three:
      return ks.pickKey(.b, .aX)
    case .four:
      return ks.pickKey(.c, .bSh)
    case .five:
      return ks.pickKey(.cSh, .bX)
    case .six:
      return ks.pickKey(.d, .cX)
    case .seven:
      return .dSh
    case .eight:
      return ks.pickKey(.e, .dX)
    case .nine:
      return .eSh
    case .ten:
      return ks.pickKey(.fSh, .eX)
    case .eleven:
      return ks.pickKey(.g, .fX)
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
    return Sh_5(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
