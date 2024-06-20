//
//  Maj3.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj3: Note, CustomStringConvertible, KSwitch {
  var description: String {
    return "Maj3 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(4))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma3), short: DegName.Short.ma3, long: DegName.Long(.ma3))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.e, .dX)
    case .one:
      return ks.pickKey(.f, .eSh)
    case .two:
      return .fSh
    case .three:
      return ks.pickKey(.g, .fX)
    case .four:
      return ks.pickKey(.aB, .gSh)
    case .five:
      return ks.pickKey(.a, .gX)
    case .six:
      return ks.pickKey(.bB, .aSh)
    case .seven:
      return .b
    case .eight:
      return ks.pickKey(.c, .bSh)
    case .nine:
      return .cSh
    case .ten:
      return ks.pickKey(.d, .cX)
    case .eleven:
      return ks.pickKey(.eB, .dSh)
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
    return Maj3(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
