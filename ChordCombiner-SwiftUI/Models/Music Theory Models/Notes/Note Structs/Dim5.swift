//
//  Dim_5.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Dim5: NoteProtocol, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Dim5 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(6))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: String, short: String, long: String) {
    return (name: Degree.dim5th.name, short: Degree.dim5th.short, long: Degree.dim5th.long)
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .one:
      return ks.pickKey(.a_bb, .g, .g, .g)
    case .two:
      return .aB
    case .three:
      return ks.pickKey(.b_bb, .a, .a, .a)
    case .four:
      return ks.pickKey(.c_bb, .bB, .c_bb, .bB)
    case .five:
      return ks.pickKey(.cB, .b, .b, .b)
    case .six:
      return ks.pickKey(.d_bb, .c, .c, .c)
    case .seven:
      return .dB
    case .eight:
      return ks.pickKey(.e_bb, .d, .d, .d)
    case .nine:
      return .eB
    case .ten:
      return ks.pickKey(.fB, .e, .e, .e)
    case .eleven:
      return ks.pickKey(.g_bb, .f, .f, .f)
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
    
    return Dim5(rootNum: noteNum, enharm: newEnharm)
  }
}
