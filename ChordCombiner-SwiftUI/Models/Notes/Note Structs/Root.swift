//
//  Root.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/4/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// used in chords & scales to define the Tonic
struct Root: Note, CustomStringConvertible, Codable {
  var description: String {
    return "Root (\(noteName))"
  }
  
  var rootKey: RootGen
  var noteNum: NoteNum
  var enharm: Enharmonic
  
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) {
    return (name: DegName.Name(.rt), short: DegName.Short.rt, long: DegName.Long(.rt))
  }
  
  var key: KeyName
  
  init(noteNum: NoteNum = .zero, enharm: Enharmonic = .flat) {
    self.noteNum = noteNum
    self.enharm = enharm
    
    var ks: KeySwitch {
      return KeySwitch(enharm: enharm)
    }
    
    var rs: RootSwitch {
      return RootSwitch(enharm: enharm)
    }
    
    switch noteNum {
    case .zero:
      self.key = ks.pickKey(.c, .bSh)
      self.rootKey = rs.pickRoot(.c, .bSh)
    case .one:
      self.key = ks.pickKey(.dB, .cSh)
      self.rootKey = rs.pickRoot(.dB, .cSh)
    case .two:
      self.key = .d
      self.rootKey = .d
    case .three:
      self.key = ks.pickKey(.eB, .dSh)
      self.rootKey = rs.pickRoot(.eB, .dSh)
    case .four:
      self.key = ks.pickKey(.fB, .e)
      self.rootKey = rs.pickRoot(.fB, .e)
    case .five:
      self.key = ks.pickKey(.f, .eSh)
      self.rootKey = rs.pickRoot(.f, .eSh)
    case .six:
      self.key = ks.pickKey(.gB, .fSh)
      self.rootKey = rs.pickRoot(.gB, .fSh)
    case .seven:
      self.key = .g
      self.rootKey = .g
    case .eight:
      self.key = ks.pickKey(.aB, .gSh)
      self.rootKey = rs.pickRoot(.aB, .gSh)
    case .nine:
      self.key = .a
      self.rootKey = .a
    case .ten:
      self.key = ks.pickKey(.bB, .aSh)
      self.rootKey = rs.pickRoot(.bB, .aSh)
    case .eleven:
      self.key = ks.pickKey(.cB, .b)
      self.rootKey = rs.pickRoot(.cB, .b)
    }
  }
  
  init(_ key: RootGen) {
    self.key = key.r
    self.rootKey = key
    self.noteNum = self.key.noteNum
    self.enharm = self.key.enharm
  }
  
  mutating func kSW(ks: KeySwitch) {
    switch noteNum {
    case .zero:
      self.key = ks.pickKey(.c, .bSh)
    case .one:
      self.key = ks.pickKey(.dB, .cSh)
    case .two:
      self.key = .d
    case .three:
      self.key = ks.pickKey(.eB, .dSh)
    case .four:
      self.key = ks.pickKey(.fB, .e)
    case .five:
      self.key = ks.pickKey(.f, .eSh)
    case .six:
      self.key = ks.pickKey(.gB, .fSh)
    case .seven:
      self.key = .g
    case .eight:
      self.key = ks.pickKey(.aB, .gSh)
    case .nine:
      self.key = .a
    case .ten:
      self.key = ks.pickKey(.bB, .aSh)
    case .eleven:
      self.key = ks.pickKey(.cB, .b)
    }
  }
  
  mutating func swapEnharm() {
    enharm = enharm == .flat ? .sharp : .flat
    kSW(ks: KeySwitch(enharm: enharm))
    rootKey = RootGen(key)
  }
  
  func enharmSwapped() -> Note {
    return Root(noteNum: noteNum, enharm: enharm == .flat ? .sharp : .flat)
  }
}

extension Root: Equatable {
  static func == (lhs: Root, rhs: Root) -> Bool {
    return lhs.noteNum == rhs.noteNum
  }
  
}
