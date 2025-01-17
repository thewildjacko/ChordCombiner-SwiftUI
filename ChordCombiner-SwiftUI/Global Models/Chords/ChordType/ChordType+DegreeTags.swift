//
//  ChordType+degreeTags.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//

import Foundation

// MARK: degreeNumbers, hasDegreeTags & degreeTags
extension ChordType {
  var degreeNumbers: [Int] {
    Degree.degreeNumbersInC(degreeTags: degreeTags)
  }

  // MARK: hasDegreeTags
  // MARK: hasRoot
  var hasRoot: Degree? {
    return .root
  }

  // MARK: hasMajor2nd
  var hasMajor2nd: Degree? {
    switch baseChordType {
      // sus2 & add2
    case .sus2, .add2, .minorAdd2,
      // 7sus2
        .dominant7sus2:
      return .major2nd
    default:
      return nil
    }
  }

  // MARK: hasMinor3rd
  var hasMinor3rd: Degree? {
    switch baseChordType {
    case .mi, .dim, .mib6, .mi7, .mi7b5, .dim7, .miMa7,
        .mi6, .minorAdd4, .minorAdd2, .dimMa7:
      return .minor3rd
    default:
      return nil
    }
  }

  // MARK: hasMajor3rd
  var hasMajor3rd: Degree? {
    switch baseChordType {
    case .ma, .aug, .ma7, .dominant7, .dominant7b5, .dominant7sh5, .ma6, .add4, .add2, .ma7b5, .ma7sh5, .ma7sh5sh11:
      return .major3rd
    default:
      return nil
    }
  }

  // MARK: hasPerfect4th
  var hasPerfect4th: Degree? {
    switch baseChordType {
      // sus4 triad
    case .sus4,
      // modified triads
        .add4, .minorAdd4,
      // ma7sus4 + alterations
        .ma7sus4, .ma7sus4sh5,
      // 7sus4
        .dominant7sus4:
      return .perfect4th
    default:
      return nil
    }
  }

  // MARK: hasSharp4th
  var hasSharp4th: Degree? {
    switch self {
    default:
      return nil
    }
  }

  // MARK: hasDim5th
  var hasDim5th: Degree? {
    switch baseChordType {
    case .dim, .mi7b5, .dim7, .dominant7b5, .ma7b5, .dimMa7:
      return .diminished5th
    default:
      return nil
    }
  }

  // MARK: hasPerfect5th
  var hasPerfect5th: Degree? {
    switch self {
      // has ♭5 or ♯5
    case let chordType where chordType.hasDim5th != nil, let chordType where chordType.hasSharp5th != nil:
      return nil
    default:
      return .perfect5th
    }
  }

  // MARK: hasSharp5th
  var hasSharp5th: Degree? {
    switch self {
      // aug triad
    case .aug,
      // ma7(♯5)
        .ma7sh5, .ma9sh5, .ma13sh5, .ma13sh5omit9, .ma7sh5sh11, .ma9sh5sh11, .ma13sh5sh11, .ma13sh5sh11omit9,
      // ma7sus4(♯5)
        .ma7sus4sh5, .ma9sus4sh5,
      // 7(♯5)
        .dominant7sh5, .dominant7b9sh5, .dominant7sh9sh5, .dominant7sh5sh11, .dominant9sh5,
        .dominant7altb9sh5sh11, .dominant7altb9sh9sh5sh11, .dominant7altsh9sh5sh11:
      return .sharp5th
    default:
      return nil
    }
  }

  // MARK: hasMinor6th
  var hasMinor6th: Degree? {
    switch self {
      // Min(♭6)
    case .mib6:
      return .minor6th
    default:
      return nil
    }
  }

  // MARK: hasMajor6th
  var hasMajor6th: Degree? {
    switch baseChordType {
      // ma6 chords
    case .ma6, .mi6:
      return .major6th
      // any ˚7 chord
    case .dim7:
      return nil
    default:
      switch self {
      default:
        return nil
      }
    }
  }

  // MARK: hasDim7th
  var hasDim7th: Degree? {
    baseChordType == .dim7 ? .diminished7th : nil
  }

  // MARK: hasMinor7th
  var hasMinor7th: Degree? {
    switch baseChordType {
    case .dominant7, .dominant7b5, .dominant7sh5,
        .mi7, .mi7b5, .dominant7sus4, .dominant7sus2:
      return .minor7th
    default:
      return nil
    }
  }

  // MARK: hasMajor7th
  var hasMajor7th: Degree? {
    switch baseChordType {
    case let chordType where chordType.hasMinor7th != nil || chordType == .ma6:
      return nil
    case .ma7, .miMa7, .ma7b5, .ma7sh5, .ma7sh5sh11, .ma7sus4, .ma7sus4sh5, .dimMa7:
      return .major7th
    case .dim7:
      switch self {
      case .dim7addMa7, .dim7b13addMa7, .dim9addMa7, .dim9b13addMa7,
          .dim11addMa7, .dim11b13addMa7, .dim11addMa7omit9, .dim11b13addMa7omit9:
        return .major7th
      default:
        return nil
      }
    default:
      return nil
    }
  }

  // MARK: hasMinor9th
  var hasMinor9th: Degree? {
    switch self {
      // dom7
    case .dominant7b9, .dominant7b9sh11, .dominant7b9sh9, .dominant7b9b5,
        .dominant7b9sh5, .dominant7altb9sh9sh11, .dominant7altb9sh9b5,
        .dominant7altb9sh5sh11, .dominant7altb9sh9sh5sh11,
      // 7sus(♭9)
        .dominant7sus4b9, .dominant13sus4b9,
      // ma6
        .ma6b9, .ma6b9sh11,
      // mi7
        .mi7b9, .mi11b9, .mi13b9,
      // Phrygian
        .mi7b9b13, .mi11b9b13,
      // mi7(♭5)
        .mi7b5b9, .mi11b5b9, .locrian:
      return .flat9th
    default:
      return nil
    }
  }

  // MARK: hasMajor9th
  var hasMajor9th: Degree? {
    switch self {
      // has ♭9 or ♯9
    case let chordType where chordType.hasMinor9th != nil,
      let chordType where chordType.hasSharp9th != nil:
      return nil
      // ma7
    case .ma9, .ma13, .ma9sh11, .ma13sh11,
      // ma7sus4 + alterations
        .ma9sus4, .ma13sus4, .ma9sus4sh5,
      // ma7(♭5)
        .ma9b5, .ma13b5,
      // ma7(♯5)
        .ma9sh5, .ma13sh5, .ma9sh5sh11, .ma13sh5sh11,
      // dom7
        .dominant9, .dominant9b5, .dominant13, .dominant13b5,
        .dominant9sh11, .dominant13sh11, .dominant9sh5,
      // ma6
        .ma69, .ma69sh11,
      // mi7
        .mi9, .mi11, .mi13, .mi13omit11,
      // mi(♭13)
        .mi9b13, .mi11b13,
      // mi7(♭5)
        .mi9b5, .mi11b5, .mi11b5b13, .mi13b5, .mi13b5omit11,
      // ˚7
        .dim9, .dim9addMa7, .dim9b13, .dim9b13addMa7,
        .dim11, .dim11b13, .dim11addMa7, .dim11b13addMa7,
      // ˚ma7
        .dimMa9, .dimMa11, .dimMa9b13, .dimMa11b13,
      // mi(∆7)
        .miMa9, .miMa11, .miMa13,
      // mi6
        .mi69, .mi6911,
      // 7sus4
        .dominant9sus4, .dominant13sus4:
      return .major9th
    default:
      return nil
    }
  }

  // MARK: hasSharp9th
  var hasSharp9th: Degree? {
    switch self {
      // ma6
    case .ma6sh9, .ma6sh9sh11,
      // dom7
        .dominant7sh9, .dominant7b9sh9, .dominant7sh9sh11, .dominant7sh9b5,
        .dominant7sh9sh5, .dominant7altb9sh9sh11, .dominant7altb9sh9b5, .dominant7altb9sh9sh5sh11, .dominant7altsh9sh5sh11:
      return .sharp9th
    default:
      return nil
    }
  }

  // MARK: hasPerfect11th
  var hasPerfect11th: Degree? {
    switch self {
      // dorian
    case .mi11, .mi11omit9, .mi13, .mi13omit9,
      // phrygian
        .mi11b9, .mi11b9b13, .mi13b9,
      // mi(♭13)
        .mi11b13, .mi11b13omit9,
      // mi7(♭5)
        .mi7b5add11, .mi11b5, .mi11b5b9, .mi11b5b13, .locrian, .mi13b5, .mi13b5omit9,
      // ˚7
        .dim11, .dim7add11, .dim11b13, .dim11b13omit9, .dim11addMa7,
        .dim11addMa7omit9, .dim11b13addMa7, .dim11b13addMa7omit9,
      // ˚ma7
        .dimMa11, .dimMa11b13, .dimMa11b13omit9,
      // mi(∆7)
        .miMa11, .miMa13, .miMa11omit9, .miMa13omit9,
      // mi6
        .mi6911:
      return .perfect11th
    default:
      return nil
    }
  }

  // MARK: hasSharp11th
  var hasSharp11th: Degree? {
    switch self {
      // ma7(♯11)
    case .ma7sh11, .ma9sh11, .ma13sh11, .ma13sh11omit9,
        .ma7sh5sh11, .ma9sh5sh11, .ma13sh5sh11, .ma13sh5sh11omit9,
      // dom7(♯11)
        .dominant7sh11, .dominant7b9sh11, .dominant7sh9sh11, .dominant9sh11,
        .dominant13sh11, .dominant13sh11omit9, .dominant7altb9sh9sh11, .dominant7sh5sh11,
        .dominant7altb9sh5sh11, .dominant7altb9sh9sh5sh11, .dominant7altsh9sh5sh11,
      // ma6(♯11)
        .ma6sh9sh11, .ma6b9sh11, .ma6sh11, .ma69sh11:
      return .sharp11th
    default:
      return nil
    }
  }

  // MARK: hasMinor13th
  var hasFlat13th: Degree? {
    switch self {
      // Min(♭13)
    case .mi7b13, .mi9b13, .mi11b13, .mi11b13omit9,
      // Phrygian
        .mi7b9b13, .mi11b9b13,
      // mi7(♭5)
        .mi11b5b13, .mi7b5b13, .locrian,
      // ˚7
        .dim7b13, .dim9b13, .dim11b13, .dim11b13omit9, .dim7b13addMa7,
        .dim9b13addMa7, .dim11b13addMa7, .dim11b13addMa7omit9,
      // ˚ma7
        .dimMa7b13, .dimMa9b13, .dimMa11b13, .dimMa11b13omit9:
      return .flat13th
    default:
      return nil
    }
  }

  // MARK: hasMajor13th
  var hasMajor13th: Degree? {
    switch baseChordType {
      // ma6 chords and ˚7 chords
    case .ma6, .dim7:
      return nil
    default:
      switch self {
        // has ♭6
      case let chordType where chordType.hasMinor6th != nil ||
        chordType.hasFlat13th != nil:
        return nil
        // Extended Major 7th chords
      case .ma13, .ma13omit9, .ma13sh11, .ma13sh11omit9,
        // ma7sus4
          .ma13sus4, .ma13sus4omit9,
        // ma7(♭5)
          .ma13b5, .ma13b5omit9,
        // ma7(♯5)
          .ma13sh5, .ma13sh5omit9, .ma13sh5sh11, .ma13sh5sh11omit9,
        // Extended Dominant 7th Chords
          .dominant13, .dominant13sh11, .dominant13sh11omit9,
          .dominant13b5, .dominant13omit9, .dominant13b5omit9,
        // Extended Minor 7th chords
          .mi13, .mi13omit9, .mi13omit11, .mi7add13, .mi13b9,
        // Extended Min7(♭5) chords
          .mi13b5, .mi13b5omit9, .mi13b5omit11, .mi7b5add13,
        // mi(∆7)
          .miMa13, .miMa13omit9,
        // 7sus4
          .dominant13sus4, .dominant13sus4omit9, .dominant13sus4b9,
        // 7sus2
          .dominant13sus2:
        return .major13th
      default:
        return nil
      }
    }
  }

  // MARK: degreeTags
  var degreeTags: [Degree] {
    let optionalDegreeTags = [hasRoot,
                              hasMajor2nd,
                              hasMinor3rd,
                              hasMajor3rd,
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
                              hasMinor9th,
                              hasMajor9th,
                              hasSharp9th,
                              hasPerfect11th,
                              hasSharp11th,
                              hasFlat13th,
                              hasMajor13th]

    return optionalDegreeTags.compactMap { $0 }
  }
}
