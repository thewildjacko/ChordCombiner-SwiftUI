//
//  Sh_4.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Sh_4: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Sh_4 (\(noteName))"
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
    return (name: Degree.sharp4th.name, short: Degree.sharp4th.short, long: Degree.sharp4th.long)
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.fSh, .eX, .fSh, .eX)
    case .one:
      return ks.pickKey(.g, .fX, .g, .g)
    case .two:
      return .gSh
    case .three:
      return ks.pickKey(.a, .gX, .a, .a)
    case .four:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .five:
      return ks.pickKey(.b, .aX, .b, .b)
    case .six:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .seven:
      return .cSh
    case .eight:
      return ks.pickKey(.d, .cX, .d, .d)
    case .nine:
      return .dSh
    case .ten:
      return ks.pickKey(.e, .dX, .e, .e)
    case .eleven:
      return ks.pickKey(.f, .eSh, .f, .f)
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
    
    return Sh_4(rootNum: noteNum, enharm: newEnharm)
  }
}
