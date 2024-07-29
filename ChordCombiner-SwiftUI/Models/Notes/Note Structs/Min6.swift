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
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .one:
      return ks.pickKey(.b_bb, .a, .a, .a)
    case .two:
      return .bB
    case .three:
      return ks.pickKey(.cB, .b, .b, .b)
    case .four:
      return ks.pickKey(.d_bb, .c, .c, .c)
    case .five:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .six:
      return ks.pickKey(.e_bb, .d, .d, .d)
    case .seven:
      return .eB
    case .eight:
      return ks.pickKey(.fB, .e, .e, .e)
    case .nine:
      return .f
    case .ten:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .eleven:
      return ks.pickKey(.a_bb, .g, .g, .g)
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
  
  func enharmSwapped() -> Note {
    var newEnharm: Enharmonic {
      switch enharm {
      case .flat, .sharp:
        return enharm == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Min6(rootNum: noteNum, enharm: newEnharm)
  }
}
