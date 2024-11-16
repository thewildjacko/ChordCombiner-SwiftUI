//
//  KeyConstants.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import Foundation
import SwiftUI

typealias KeyWidth = KeyConstants.Width
typealias KeyHeight = KeyConstants.Height
typealias KeyRadius = KeyConstants.Radius
typealias KeyAddendMod = KeyWidth.AddendModifier
typealias KeyAddend = (KeyType) -> CGFloat
typealias KeyArcAngle = KeyConstants.ArcAngle

enum KeyConstants {
  /// Base width for each key before modification based on ``Keyboard`` width
  enum Width: CGFloat {
    case whiteKeyDFB = 24
    case whiteKeyCEGA = 23
    case blackKey = 14
    
    /// The horizontal adjusment to add to certain keys' position based on the previous key's position
    /// 
    enum AddendModifier: CGFloat {
      case Db = 5 // 5
      case Eb = 9 // 9
      case Gb = 4 // 3
      case Bb = 11 // 11
    }
    
    /// Calculates the x position of the center of the next key based on the current keyType, before adjusting for ``Keyboard`` width
    static func getAddend(_ keyType: KeyType) -> CGFloat {
      switch keyType {
      case .C: // D♭ shifts right by 24
        return Width.whiteKeyCEGA.rawValue + 10
      case .Db: // D shifts right by 5
        return AddendModifier.Db.rawValue
      case .D: // E♭ shifts right by 19
        return Width.whiteKeyDFB.rawValue - AddendModifier.Db.rawValue
      case .Eb: // E shifts right by 9
        return AddendModifier.Eb.rawValue
      case .E: // F shifts right by 14
        return Width.blackKey.rawValue
      case .F: // G♭ shifts right by 24
        return Width.whiteKeyDFB.rawValue
      case .Gb: // G shifts right by 3
        return AddendModifier.Gb.rawValue
      case .G: // A♭ shifts right by 20
        return Width.whiteKeyCEGA.rawValue - AddendModifier.Gb.rawValue
      case .Ab: // A shifts right by 7
        return Width.blackKey.rawValue / 2
      case .A: // B♭ shifts right by 16
        return Width.whiteKeyCEGA.rawValue - Width.blackKey.rawValue / 2
      case .Bb: // B shifts right by 11
        return AddendModifier.Bb.rawValue
      case .B: // C shifts right by 12
        return Width.whiteKeyDFB.rawValue - AddendModifier.Bb.rawValue
      }
    }
  }
  
  /// Base height for each key before modification based on ``Keyboard`` width
  enum Height: CGFloat {
    case whiteKey = 96
    case blackKey = 52
  }
  
  /// Adjusts the height of the black keys based on their width (which is determined first)
  public static let blackKeyHeightToWidthRatio: CGFloat = Height.blackKey.rawValue/Width.blackKey.rawValue
  
  /// Angles used to construct the corners of the keys
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
  
  /// Corner radius for `ArcAngle`s in ``KeyShape``
  enum Radius: CGFloat {
    case whiteKey = 2.5
    case blackKey = 1.2
  }
}

