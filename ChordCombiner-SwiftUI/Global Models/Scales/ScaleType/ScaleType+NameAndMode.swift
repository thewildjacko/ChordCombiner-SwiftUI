//
//  ScaleType+Names.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

extension ScaleType {
  var modeNumber: ModeNumber {
    switch self {
    case let scale where scale.isParentScaleType:
        .one
    case .dorian, .dorianFlatTwo, .locrianNaturalSix, .dorianFlatFive, .majorBlues, .halfWholeDiminished:
        .two
    case .phrygian, .lydianAugmented, .ionianSharpFive, .phrygianFlatFour:
        .three
    case .lydian, .lydianDominant, .dorianSharpFour, .lydianFlatThree:
        .four
    case .mixolydian, .mixolydianFlatSix, .phrygianDominant, .mixolydianFlatTwo, .minorPentatonic:
        .five
    case .minor, .locrianNaturalTwo, .lydianSharpTwo, .aeolianFlatOne:
        .six
    case .locrian, .superLocrian, .ultraLocrian, .locrianDiminishedSeven:
        .seven
    default:
        .one
    }
  }

  private var unformattedRomanNumeral: String {
    modeNumber.romanNumeral
  }

  var romanNumeral: String {
    isMinorAdjacent ? unformattedRomanNumeral.lowercased() : unformattedRomanNumeral
  }

  var alternateNames: [String] {
    switch self {
    case .major:
      ["Ionian"]
    case .minor:
      ["Natural minor", "Aeolian"]
    case .dorianFlatTwo:
      ["Phrygian ♮6"]
    case .lydianAugmented:
      ["Lydian ♯5"]
    case .lydianDominant:
      ["Mixolydian ♯4"]
    case .mixolydianFlatSix:
      ["Aeolian ♮3"]
    case .locrianNaturalTwo:
      ["Aeolian ♭5"]
    case .superLocrian:
      ["Altered", "Diminished whole-tone"]
    case .phrygianDominant:
      ["Phrygian ♮3"]
    case .lydianSharpTwo:
      ["Aeolian Harmonic"]
    case .ultraLocrian:
      ["Super Locrian diminished", "Super Locrian ˚7", "Altered diminished"]
    case .harmonicMajor:
      ["Ionian ♯6"]
    case .lydianFlatThree:
      ["Lydian diminished"]
    case .mixolydianFlatTwo:
      ["Mixolydian ♭9", "Dominant ♭2", "Harmonic Minor Inverse"]
    case .aeolianFlatOne:
      ["Lydian Augmented ♯2"]
    case .locrianDiminishedSeven:
      ["Diminished Blues b9"]
    case .blues:
      ["Minor Blues"]
    case .diminished:
      ["Whole-Half diminished"]
    case .halfWholeDiminished:
      ["Dominant diminished"]
    default:
      []
    }
  }
}
