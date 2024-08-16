//
//  Dim7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Dim7: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Dim7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(9))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.d7), short: DegName.Short.d7, long: DegName.Long(.d7))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.b_bb, .a, .a, .a)
    case .one:
      return ks.pickKey(.c_bb, .bB, .c_bb, .bB)
    case .two:
      return .cB
    case .three:
      return ks.pickKey(.d_bb, .c, .c, .c)
    case .four:
      return .dB
    case .five:
      return ks.pickKey(.e_bb, .d, .d, .d)
    case .six:
      return ks.pickKey(.f_bb, .eB, .f_bb, .eB)
    case .seven:
      return .fB
    case .eight:
      return ks.pickKey(.g_bb, .f, .f, .f)
    case .nine:
      return .gB
    case .ten:
      return ks.pickKey(.a_bb, .g, .g, .g)
    case .eleven:
      return .aB
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
    
    return Dim7(rootNum: noteNum, enharm: newEnharm)
  }
}
