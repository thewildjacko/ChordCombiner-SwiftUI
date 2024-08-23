//
//  Sh_9.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_9: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Sh_9 (\(noteName))"
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
    return (name: DegName.Name(.sh9), short: DegName.Short.sh9, long: DegName.Long(.sh9))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return .dSh
    case .one:
      return ks.pickKey(.e, .dX, .e, .e)
    case .two:
      return .eSh
    case .three:
      return ks.pickKey(.fSh, .eX, .fSh, .eX)
    case .four:
      return ks.pickKey(.g, .fX, .g, .g)
    case .five:
      return .gSh
    case .six:
      return ks.pickKey(.a, .gX, .a, .a)
    case .seven:
      return .aSh
    case .eight:
      return ks.pickKey(.b, .aX, .b, .b)
    case .nine:
      return .bSh
    case .ten:
      return ks.pickKey(.cSh, .bX, .cSh, .bX)
    case .eleven:
      return ks.pickKey(.d, .cX, .d, .d)
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
    
    return Sh_9(rootNum: noteNum, enharm: newEnharm)
  }
}


