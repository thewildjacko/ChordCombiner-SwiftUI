//
//  P5.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct P5: NoteProtocol, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "P5 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(7))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: String, short: String, long: String) {
    return (name: Degree.perfect5th.name, short: Degree.perfect5th.short, long: Degree.perfect5th.long)
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.g, .fX, .g, .g)
    case .one:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .two:
      return .a
    case .three:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .four:
      return ks.pickKey(.cB, .b, .b, .b)
    case .five:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .six:
      return ks.pickKey(.dB, .cSh, .dB, .cSh)
    case .seven:
      return .d
    case .eight:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .nine:
      return .e
    case .ten:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .eleven:
      return ks.pickKey(.gB, .fSh, .gB, .fSh)
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
    
    return P5(rootNum: noteNum, enharm: newEnharm)
  }
}
