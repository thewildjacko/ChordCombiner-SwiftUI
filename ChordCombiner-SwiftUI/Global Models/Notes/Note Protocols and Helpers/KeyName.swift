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

// swiftlint:disable identifier_name
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
  case cBB = "C𝄫"
  case dBB = "D𝄫"
  case eBB = "E𝄫"
  case fBB = "F𝄫"
  case gBB = "G𝄫"
  case aBB = "A𝄫"
  case bBB = "B𝄫"
  // double sharp notes
  case cX = "C𝄪"
  case dX = "D𝄪"
  case eX = "E𝄪"
  case fX = "F𝄪"
  case gX = "G𝄪"
  case aX = "A𝄪"
  case bX = "B𝄪"

  // swiftlint:enable identifier_name
  /// The KeyName's accidental
  var accidental: Accidental {
    switch self {
    case .dBB, .eBB, .fBB, .gBB, .aBB, .bBB, .cBB:
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
    case .cBB, .cB, .c, .cSh, .cX:
      return .c
    case .dBB, .dB, .d, .dSh, .dX:
      return .d
    case .eBB, .eB, .e, .eSh, .eX:
      return .e
    case .fBB, .fB, .f, .fSh, .fX:
      return .f
    case .gBB, .gB, .g, .gSh, .gX:
      return .g
    case .aBB, .aB, .a, .aSh, .aX:
      return .a
    case .bBB, .bB, .b, .bSh, .bX:
      return .b
    }
  }

  /// Prints the KeyName's `name`, `Letter`, `Accidental`, `EnharmonicSymbol` and `noteNumber` to the console
  func keyStats() {
    print(rawValue, "(\(letter))", accidental.rawValue, enharmonic, noteNumber.rawValue)
  }
}

extension KeyName: Enharmonic {
  /// EnharmonicSymbol value to determine how `Notes` initiated using this KeyName will print
  var enharmonic: EnharmonicSymbol {
    switch self {
    case .c, .dB, .eB, .fB, .f, .gB, .aB, .bB, .cB, .dBB, .eBB, .fBB, .gBB, .aBB, .bBB, .cBB:
      return .flat
    case .cSh, .d, .dSh, .e, .eSh, .fSh, .g, .gSh, .a, .aSh, .b, .bSh, .cX, .dX, .eX, .fX, .gX, .aX, .bX:
      return .sharp
    }
  }
}

extension KeyName: GettableNoteNumber {
  /// The KeyName's `NoteNumber` _0-_11
  var noteNumber: NoteNumber {
    switch self {
    case .c, .bSh, .dBB:
      return .zero
    case .cSh, .dB, .bX:
      return .one
    case .d, .cX, .eBB:
      return .two
    case .dSh, .eB, .fBB:
      return .three
    case .e, .fB, .dX:
      return .four
    case .eSh, .f, .gBB:
      return .five
    case .fSh, .gB, .eX:
      return .six
    case .g, .fX, .aBB:
      return .seven
    case .gSh, .aB:
      return .eight
    case .a, .gX, .bBB:
      return .nine
    case .aSh, .bB, .cBB:
      return .ten
    case .cB, .b, .aX:
      return .eleven
    }
  }
}
