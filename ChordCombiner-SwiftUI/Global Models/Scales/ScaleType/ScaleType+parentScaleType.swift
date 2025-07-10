//
//  ScaleType+parentScaleType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

extension ScaleType {
  var parentScaleType: ScaleType {
    switch self {
      // Major modes
    case .major, .dorian, .phrygian, .lydian, .mixolydian, .minor, .locrian:
      return .major
      // Melodic minor modes
    case .melodicMinor, .dorianFlatTwo, .lydianAugmented, .lydianDominant,
        .mixolydianFlatSix, .locrianNaturalTwo, .superLocrian:
      return .melodicMinor
      // Harmonic minor modes
    case .harmonicMinor, .locrianNaturalSix, .ionianSharpFive, .dorianSharpFour,
        .phrygianDominant, .lydianSharpTwo, .ultraLocrian:
      return .harmonicMinor
      // Harmonic Major modes
    case .harmonicMajor, .dorianFlatFive, .phrygianFlatFour, .lydianFlatThree,
        .mixolydianFlatTwo, .aeolianFlatOne, .locrianDiminishedSeven:
      return .harmonicMajor
    case .blues, .majorBlues:
      return .blues
    case .pentatonic, .minorPentatonic:
      return .pentatonic
    case .diminished, .halfWholeDiminished:
      return .diminished
    }
  }

  var isParentScaleType: Bool { self == parentScaleType }
}
