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
typealias KeyAddendMod = KeyConstants.AddendModifier
typealias KeyAddend = (KeyType) -> CGFloat
typealias KeyArcAngle = KeyConstants.ArcAngle

enum KeyConstants {
  /// Base width for each key before modification based on ``Keyboard`` width
  enum Width: CGFloat {
    case whiteKeyDFB = 24
    case whiteKeyCEGA = 23
    case blackKey = 14

    /// Calculates the center x position of the next key from the current keyType
    ///
    /// Remark: Calculates before adjusting for ``Keyboard`` width
    static func getAddend(_ keyType: KeyType) -> CGFloat {
      switch keyType {
      case .c:
        return Width.whiteKeyCEGA.rawValue/* + 10*/
      case .dB, .d:
        return keyType == .dB
        ? AddendModifier.Db.rawValue // D shifts right by 5
        : Width.whiteKeyDFB.rawValue - AddendModifier.Db.rawValue // E♭ shifts right by 19
      case .eB, .e:
        return keyType == .eB
        ? AddendModifier.Eb.rawValue // E shifts right by 9
        : Width.blackKey.rawValue // F shifts right by 14
      case .f, .gB:
        return keyType == .f
        ? Width.whiteKeyDFB.rawValue // G♭ shifts right by 24
        : AddendModifier.Gb.rawValue // G shifts right by 3
      case .g, .aB:
        return keyType == .g
        ? Width.whiteKeyCEGA.rawValue - AddendModifier.Gb.rawValue // A♭ shifts right by 20
        : Width.blackKey.rawValue / 2 // A shifts right by 7
      case .a, .bB:
        return keyType == .a
        ? Width.whiteKeyCEGA.rawValue - Width.blackKey.rawValue / 2 // B♭ shifts right by 16
        : AddendModifier.Bb.rawValue // B shifts right by 11
      case .b: // C shifts right by 12
        return Width.whiteKeyDFB.rawValue - AddendModifier.Bb.rawValue
      }
    }
  }

  /// The horizontal adjusment to add to certain keys' position based on the previous key's position
  ///
  enum AddendModifier: CGFloat {
    // swiftlint:disable identifier_name
    case Db = 5 // 5
    case Eb = 9 // 9
    case Gb = 4 // 3
    case Bb = 11 // 11
    // swiftlint:enable identifier_name
  }

  /// Base height for each key before modification based on ``Keyboard`` width
  enum Height: CGFloat {
    case whiteKey = 96
    case blackKey = 52
  }

  /// Adjusts the height of the black keys based on their width (which is determined first)
  public static let blackKeyHeightToWidthRatio: CGFloat = Height.blackKey.rawValue/Width.blackKey.rawValue

  public static let blackToWhiteKeyHeightRatio: CGFloat = Height.blackKey.rawValue/Height.whiteKey.rawValue

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
