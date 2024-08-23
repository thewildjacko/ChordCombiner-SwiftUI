//
//  Min3.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Min3: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Min3 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(3))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.mi3), short: DegName.Short.mi3, long: DegName.Long(.mi3))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .one:
      return ks.pickKey(.fB, .e, .e, .e)
    case .two:
      return .f
    case .three:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .four:
      return ks.pickKey(.a_bb, .g, .g, .g)
    case .five:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .six:
      return ks.pickKey(.b_bb, .a, .a, .a)
    case .seven:
      return .bB
    case .eight:
      return ks.pickKey(.cB, .b, .b, .b)
    case .nine:
      return .c
    case .ten:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .eleven:
      return ks.pickKey(.e_bb, .d, .d, .d)
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
  
  func enharmSwapped() -> Note {
    var newEnharm: Enharmonic {
      switch enharm {
      case .flat, .sharp:
        return enharm == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Min3(rootNum: noteNum, enharm: newEnharm)
  }
}
