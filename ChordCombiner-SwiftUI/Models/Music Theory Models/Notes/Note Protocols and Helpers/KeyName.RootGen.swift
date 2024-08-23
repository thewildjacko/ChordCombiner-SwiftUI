//
//  RootGen.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension KeyName {
  /**
   A `KeyName` sub-enum, limited only to flat, natural and sharp keys, used to init a Root
   
   Use typealias `RootGen` for brevity
   
   **Initialization**
   
   1. `KeyName` (single parameter init)
   2. `Letter` and `RootAcc`
   */
  
  enum RootGen: CaseIterable, Codable {
    case c, d, e, f, g, a, b
    case cB, dB, eB, fB, gB, aB, bB
    case cSh, dSh, eSh, fSh, gSh, aSh, bSh
  
    
    static var majorRoots: [RootGen] {
      [.c,
       .f, .bB, .eB, .aB, .dB, .gB, .cB,
       .g, .d, .a, .e, .b, .fSh, .cSh]
    }
    
    static var majorExclusions: [RootGen] {
      [.fB, .gSh, .dSh, .aSh, .eSh, .bSh]
    }
    
    // a d g c f Bb Eb Ab | Db Gb Cb Fb
    // e b f# c# g# d# a# | e# b#
    
    static var minorRoots: [RootGen] {
      [.a,
       .d, .g, .c, .f, .bB, .eB, .aB,
       .e, .b, .fSh, .cSh, .gSh, .dSh, .aSh]
    }
    
    
    static var minorExclusions: [RootGen] {
      [.dB, .gB, .cB, .fB, .eSh, .bSh]
    }
    
    /**
     
     Initializes a RootGen using a single parameter
     - Parameter key: takes any `KeyName`, (including double flat / double sharp keys) and converts into a RootGen with a flat, natural or sharp.
     
     */
    init(_ key: KeyName) {
      switch key {
      case .c, .d_bb:
        self = .c
      case .d, .cX, .e_bb:
        self = .d
      case .e, .dX:
        self = .e
      case .f, .g_bb:
        self = .f
      case .g, .fX, .a_bb:
        self = .g
      case .a, .gX, .b_bb:
        self = .a
      case .b, .aX:
        self = .b
      case .cB:
        self = .cB
      case .dB:
        self = .dB
      case .eB, .f_bb:
        self = .eB
      case .fB:
        self = .fB
      case .gB:
        self = .gB
      case .aB:
        self = .aB
      case .bB, .c_bb:
        self = .bB
      case .cSh, .bX:
        self = .cSh
      case .dSh:
        self = .dSh
      case .eSh:
        self = .eSh
      case .fSh, .eX:
        self = .fSh
      case .gSh:
        self = .gSh
      case .aSh:
        self = .aSh
      case .bSh:
        self = .bSh
      }
    }
    
    
    /**
     Initializes a RootGen using two parameters, a `Letter` and a `RootAcc`
     - Parameter letter: the letter name of a key
     - Parameter accidental: the accidental of a key
     */
    
    init(_ letter: Letter, _ accidental: RootAcc) {
      switch accidental {
      case .flat:
        switch letter {
        case .c:
          self = .cB
        case .d:
          self = .dB
        case .e:
          self = .eB
        case .f:
          self = .fB
        case .g:
          self = .gB
        case .a:
          self = .aB
        case .b:
          self = .bB
        }
      case .natural:
        switch letter {
        case .c:
          self = .c
        case .d:
          self = .d
        case .e:
          self = .e
        case .f:
          self = .f
        case .g:
          self = .g
        case .a:
          self = .a
        case .b:
          self = .b
        }
      case .sharp:
        switch letter {
        case .c:
          self = .cSh
        case .d:
          self = .dSh
        case .e:
          self = .eSh
        case .f:
          self = .fSh
        case .g:
          self = .gSh
        case .a:
          self = .aSh
        case .b:
          self = .bSh
        }
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
  }
}
