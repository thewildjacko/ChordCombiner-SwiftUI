//
//  Maj7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj7: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Maj7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(11))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma7), short: DegName.Short.ma7, long: DegName.Long(.ma7))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.b, .aX)
    case .one:
      return ks.pickKey(.c, .bSh)
    case .two:
      return .cSh
    case .three:
      return ks.pickKey(.d, .cX)
    case .four:
      return ks.pickKey(.eB, .dSh)
    case .five:
      return ks.pickKey(.e, .dX)
    case .six:
      return ks.pickKey(.f, .eSh)
    case .seven:
      return .fSh
    case .eight:
      return ks.pickKey(.g, .fX)
    case .nine:
      return .gSh
    case .ten:
      return ks.pickKey(.a, .gX)
    case .eleven:
      return ks.pickKey(.bB, .aSh)
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
    return Maj7(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
