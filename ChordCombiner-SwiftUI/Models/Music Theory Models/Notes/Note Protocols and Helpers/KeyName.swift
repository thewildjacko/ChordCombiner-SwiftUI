//
//  KeyName_Enum.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

protocol GettableKeyName {
  var keyName: KeyName { get }
}

/// Use `KeyName` to initiate `RootGens`, which then can initiate `Notes`, `ScaleDetails`, `Triads` and `FourNoteChords`
enum KeyName: String, CaseIterable, Codable {
  // natural white notes
  case c = "C"
  case d = "D"
  case e = "E"
  case f = "F"
  case g = "G"
  case a = "A"
  case b = "B"
  // flat notes
  case cB = "C♭"
  case dB = "D♭"
  case eB = "E♭"
  case fB = "F♭"
  case gB = "G♭"
  case aB = "A♭"
  case bB = "B♭"
  // sharp notes
  case cSh = "C♯"
  case dSh = "D♯"
  case eSh = "E♯"
  case fSh = "F♯"
  case gSh = "G♯"
  case aSh = "A♯"
  case bSh = "B♯"
  // double flat notes
  case c_bb = "C𝄫"
  case d_bb = "D𝄫"
  case e_bb = "E𝄫"
  case f_bb = "F𝄫"
  case g_bb = "G𝄫"
  case a_bb = "A𝄫"
  case b_bb = "B𝄫"
  // double sharp notes
  case cX = "C𝄪"
  case dX = "D𝄪"
  case eX = "E𝄪"
  case fX = "F𝄪"
  case gX = "G𝄪"
  case aX = "A𝄪"
  case bX = "B𝄪"
    
  ///The KeyName's accidental
  var accidental: Accidental {
    switch self {
    case .d_bb, .e_bb, .f_bb, .g_bb, .a_bb, .b_bb, .c_bb:
      return .dblFlat
    case .dB, .eB, .fB, .gB, .aB, .bB, .cB:
      return .flat
    case .c, .d, .e, .f, .g, .a, .b:
      return .natural
    case .cSh, .dSh, .eSh, .fSh, .gSh, .aSh, .bSh:
      return .sharp
    case .cX, .dX, .eX, .fX, .gX, .aX, .bX:
      return .dblSharp
    }
  }
  
  /// The KeyName's Letter
  var letter: Letter {
    switch self {
    case .c_bb, .cB, .c, .cSh, .cX:
      return .c
    case .d_bb, .dB, .d, .dSh, .dX:
      return .d
    case .e_bb, .eB, .e, .eSh, .eX:
      return .e
    case .f_bb, .fB, .f, .fSh, .fX:
      return .f
    case .g_bb, .gB, .g, .gSh, .gX:
      return .g
    case .a_bb, .aB, .a, .aSh, .aX:
      return .a
    case .b_bb, .bB, .b, .bSh, .bX:
      return .b
    }
  }
  
  ///Prints the KeyName's `name`, `Letter`, `Accidental`, `EnharmonicSymbol` and `num` to the console
  func keyStats() {
    print(rawValue, "(\(letter))", accidental.rawValue, enharmonic, noteNum.rawValue)
  }
}

extension KeyName: Enharmonic {
  /// EnharmonicSymbol value to determine how `Notes` initiated using this KeyName will print
  var enharmonic: EnharmonicSymbol {
    get {
      switch self {
      case .c, .dB, .eB, .fB, .f, .gB, .aB, .bB, .cB, .d_bb, .e_bb, .f_bb, .g_bb, .a_bb, .b_bb, .c_bb:
        return .flat
      case .cSh, .d, .dSh, .e, .eSh, .fSh, .g, .gSh, .a, .aSh, .b, .bSh, .cX, .dX, .eX, .fX, .gX, .aX, .bX:
        return .sharp
      }
    }
    set { }
  }
}

extension KeyName: GettableNoteNum {
  /// The KeyName's `NoteNum` _0-_11
  var noteNum: NoteNum {
    get {
      switch self {
      case .c, .bSh, .d_bb:
        return .zero
      case .cSh, .dB, .bX:
        return .one
      case .d, .cX, .e_bb:
        return .two
      case .dSh, .eB, .f_bb:
        return .three
      case .e, .fB, .dX:
        return .four
      case .eSh, .f, .g_bb:
        return .five
      case .fSh, .gB, .eX:
        return .six
      case .g, .fX, .a_bb:
        return .seven
      case .gSh, .aB:
        return .eight
      case .a, .gX, .b_bb:
        return .nine
      case .aSh, .bB, .c_bb:
        return .ten
      case .cB, .b, .aX:
        return .eleven
      }
    }
//    set { }
  }
}
