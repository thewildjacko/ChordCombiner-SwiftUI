//
//  P5.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct P5: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "P5 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(7))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.p5), short: DegName.Short.p5, long: DegName.Long(.p5))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.g, .fX)
    case .one:
      return ks.pickKey(.aB, .gSh)
    case .two:
      return .a
    case .three:
      return ks.pickKey(.bB, .aSh)
    case .four:
      return ks.pickKey(.cB, .b)
    case .five:
      return ks.pickKey(.c, .bSh)
    case .six:
      return ks.pickKey(.dB, .cSh)
    case .seven:
      return .d
    case .eight:
      return ks.pickKey(.eB, .dSh)
    case .nine:
      return .e
    case .ten:
      return ks.pickKey(.f, .eSh)
    case .eleven:
      return ks.pickKey(.gB, .fSh)
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
    return P5(rootNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}
