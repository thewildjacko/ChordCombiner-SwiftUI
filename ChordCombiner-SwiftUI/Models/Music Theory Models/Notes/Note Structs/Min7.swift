//
//  Min7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Min7: NoteProtocol, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Min7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(10))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: String, short: String, long: String) {
    return (name: Degree.minor7th.name, short: Degree.minor7th.short, long: Degree.minor7th.long)
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .one:
      return ks.pickKey(.cB, .b, .b, .b)
    case .two:
      return .c
    case .three:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .four:
      return ks.pickKey(.e_bb, .d, .d, .d)
    case .five:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .six:
      return ks.pickKey(.fB, .e, .e, .e)
    case .seven:
      return .f
    case .eight:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .nine:
      return .g
    case .ten:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .eleven:
      return ks.pickKey(.b_bb, .a, .a, .a)
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
    
    return Min7(rootNum: noteNum, enharm: newEnharm)
  }
}
