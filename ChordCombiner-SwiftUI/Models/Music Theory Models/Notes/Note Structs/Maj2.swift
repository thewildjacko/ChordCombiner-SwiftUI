//
//  Maj2.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj2: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Maj2 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(2))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma2), short: DegName.Short.ma2, long: DegName.Long(.ma2))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.d, .cX, .d, .d)
    case .one:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .two:
      return .e
    case .three:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .four:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
    case .five:
      return ks.pickKey(.g, .fX, .g, .g)
    case .six:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .seven:
      return .a
    case .eight:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .nine:
      return .b
    case .ten:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .eleven:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
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
    
    return Maj2(rootNum: noteNum, enharm: newEnharm)
  }
}
