//
//  Maj2.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj2: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Maj2 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(2))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma2), short: DegName.Short.ma2, long: DegName.Long(.ma2))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.d, .cX)
    case .one:
      return ks.pickKey(.eB, .dSh)
    case .two:
      return .e
    case .three:
      return ks.pickKey(.f, .eSh)
    case .four:
      return ks.pickKey(.gB, .fSh)
    case .five:
      return ks.pickKey(.g, .fX)
    case .six:
      return ks.pickKey(.aB, .gSh)
    case .seven:
      return .a
    case .eight:
      return ks.pickKey(.bB, .aSh)
    case .nine:
      return .b
    case .ten:
      return ks.pickKey(.c, .bSh)
    case .eleven:
      return ks.pickKey(.dB, .cSh)
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
    return Maj2(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
