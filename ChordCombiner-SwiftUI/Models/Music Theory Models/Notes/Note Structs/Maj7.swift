//
//  Maj7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj7: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Maj7 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.num.plusDeg(11))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma7), short: DegName.Short.ma7, long: DegName.Long(.ma7))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.b, .aX, .b, .b)
    case .one:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .two:
      return .cSh
    case .three:
      return ks.pickKey(.d, .cX, .d, .d)
    case .four:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
    case .five:
      return ks.pickKey(.e, .dX, .e, .e)
    case .six:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .seven:
      return .fSh
    case .eight:
      return ks.pickKey(.g, .fX, .g, .g)
    case .nine:
      return .gSh
    case .ten:
      return ks.pickKey(.a, .gX, .a, .a)
    case .eleven:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
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
    
    return Maj7(rootNum: noteNum, enharm: newEnharm)
  }
}