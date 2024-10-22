//
//  Constants.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import Foundation
import SwiftUI

enum Constants {
  enum Width: CGFloat {
    case whiteKeyDFB = 24
    case whiteKeyCEGA = 23
    case blackKey = 14
    case fullOctave = 187
    case octave = 164
    case halfOctave = 82
    
    enum AddendMod: CGFloat {
      case Db = 5
      case Eb = 9
      case Gb = 3
      case Bb = 11
    }
    
    static func getAddend(_ keyType: KeyType) -> CGFloat {
      switch keyType {
      case .C:
        return Width.whiteKeyCEGA.rawValue
      case .Db:
        return AddendMod.Db.rawValue
      case .D:
        return Width.whiteKeyDFB.rawValue - AddendMod.Db.rawValue
      case .Eb:
        return AddendMod.Eb.rawValue
      case .E:
        return Width.blackKey.rawValue
      case .F:
        return Width.whiteKeyDFB.rawValue
      case .Gb:
        return AddendMod.Gb.rawValue
      case .G:
        return Width.whiteKeyCEGA.rawValue - AddendMod.Gb.rawValue
      case .Ab:
        return Width.blackKey.rawValue / 2
      case .A:
        return Width.whiteKeyCEGA.rawValue - Width.blackKey.rawValue / 2
      case .Bb:
        return AddendMod.Bb.rawValue
      case .B:
        return Width.whiteKeyDFB.rawValue - AddendMod.Bb.rawValue
      }
    }
  }
  
  enum Height: CGFloat {
    case whiteKey = 96
    case blackKey = 52
  }
  
  enum Radius: CGFloat {
    case whiteKey = 2.5
    case blackKey = 1.2
  }
  
  enum ArcAngle {
    case one
    case two
    
    var angle: Angle {
      switch self {
      case .one:
        return Angle(degrees: 0)
      case .two:
        return Angle(degrees: 90.0)
      }
    }
  }
  
  enum Position: CGFloat {
    case C = 0
    case Db = 14
    case D = 23
    case Eb = 42
    case E = 47
    case F = 70
    case Gb = 83
    case G = 94
    case Ab = 110
    case A = 117
    case Bb = 137
    case B = 140
    case octave = 164
    
  }
  
  public static let frameModifier: CGFloat = 187
  public static let blackKeyHeightMultiplier = Height.blackKey.rawValue/Width.blackKey.rawValue
  public static let whiteKeyCEGAHeightMultiplier = Height.whiteKey.rawValue/Width.whiteKeyCEGA.rawValue
  public static let whiteKeyDFBHeightMultiplier = Height.whiteKey.rawValue/Width.whiteKeyDFB.rawValue
  public static let blackToWhiteHeightRatio = Height.blackKey.rawValue/Height.whiteKey.rawValue
}

