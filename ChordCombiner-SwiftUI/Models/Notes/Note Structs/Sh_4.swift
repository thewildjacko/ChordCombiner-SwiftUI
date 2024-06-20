//
//  Sh_4.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_4: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Sh_4 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(6))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.sh4), short: DegName.Short.sh4, long: DegName.Long(.sh4))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.fSh, .eX)
    case .one:
      return ks.pickKey(.g, .fX)
    case .two:
      return .gSh
    case .three:
      return ks.pickKey(.a, .gX)
    case .four:
      return ks.pickKey(.bB, .aSh)
    case .five:
      return ks.pickKey(.b, .aX)
    case .six:
      return ks.pickKey(.c, .bSh)
    case .seven:
      return .cSh
    case .eight:
      return ks.pickKey(.d, .cX)
    case .nine:
      return .dSh
    case .ten:
      return ks.pickKey(.e, .dX)
    case .eleven:
      return ks.pickKey(.f, .eSh)
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
    return Sh_4(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
