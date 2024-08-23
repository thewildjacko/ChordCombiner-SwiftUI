//
//  Maj6.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj6: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Maj6 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(9))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma6), short: DegName.Short.ma6, long: DegName.Long(.ma6))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.a, .gX, .a, .a)
    case .one:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .two:
      return .b
    case .three:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .four:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .five:
      return ks.pickKey(.d, .cX, .d, .d)
    case .six:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .seven:
      return .e
    case .eight:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .nine:
      return .fSh
    case .ten:
      return ks.pickKey(.g, .fX, .g, .g)
    case .eleven:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
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
    
    return Maj6(rootNum: noteNum, enharm: newEnharm)
  }
}
