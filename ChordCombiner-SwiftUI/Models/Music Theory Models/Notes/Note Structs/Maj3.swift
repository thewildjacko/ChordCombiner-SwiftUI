//
//  Maj3.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

struct Maj3: Note, CustomStringConvertible, KSwitch, Codable {
  var description: String {
    return "Maj3 (\(noteName))"
  }
  
  let rootNum: NoteNum
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(4))
    }
    set {
      
    }
  }
  
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.ma3), short: DegName.Short.ma3, long: DegName.Long(.ma3))
  }
  
  var key: KeyName {
    switch rootNum {
    case .zero:
      return ks.pickKey(.e, .dX, .e, .e)
    case .one:
      return ks.pickKey(.f, .eSh, .f, .f)
    case .two:
      return .fSh
    case .three:
      return ks.pickKey(.g, .fX, .g, .g)
    case .four:
      return ks.pickKey(.aB, .gSh, .aB, .gSh)
    case .five:
      return ks.pickKey(.a, .gX, .a, .a)
    case .six:
      return ks.pickKey(.bB, .aSh, .bB, .aSh)
    case .seven:
      return .b
    case .eight:
      return ks.pickKey(.c, .bSh, .c, .c)
    case .nine:
      return .cSh
    case .ten:
      return ks.pickKey(.d, .cX, .d, .d)
    case .eleven:
      return ks.pickKey(.eB, .dSh, .eB, .dSh)
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
    
    return Maj3(rootNum: noteNum, enharm: newEnharm)
  }
}
