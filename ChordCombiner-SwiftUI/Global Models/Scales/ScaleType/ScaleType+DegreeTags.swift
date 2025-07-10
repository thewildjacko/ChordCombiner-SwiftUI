//
//  ScaleType+DegreeTags.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

// MARK: degreeNumbers, hasDegreeTags & degreeTags
extension ScaleType {
  // MARK: hasDegreeTags
  // MARK: hasRoot
  var hasRoot: Degree? { return .root }

  // MARK: hasMinor2nd
  var hasMinor2nd: Degree? {
    switch self {
      // major modes
    case .phrygian, .locrian,
      // melodic minor modes
        .dorianFlatTwo, .superLocrian,
      // harmonic minor modes
        .locrianNaturalSix, .phrygianDominant, .ultraLocrian,
      // Harmonic Major modes
        .phrygianFlatFour, .mixolydianFlatTwo, .locrianDiminishedSeven,
      // Diminished modes
        .halfWholeDiminished:
      return .minor2nd
    default:
      return nil
    }
  }

  // MARK: hasMajor2nd
  var hasMajor2nd: Degree? {
    switch self {
      // major modes
    case .major, .dorian, .lydian, .mixolydian, .minor,
      // melodic minor modes
        .melodicMinor, .lydianAugmented, .lydianDominant,
        .mixolydianFlatSix, .locrianNaturalTwo,
      // harmonic minor modes
        .harmonicMinor, .ionianSharpFive, .dorianSharpFour,
      // Harmonic Major modes
        .harmonicMajor, .dorianFlatFive, .lydianFlatThree,
      // Blues scales
        .majorBlues,
      // Major pentatonic modes
        .pentatonic,
      // Diminished modes
        .diminished:
      return .major2nd
    default:
      return nil
    }
  }

  // MARK: hasSharp2nd
  var hasSharp2nd: Degree? {
    switch self {
      // melodic minor modes
    case .superLocrian,
      // harmonic minor modes
        .lydianSharpTwo,
      // harmonic major modes
        .aeolianFlatOne,
      // Diminished modes
        .halfWholeDiminished:
      return .sharp2nd
    default:
      return nil
    }
  }

  // MARK: hasMinor3rd
  var hasMinor3rd: Degree? {
    switch self {
      // major modes
    case .dorian, .phrygian, .minor, .locrian,
      // melodic minor modes
        .melodicMinor, .dorianFlatTwo, .locrianNaturalTwo,
      // harmonic minor modes
        .harmonicMinor, .locrianNaturalSix, .dorianSharpFour, .ultraLocrian,
      // Harmonic Major modes
        .dorianFlatFive, .phrygianFlatFour, .lydianFlatThree, .locrianDiminishedSeven,
      // Blues scales
        .blues, .majorBlues,
      // Major Pentatonic modes
        .minorPentatonic,
      // Diminished modes
        .diminished:
      return .minor3rd
    default:
      return nil
    }
  }

  // MARK: hasMajor3rd
  var hasMajor3rd: Degree? {
    switch self {
      // major modes
    case .major, .lydian, .mixolydian,
      // melodic minor modes
        .lydianAugmented, .lydianDominant, .mixolydianFlatSix, .superLocrian,
      // harmonic minor modes
        .ionianSharpFive, .phrygianDominant, .lydianSharpTwo,
      // Harmonic Major modes
        .harmonicMajor, .mixolydianFlatTwo, .aeolianFlatOne,
      // Blues scales
        .majorBlues,
      // Major pentatonic modes
        .pentatonic,
      // Diminished modes
        .halfWholeDiminished:
      return .major3rd
    default:
      return nil
    }
  }

  // MARK: hasDim4th
  var hasDim4th: Degree? {
    switch self {
      // harmonic minor modes
    case .ultraLocrian,
      // harmonic major modes
        .phrygianFlatFour:
      return .flat4th
    default:
      return nil
    }
  }

  // MARK: hasPerfect4th
  var hasPerfect4th: Degree? {
    switch self {
      // major modes
    case .major, .dorian, .phrygian, .mixolydian, .minor, .locrian,
      // melodic minor modes
        .melodicMinor, .dorianFlatTwo, .mixolydianFlatSix, .locrianNaturalTwo,
      // harmonic minor modes
        .harmonicMinor, .locrianNaturalSix, .ionianSharpFive, .phrygianDominant,
      // Harmonic Major modes
        .harmonicMajor, .dorianFlatFive, .mixolydianFlatTwo, .locrianDiminishedSeven,
      // Blues scales
        .blues,
      // Major Pentatonic modes
        .minorPentatonic,
      // Diminished modes
        .diminished:
      return .perfect4th
    default:
      return nil
    }
  }

  // MARK: hasSharp4th
  var hasSharp4th: Degree? {
    switch self {
      // major modes
    case .lydian,
      // melodic minor modes
        .lydianDominant, .lydianAugmented,
      // harmonic minor modes
        .dorianSharpFour, .lydianSharpTwo,
      // harmonic major modes
        .lydianFlatThree, .aeolianFlatOne:
      return .sharp4th
    default:
      return nil
    }
  }

  // MARK: hasDim5th
  var hasDim5th: Degree? {
    switch self {
      // major modes
    case .locrian,
      // melodic minor modes
        .locrianNaturalTwo, .superLocrian,
      // harmonic minor modes
        .locrianNaturalSix, .ultraLocrian,
      // Harmonic Major modes
        .dorianFlatFive, .locrianDiminishedSeven,
      // Blues scales
        .blues,
      // Diminished modes
        .diminished, .halfWholeDiminished:
      return .diminished5th
    default:
      return nil
    }
  }

  // MARK: hasPerfect5th
  var hasPerfect5th: Degree? {
    switch self {
    case .major, .dorian, .phrygian, .lydian, .mixolydian, .minor,
      // melodic minor modes
        .melodicMinor, .dorianFlatTwo, .lydianDominant, .mixolydianFlatSix,
      // harmonic minor modes
        .harmonicMinor, .dorianSharpFour, .phrygianDominant, .lydianSharpTwo,
      // Harmonic Major modes
        .harmonicMajor, .phrygianFlatFour, .lydianFlatThree, .mixolydianFlatTwo,
      // Blues scales
        .blues, .majorBlues,
      // Major pentatonic modes
        .pentatonic, .minorPentatonic,
      // Diminished modes
        .halfWholeDiminished:
      return .perfect5th
    default:
      return nil
    }
  }

  // MARK: hasSharp5th
  var hasSharp5th: Degree? {
    switch self {
      // melodic minor modes
    case .lydianAugmented, .superLocrian,
      // harmonic minor modes
        .ionianSharpFive,
      // harmonic major modes
      .aeolianFlatOne:
      return .sharp5th
    default:
      return nil
    }
  }

  // MARK: hasMinor6th
  var hasMinor6th: Degree? {
    switch self {
      // major modes
    case .phrygian, .minor, .locrian,
      // melodic minor modes
        .mixolydianFlatSix, .locrianNaturalTwo,
      // harmonic minor modes
        .harmonicMinor, .phrygianDominant, .ultraLocrian,
      // Harmonic Major modes
        .harmonicMajor, .phrygianFlatFour, .locrianDiminishedSeven,
      // Diminished modes
      .diminished:
      return .minor6th
    default:
      return nil
    }
  }

  // MARK: hasMajor6th
  var hasMajor6th: Degree? {
    switch self {
      // major modes
    case .major, .dorian, .lydian, .mixolydian,
      // melodic minor modes
        .melodicMinor, .dorianFlatTwo, .lydianAugmented, .lydianDominant,
      // harmonic minor modes
        .locrianNaturalSix, .ionianSharpFive, .dorianSharpFour, .lydianSharpTwo,
      // Harmonic Major modes
        .dorianFlatFive, .lydianFlatThree, .mixolydianFlatTwo, .aeolianFlatOne,
      // Blues scales
        .majorBlues,
      // Major pentatonic modes
        .pentatonic,
      // Diminished modes
        .halfWholeDiminished:
      return .major6th
    default:
      return nil
    }
  }

  // MARK: hasDim7th
  var hasDim7th: Degree? {
    switch self {
      // harmonic minor modes
    case .ultraLocrian,
      // harmonic major modes
        .locrianDiminishedSeven,
      // Diminished modes
      .diminished:
      return .diminished7th
    default:
      return nil
    }
  }

  // MARK: hasMinor7th
  var hasMinor7th: Degree? {
    switch self {
      // major modes
    case .dorian, .phrygian, .mixolydian, .minor, .locrian,
      // melodic minor modes
        .dorianFlatTwo, .lydianDominant, .mixolydianFlatSix,
        .locrianNaturalTwo, .superLocrian,
      // harmonic minor modes
        .locrianNaturalSix, .dorianSharpFour, .phrygianDominant,
      // Harmonic Major modes
        .dorianFlatFive, .phrygianFlatFour, .mixolydianFlatTwo,
      // Blues scales
        .blues,
      // Major Pentatonic modes
        .minorPentatonic,
      // Diminished modes
        .halfWholeDiminished:
      return .minor7th
    default:
      return nil
    }
  }

  // MARK: hasMajor7th
  var hasMajor7th: Degree? {
    switch self {
      // major modes
    case .major, .lydian,
      // melodic minor modes
        .melodicMinor, .lydianAugmented,
      // harmonic minor modes
        .harmonicMinor, .ionianSharpFive, .lydianSharpTwo,
      // Harmonic Major modes
        .harmonicMajor, .lydianFlatThree, .aeolianFlatOne,
      // Diminished modes
        .diminished:
      return .major7th
    default:
      return nil
    }
  }

  // MARK: hasOctave
  var hasOctave: Degree? { return .octave }

  // MARK: degreeTags
  var degreeTags: [Degree] {
    let optionalDegreeTags = [
      hasRoot,
      hasMinor2nd,
      hasMajor2nd,
      hasSharp2nd,
      hasMinor3rd,
      hasMajor3rd,
      hasDim4th,
      hasPerfect4th,
      hasSharp4th,
      hasDim5th,
      hasPerfect5th,
      hasSharp5th,
      hasMinor6th,
      hasMajor6th,
      hasDim7th,
      hasMinor7th,
      hasMajor7th,
      hasOctave]

    return optionalDegreeTags.compactMap { $0 }
  }

  var degreeNumbers: [Int] {
    Degree.degreeNumbersInC(degreeTags: degreeTags)
  }
}
