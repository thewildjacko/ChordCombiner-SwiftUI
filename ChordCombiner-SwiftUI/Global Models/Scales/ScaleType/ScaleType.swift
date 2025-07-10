//  https://www.learnjazzstandards.com/blog/melodic-minor-modes/
//  ScaleType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

enum ScaleType: String, ChordAndScaleProperty {
  var id: Self { return self }

  // MARK: Major modes
  case major = "Major"
  case dorian = "Dorian"
  case phrygian = "Phrygian"
  case lydian = "Lydian"
  case mixolydian = "Mixolydian"
  case minor = "Minor"
  case locrian = "Locrian"

  // MARK: Melodic minor
  case melodicMinor = "Melodic minor"
  case dorianFlatTwo = "Dorian ♭2"
  case lydianAugmented = "Lydian Augmented"
  case lydianDominant = "Lydian Dominant"
  case mixolydianFlatSix = "Mixolydian ♭6"
  case locrianNaturalTwo = "Locrian ♮2"
  case superLocrian = "Super Locrian"

  // MARK: Harmonic minor
  case harmonicMinor = "Harmonic minor"
  case locrianNaturalSix = "Locrian ♮6"
  case ionianSharpFive = "Ionian ♯5"
  case dorianSharpFour = "Dorian ♯4"
  case phrygianDominant = "Phrygian dominant"
  case lydianSharpTwo = "Lydian ♯2"
  case ultraLocrian = "Ultralocrian"

  // MARK: Harmonic Major
  case harmonicMajor = "Harmonic Major"
  case dorianFlatFive = "Dorian ♭5"
  case phrygianFlatFour = "Phrygian ♭4"
  case lydianFlatThree = "Lydian ♭3"
  case mixolydianFlatTwo = "Mixolydian ♭2"
  case aeolianFlatOne = "Aeolian ♭1"
  case locrianDiminishedSeven = "Locrian 𝄫7"

  case blues = "Blues"
  case majorBlues = "Major blues"

  case pentatonic = "Major pentatonic"
  case minorPentatonic = "Minor pentatonic"
  // TODO: Fix diminished scale display
  case diminished = "Diminished"
  case halfWholeDiminished = "Half-Whole diminished"

//  case halfWholeDim_b13
//  case hexaSh9Sh11
//  case chromatic
}

extension ScaleType: Comparable {
  static func < (lhs: ScaleType, rhs: ScaleType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

extension ScaleType: Equatable {
  static func == (lhs: ScaleType, rhs: ScaleType) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}
