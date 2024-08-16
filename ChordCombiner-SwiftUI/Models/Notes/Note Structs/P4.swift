//
//  P4.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct P4: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "P4 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(5))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.p4), short: DegName.Short.p4, long: DegName.Long(.p4))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .one:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .two:
      return .g
    case .three:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .four:
      return ks.pickKey(.b_bb, .a, .a, .a)
    case .five:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .six:
      return ks.pickKey(.cB, .b, .b, .b)
    case .seven:
      return .c
    case .eight:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .nine:
      return .d
    case .ten:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .eleven:
      return ks.pickKey(.fB, .e, .e, .e)
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
    
    return P4(rootNum: noteNum, enharm: newEnharm)
  }
}
