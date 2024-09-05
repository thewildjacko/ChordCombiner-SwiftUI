//
//  P4.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct P4: NoteProtocol, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "P4 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(5))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: String, short: String, long: String) {
    return (name: Degree.perfect4th.name, short: Degree.perfect4th.short, long: Degree.perfect4th.long)
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
    self.rootNum = root.keyName.noteNum
    self.enharm = root.keyName.enharm
  }
  
  func enharmSwapped() -> NoteProtocol {
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
