//
//  ModeNumber.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/20/25.
//

import Foundation

enum ModeNumber: Int, CaseIterable {
  case one = 1, two, three, four, five, six, seven

  var romanNumeral: String {
    switch self {
    case .one:
      "I"
    case .two:
      "II"
    case .three:
      "III"
    case .four:
      "IV"
    case .five:
      "V"
    case .six:
      "VI"
    case .seven:
      "VII"
    }
  }
}

extension ModeNumber: Equatable, Comparable {
  static func == (lhs: ModeNumber, rhs: ModeNumber) -> Bool {
    lhs.rawValue == rhs.rawValue
  }

  static func < (lhs: ModeNumber, rhs: ModeNumber) -> Bool {
    lhs.rawValue < rhs.rawValue
  }

}
