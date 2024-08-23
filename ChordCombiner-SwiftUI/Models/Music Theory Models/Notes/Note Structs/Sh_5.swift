//
//  Sh_5.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_5: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Sh_5 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(8))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.sh5), short: DegName.Short.sh5, long: DegName.Long(.sh5))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return .gSh
    case .one:
      return ks.pickKey(.a, .gX, .a, .a)
    case .two:
      return .aSh
    case .three:
      return ks.pickKey(.b, .aX, .b, .b)
    case .four:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .five:
      return ks.pickKey(.cSh, .bX, .cSh, .bX)
    case .six:
      return ks.pickKey(.d, .cX, .d, .d)
    case .seven:
      return .dSh
    case .eight:
      return ks.pickKey(.e, .dX, .e, .e)
    case .nine:
      return .eSh
    case .ten:
      return ks.pickKey(.fSh, .eX, .fSh, .eX)
    case .eleven:
      return ks.pickKey(.g, .fX, .g, .g)
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
    
    return Sh_5(rootNum: noteNum, enharm: newEnharm)
  }
}
