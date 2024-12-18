//
//  RootKeyNote.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

typealias RootKeyNote = KeyName.RootKeyNote

extension KeyName {
  /**
   A `KeyName` sub-enum, limited only to flat, natural and sharp keys, used to init a Root

   Use typealias `RootKeyNote` for brevity

   **Initialization**

   1. `KeyName` (single parameter init)
   2. `Letter` and `RootAccidental`
   */

  enum RootKeyNote: CaseIterable, Codable, GettableKeyName {
    // swiftlint:disable identifier_name
    case c, d, e, f, g, a, b
    case cB, dB, eB, fB, gB, aB, bB
    case cSh, dSh, eSh, fSh, gSh, aSh, bSh
    // swiftlint:enable identifier_name

    static var majorRoots: [RootKeyNote] {
      [.c,
       .f, .bB, .eB, .aB, .dB, .gB, .cB,
       .g, .d, .a, .e, .b, .fSh, .cSh]
    }

    static var majorExclusions: [RootKeyNote] {
      [.fB, .gSh, .dSh, .aSh, .eSh, .bSh]
    }

    // a d g c f Bb Eb Ab | Db Gb Cb Fb
    // e b f# c# g# d# a# | e# b#

    static var minorRoots: [RootKeyNote] {
      [.a,
       .d, .g, .c, .f, .bB, .eB, .aB,
       .e, .b, .fSh, .cSh, .gSh, .dSh, .aSh]
    }

    static var minorExclusions: [RootKeyNote] {
      [.dB, .gB, .cB, .fB, .eSh, .bSh]
    }

    static func naturals(keyName: KeyName) -> RootKeyNote {
      switch keyName {
      case .c, .dBB:
        return .c
      case .d, .cX, .eBB:
        return .d
      case .e, .dX:
        return .e
      case .f, .gBB:
        return .f
      case .g, .fX, .aBB:
        return .g
      case .a, .gX, .bBB:
        return .a
      case .b, .aX:
        return .b
      default:
        return .c
      }
    }

    static func flats(keyName: KeyName) -> RootKeyNote {
      switch keyName {
      case .cB:
        return .cB
      case .dB:
        return .dB
      case .eB, .fBB:
        return .eB
      case .fB:
        return .fB
      case .gB:
        return .gB
      case .aB:
        return .aB
      case .bB, .cBB:
        return .bB
      default:
        return .cB
      }
    }

    static func sharps(keyName: KeyName) -> RootKeyNote {
      switch keyName {
      case .cSh, .bX:
        return .cSh
      case .dSh:
        return .dSh
      case .eSh:
        return .eSh
      case .fSh, .eX:
        return .fSh
      case .gSh:
        return .gSh
      case .aSh:
        return .aSh
      case .bSh:
        return .bSh
      default:
        return .cSh
      }
    }

    static func flats(letter: Letter) -> RootKeyNote {
      switch letter {
      case .c:
        return .cB
      case .d:
        return .dB
      case .e:
        return .eB
      case .f:
        return .fB
      case .g:
        return .gB
      case .a:
        return .aB
      case .b:
        return .bB
      }
    }

    static func naturals(letter: Letter) -> RootKeyNote {
      switch letter {
      case .c:
        return .c
      case .d:
        return .d
      case .e:
        return .e
      case .f:
        return .f
      case .g:
        return .g
      case .a:
        return .a
      case .b:
        return .b
      }
    }

    static func sharps(letter: Letter) -> RootKeyNote {
      switch letter {
      case .c:
        return .cSh
      case .d:
        return .dSh
      case .e:
        return .eSh
      case .f:
        return .fSh
      case .g:
        return .gSh
      case .a:
        return .aSh
      case .b:
        return .bSh
      }
    }

    // MARK: Initializers
    /// Initializes a RootKeyNote using a single parameter
    ///
    /// - Parameter keyName: any `KeyName` (including double flat / double sharp keys)
    ///
    /// - Returns: a RootKeyNote with a flat, natural or sharp.
    init(_ keyName: KeyName) {
      switch keyName {
      case .c, .dBB, .d, .cX, .eBB, .e, .dX, .f, .gBB,
          .g, .fX, .aBB, .a, .gX, .bBB, .b, .aX:
        self = RootKeyNote.naturals(keyName: keyName)
      case .cB, .dB, .eB, .fBB, .fB, .gB, .aB, .bB, .cBB:
        self = RootKeyNote.flats(keyName: keyName)
      case .cSh, .bX, .dSh, .eSh, .fSh, .eX, .gSh, .aSh, .bSh:
        self = RootKeyNote.sharps(keyName: keyName)
      }
    }

    /// Initializes a RootKeyNote using two parameters, a `Letter` and a `RootAccidental`
    ///
    /// - Parameter letter: the letter name of a key
    /// - Parameter accidental: the accidental of a key
    init(_ letter: Letter, _ accidental: RootAccidental) {
      switch accidental {
      case .flat:
        self = RootKeyNote.flats(letter: letter)
      case .natural:
        self = RootKeyNote.naturals(letter: letter)
      case .sharp:
        self = RootKeyNote.sharps(letter: letter)
      }
    }

    /// The `KeyName` of the root; use to initiate other roots or scale/chord degrees
    var keyName: KeyName {
      switch self {
      case .c:
        return .c
      case .d:
        return .d
      case .e:
        return .e
      case .f:
        return .f
      case .g:
        return .g
      case .a:
        return .a
      case .b:
        return .b
      case .cB:
        return .cB
      case .dB:
        return .dB
      case .eB:
        return .eB
      case .fB:
        return .fB
      case .gB:
        return .gB
      case .aB:
        return .aB
      case .bB:
        return .bB
      case .cSh:
        return .cSh
      case .dSh:
        return .dSh
      case .eSh:
        return .eSh
      case .fSh:
        return .fSh
      case .gSh:
        return .gSh
      case .aSh:
        return .aSh
      case .bSh:
        return .bSh
      }
    }

    func allNotesInKey() -> [Note] {
      Degree.allNotesInKey(rootKeyNote: self)
    }

    func allChordNotesInKey() -> [Note] {
      Degree.allChordNotesInKey(rootKeyNote: self)
    }
  }
}
