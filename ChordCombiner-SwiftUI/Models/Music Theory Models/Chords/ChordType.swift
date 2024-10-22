//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, ChordAndScaleProperty {
  var id: Self { return self }
  
  // MARK: Triads
  case ma = ""      // [0, 4, 7]
  case mi           // [0, 3, 7]
  case aug = "+"    // [0, 4, 8]
  case dim = "˚"    // [0, 3, 6]
  case sus4         // [0, 5, 7]
  case sus2         // [0, 2, 7]
  
  // MARK: Modified Triads
  case add4 = "add4"               // [0, 4, 5, 7] -> ma7(sus2) 2nd inversion
  case mi_add4 = "mi(add4)"        // [0, 3, 5, 7]
  case add2 = "add2"               // [0, 2, 4, 7]
  case mi_add2 = "mi(add2)"        // [0, 2, 3, 7]
  
  // MARK: Major Lydian 7th Chords
  case ma7                                   // [0, 4, 7, 11]
  case ma9                                   // [0, 2, 4, 7, 11]
  case ma13                                  // [0, 2, 4, 7, 9, 11]
  case ma13_omit9 = "ma13(omit9)"            // [0, 4, 7, 9, 11]
  case ma7_sh11 = "ma7(♯11)"                 // [0, 4, 6, 7, 11]
  case ma9_sh11 = "ma9(♯11)"                 // [0, 2, 4, 6, 7, 11]
  case ma13_sh11 = "ma13(♯11)"               // [0, 2, 4, 6, 7, 9, 11]
  case ma13_sh11_omit9 = "ma13(♯11 omit9)"   // [0, 4, 6, 7, 9, 11]
  
  // MARK: Altered Major 7th Chords
  case ma7_b5 = "ma7(♭5)"                            // [0, 4, 6, 11]
  case ma9_b5 = "ma9(♭5)"                            // [0, 4, 6, 11]
  case ma13_b5 = "ma13(♭5)"                          // [0, 2, 4, 6, 9, 11]
  case ma13_b5_omit9 = "ma13(♭5 omit9)"              // [0, 4, 6, 9, 11]
  case ma7_sh5 = "ma7(♯5)"                           // [0, 4, 8, 11]
  case ma9_sh5 = "ma9(♯5)"                           // [0, 2, 4, 8, 11]
  case ma13_sh5 = "ma13(♯5)"                         // [0, 2, 4, 8, 9, 11]
  case ma13_sh5_omit9 = "ma13(♯5 omit9)"             // [0, 4, 8, 9, 11]
  case ma7_b5_sh5 = "ma7(♭5♯5)"                      // [0, 4, 6, 8, 11]
  case ma9_b5_sh5 = "ma9(♭5♯5)"                      // [0, 4, 6, 8, 11]
  case ma13_b5_sh5 = "ma13(♭5♯5)"                    // [0, 2, 4, 6, 8, 9, 11]
  case ma13_b5_sh5_omit9 = "ma13(♭5♯5 omit9)"        // [0, 4, 6, 8, 9, 11]
  
  // TODO: add more dominant chords
  // MARK: Dominant 7th Chords
  // 7th chords
  case dominant7 = "7"                                   // [0, 4, 7, 10]
  case dominant9 = "9"                                   // [0, 2, 4, 7, 10]
  case dominant13 = "13"                                 // [0, 2, 4, 7, 9, 10]
  case dominant13_omit9 = "13(omit9)"                    // [0, 4, 7, 9, 10]
  // ♭9
  case dominant7_b9 = "7(♭9)"                            // [0, 1, 4, 7, 10]
  case dominant7_b9_b5 = "7(♭9♭5)"                       // [0, 1, 4, 6, 10]
  case dominant7_b9_sh5 = "7(♭9♯5)"                      // [0, 1, 4, 8, 10]
  case dominant7_b9_sh9 = "7(♭9♯9)"                      // [0, 1, 3, 4, 7, 10]
  case dominant7_b9_sh11 = "7(♭9♯11)"                    // [0, 1, 4, 6, 7, 10]
  case dominant7_alt_b9_sh9_sh11 = "7alt(♭9♯9♯11)"       // [0, 1, 3, 4, 6, 7, 10]
  case dominant7_alt_b9_sh9_b5 = "7alt(♭9♯9♭5)"          // [0, 1, 3, 4, 6, 10]
  // ♯9
  case dominant7_sh9 = "7(♯9)"                           // [0, 3, 4, 7, 10]
  case dominant7_sh9_b5 = "7(♯9♭5)"                      // [0, 3, 4, 6, 10]
  case dominant7_sh9_sh5 = "7(♯9♯5)"                     // [0, 3, 4, 8, 10]
  case dominant7_sh9_sh11 = "7(♯9♯11)"                   // [0, 3, 4, 6, 7, 10]
  // ♯11
  case dominant7_sh11 = "7(♯11)"                         // [0, 4, 6, 7, 10]
  case dominant9_sh11 = "9(♯11)"                         // [0, 2, 4, 6, 7, 10]
  case dominant13_sh11 = "13(♯11)"                       // [0, 2, 4, 6, 7, 9, 10]
  case dominant13_sh11_omit9 = "13(♯11 omit9)"           // [0, 4, 6, 7, 9, 10]
  // ♭5
  case dominant7_b5 = "7(♭5)"                            // [0, 4, 6, 10]
  case dominant9_b5 = "9(♭5)"                            // [0, 2, 4, 6, 10]
  case dominant13_b5 = "13(♭5)"                          // [0, 2, 4, 6, 9, 10]
  case dominant13_b5_omit9 = "13(♭5 omit9)"              // [0, 4, 6, 9, 10]
  case dominant9_sh5 = "9(♯5)"                           // [0, 2, 4, 8, 10]
  case dominant7_b5_sh5 = "7(♭5♯5)"                      // [0, 4, 6, 8, 10]
  // ♯5
  case dominant7_sh5 = "7(♯5)"                           // [0, 4, 8, 10]
  
  // MARK: 7sus4
  case dominant7sus4 = "7sus4"                              // [0, 5, 7, 10]
  case dominant9sus4 = "9sus4"                              // [0, 2, 5, 7, 10]
  case dominant13sus4 = "13sus4"                            // [0, 2, 5, 7, 9, 10]
  case dominant13sus4_omit9 = "13sus4(omit9)"               // [0, 5, 7, 9, 10]
  
  // MARK: 7sus2
  case dominant7sus2 = "7sus2"                              // [0, 2, 7, 10]
  case dominant13sus2 = "13sus2"                            // [0, 2, 7, 9, 10]
  
  // MARK: Minor Dorian 7th Chords
  case mi7                                 // [0, 3, 7, 10]
  case mi9                                 // [0, 2, 3, 7, 10]
  case mi11                                // [0, 2, 3, 5, 7, 10]
  case mi11_omit9 = "mi11(omit9)"          // [0, 3, 5, 7, 10]
  case mi13                                // [0, 2, 3, 5, 7, 9, 10]
  case mi13_omit9 = "mi13(omit9)"          // [0, 3, 5, 7, 9, 10]
  case mi13_omit11 = "mi13(omit11)"        // [0, 2, 3, 7, 9, 10]
  case mi7_add13 = "mi7(add13)"            // [0, 3, 7, 9, 10]
  
  // MARK: Phrygian
  case mi7_b9 = "mi7(♭9)"                  // [0, 1, 3, 7, 10]
  case mi7_b9b13  = "mi7(♭9♭13)"           // [0, 1, 3, 7, 8, 10]
  case mi11_b9 = "mi11(♭9)"                // [0, 1, 3, 5, 7, 10]
  case mi11_b9b13 = "mi11(♭9♭13)"          // [0, 1, 3, 5, 7, 8, 10]
  case mi13_b9 = "mi13(♭9)"                // [0, 1, 3, 5, 7, 9, 10]
  
  // MARK: Min(♭13)
  case mi_b6 = "mi(♭6)"                    // [0, 3, 7, 8]
  case mi7_b13 = "mi7(♭13)"                // [0, 3, 7, 8, 10]
  case mi9_b13 = "mi9(♭13)"                // [0, 2, 3, 7, 8, 10]
  case mi11_b13 = "mi11(♭13)"              // [0, 2, 3, 5, 7, 8, 10]
  case mi11_b13_omit9 = "mi11(♭13 omit9)"  // [0, 3, 5, 7, 8, 10]
  
  // MARK: mi7(♭5)
  case mi7_b5 = "mi7(♭5)"                  // [0, 3, 6, 10]
  case mi9_b5 = "mi9(♭5)"                  // [0, 2, 3, 6, 10]
  case mi7_b5add11 = "mi7(♭5add11)"        // [0, 3, 5, 6, 10]
  case mi11_b5 = "mi11(♭5)"                // [0, 2, 3, 5, 6, 10]
  case mi11_b5b13 = "mi11(♭5♭13)"          // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
  case mi7_b5b9 = "mi7(♭5♭9)"              // [0, 1, 3, 6, 10]
  case mi11_b5b9 = "mi11(♭5♭9)"            // [0, 1, 3, 5, 6, 10]
  case mi7_b5b13 = "mi7(♭5♭13)"            // [0, 3, 6, 8, 10]
  case locrian = " locrian"                // [0, 1, 3, 5, 6, 8, 10] (mi11(♭5♭9♭13))
  case mi13_b5 = "mi13(♭5)"                // [0, 2, 3, 5, 6, 9, 10] (dorian ♭5 / 2nd mode harmonic major)
  case mi13_b5_omit9 = "mi13(♭5 omit9)"    // [0, 3, 5, 6, 9, 10]
  case mi13_b5_omit11 = "mi13(♭5 omit11)"    // [0, 2, 3, 6, 9, 10]
  case mi7_b5add13 = "mi7(♭5 add13)"       // [0, 3, 6, 9, 10]
  
  // MARK: diminished
  case dim7 = "˚7"                                      // [0, 3, 6, 9]
  case dim7_b13 = "˚7(♭13)"                             // [0, 3, 6, 8, 9]
  case dim7_add_ma7 = "˚7(add∆7)"                       // [0, 3, 6, 9, 11]
  case dim7_b13_add_ma7 = "˚7(♭13add∆7)"                // [0, 3, 6, 8, 9, 11]
  case dim9 = "˚9"                                      // [0, 2, 3, 6, 9]
  case dim9_add_ma7 = "˚9(add∆7)"                       // [0, 2, 3, 6, 9, 11]
  case dim9_b13 = "˚9(♭13)"                             // [0, 2, 3, 6, 8, 9]
  case dim9_b13_add_ma7 = "˚9(♭13add∆7)"                // [0, 2, 3, 6, 8, 9, 11]
  case dim11 = "˚11"                                    // [0, 2, 3, 5, 6, 9]
  case dim7_add11 = "˚7(add11)"                         // [0, 3, 5, 6, 9]
  case dim11_b13 = "˚11(♭13)"                           // [0, 2, 3, 5, 6, 8, 9]
  case dim11_b13_omit9 = "˚11(♭13 omit9)"               // [0, 3, 5, 6, 8, 9]
  case dim11_add_ma7 = "˚11(add∆7)"                     // [0, 2, 3, 5, 6, 9, 11]
  case dim11_add_ma7_omit9 = "˚11(add∆7 omit9)"         // [0, 3, 5, 6, 9, 11]
  case dim11_b13_add_ma7 = "˚11(♭13add∆7)"              // [0, 2, 3, 5, 6, 8, 9, 11]
  case dim11_b13_add_ma7_omit9 = "˚11(♭13add∆7 omit9)"  // [0, 3, 5, 6, 8, 9, 11]
  
  // MARK: Major 6
  case ma6 = "6"                           // [0, 4, 7, 9]
  case ma6_sh9 = "6(♯9)"                   // [0, 3, 4, 7, 9]
  case ma6_b9 = "6(♭9)"                    // [0, 1, 4, 7, 9]
  case ma6_sh9_sh11 = "6(♯9♯11)"           // [0, 3, 4, 6, 7, 9]
  case ma6_b9sh11 = "6(♭9♯11)"             // [0, 1, 4, 6, 7, 9]
  case ma6_sh11 = "6(♯11)"                 // [0, 4, 6, 7, 9]
  case ma6_9 = "⁶/₉"                       // [0, 2, 4, 7, 9]
  case ma6_9sh11 = "⁶/₉(♯11)"              // [0, 2, 4, 6, 7, 9]
  
  // MARK: minor 6
  case mi6 = "mi6"                         // [0, 3, 7, 9]
  case mi6_9 = "mi⁶/₉"                     // [0, 3, 4, 7, 9]
  case mi6_9_11 = "mi⁶/₉(11)"              // [0, 3, 4, 5, 7, 9]
  
  // MARK: mi(∆7)
  case mi_ma7 = "mi(∆7)"                       // [0, 3, 7, 11]
  case mi_ma9 = "mi(∆9)"                       // [0, 2, 3, 7, 11]
  case mi_ma11 = "mi(∆11)"                     // [0, 2, 3, 5, 7, 11]
  case mi_ma11_omit9 = "mi(∆11 omit9)"         // [0, 3, 5, 7, 11]
  case mi_ma13 = "mi(∆13)"                     // [0, 2, 3, 5, 7, 9, 11]
  case mi_ma13_omit9 = "mi(∆13 omit9)"         // [0, 3, 5, 7, 9, 11]
  
  var preciseName: String { self == .ma ? "ma" : self.rawValue }
  
  // MARK: commonName
  var commonName: String {
    switch self {
    case .ma13_omit9:
      return "ma13"
    case .ma13_sh11_omit9:
      return "ma13(♯11)"
    case .dominant13_omit9:
      return "13"
    case .dominant7_alt_b9_sh9_sh11:
      return "7alt"
    case .dominant13_sh11_omit9:
      return "13(♯11)"
    case .dominant13_b5_omit9:
      return "13(♭5)"
    case .mi11_omit9:
      return "mi11"
    case .mi13_omit9, .mi13_omit11:
      return "mi13"
    case .mi11_b13_omit9:
      return "mi11(♭13)"
    case .mi13_b5_omit9, .mi13_b5_omit11:
      return "mi13(♭5)"
    case .dim11_b13_omit9:
      return "˚11(♭13)"
    case .dim11_add_ma7_omit9:
      return "˚11(add∆7)"
    case .dim11_b13_add_ma7_omit9:
      return "˚11(♭13 add∆7)"
    default:
      return rawValue
    }
  }
  
  // MARK: baseChordType
  var baseChordType: ChordType {
    switch self {
      // Triads
    case .ma, .mi, .aug, .dim, .sus4, .sus2,
      // Modified triads
        .add4, .add2, .mi_b6, .mi_add4, .mi_add2:
      return self
      // Major 7th chords
    case .ma7, .ma9, .ma13, .ma13_omit9, .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9:
      return .ma7
      // Altered Major 7th Chords
      // ma7(♭5)
    case .ma7_b5, .ma9_b5, .ma13_b5, .ma13_b5_omit9:
      return .ma7_b5
      // ma7(♯5)
    case .ma7_sh5, .ma9_sh5, .ma13_sh5, .ma13_sh5_omit9:
      return .ma7_sh5
      // ma7(♭5♯5)
    case  .ma7_b5_sh5, .ma9_b5_sh5, .ma13_b5_sh5, .ma13_b5_sh5_omit9:
      return .ma7_b5_sh5
      // Dominant 7th Chords
      // TODO: add dominant baseChordTypes
      // unaltered
    case .dominant7,
        .dominant9,
        .dominant13,
        .dominant13_omit9,
      // ♭9
        .dominant7_b9,
        .dominant7_b9_sh9,
        .dominant7_b9_sh11,
        .dominant7_alt_b9_sh9_sh11,
      // ♯9
        .dominant7_sh9,
        .dominant7_sh9_sh11,
      // ♯11
        .dominant7_sh11,
        .dominant9_sh11,
        .dominant13_sh11,
        .dominant13_sh11_omit9:
      return .dominant7
      // 7(♭5)
    case .dominant7_b5,
        .dominant9_b5,
        .dominant13_b5,
        .dominant13_b5_omit9,
        .dominant7_b5_sh5,
        .dominant7_b9_b5,
        .dominant7_alt_b9_sh9_b5,
        .dominant7_sh9_b5:
      return .dominant7_b5
      // 7(♯5)
    case .dominant7_sh5,
        .dominant9_sh5,
        .dominant7_b9_sh5,
        .dominant7_sh9_sh5:
      return .dominant7_sh5
      // 7sus4, 7sus2
    case .dominant7sus4, .dominant9sus4, .dominant13sus4, .dominant13sus4_omit9:
      return .dominant7sus4
    case .dominant7sus2, .dominant13sus2:
      return .dominant7sus2
      // Minor 7th chords
    case .mi7, .mi9, .mi11, .mi11_omit9, .mi13, .mi13_omit9, .mi13_omit11, .mi7_add13, .mi7_b13, .mi9_b13, .mi11_b13, .mi11_b13_omit9, .mi7_b9, .mi7_b9b13, .mi11_b9, .mi11_b9b13, .mi13_b9:
      return .mi7
      // Min7(♭5) chords
    case .mi7_b5, .mi9_b5, .mi7_b5add11, .mi11_b5, .mi11_b5b13, .mi7_b5b9, .mi11_b5b9, .mi7_b5b13, .locrian, .mi13_b5, .mi13_b5_omit9, .mi13_b5_omit11, .mi7_b5add13:
      return .mi7_b5
      // Diminished
    case .dim7, .dim7_b13, .dim7_add_ma7, .dim7_b13_add_ma7, .dim9, .dim9_add_ma7, .dim9_b13, .dim9_b13_add_ma7, .dim11, .dim11_b13, .dim11_add_ma7, .dim11_b13_add_ma7, .dim7_add11, .dim11_b13_omit9, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
      return .dim7
      // Major 6th chords
    case .ma6, .ma6_sh9, .ma6_b9, .ma6_sh9_sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9, .ma6_9sh11:
      return .ma6
      // minor 6
    case .mi6, .mi6_9, .mi6_9_11:
      return .mi6
      // mi(∆7)
    case .mi_ma7, .mi_ma9, .mi_ma11, .mi_ma13, .mi_ma11_omit9, .mi_ma13_omit9:
      return .mi_ma7
      
    }
  }
  
  // MARK: degrees
  
  var degrees: [Int] {
    Degree.degreesInC(degreeTags: degreeTags)
  }
  
  // MARK: hasDegreeTags
  
  // TODO: add dominant degree tags
  // MARK: hasRoot
  var hasRoot: Degree? {
    return .root
  }
  
  // MARK: hasMajor2nd
  var hasMajor2nd: Degree? {
    switch baseChordType {
      // sus2 & add2
    case .sus2, .add2, .mi_add2,
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
    case .mi, .dim, .mi_b6, .mi7, .mi7_b5, .dim7, .mi_ma7, .mi6, .mi_add4, .mi_add2:
      return .minor3rd
    default:
      return nil
    }
  }
  
  // MARK: hasMajor3rd
  var hasMajor3rd: Degree? {
    switch baseChordType {
    case .ma, .aug, .ma7, .dominant7, .dominant7_b5, .dominant7_sh5, .ma6, .add4, .add2, .ma7_b5, .ma7_sh5, .ma7_b5_sh5:
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
        .add4, .mi_add4,
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
    case .dim, .mi7_b5, .dim7, .dominant7_b5, .ma7_b5, .ma7_b5_sh5:
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
        .ma7_sh5, .ma9_sh5, .ma13_sh5, .ma13_sh5_omit9, .ma7_b5_sh5, .ma9_b5_sh5, .ma13_b5_sh5, .ma13_b5_sh5_omit9,
      // 7(♯5)
        .dominant7_sh5, .dominant7_b9_sh5, .dominant7_sh9_sh5, .dominant7_b5_sh5, .dominant9_sh5:
      return .sharp5th
    default:
      return nil
    }
  }
  
  // MARK: hasMinor6th
  var hasMinor6th: Degree? {
    switch self {
      // Min(♭6)
    case .mi_b6:
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
    case .dominant7, .dominant7_b5, .dominant7_sh5, .mi7, .mi7_b5, .dominant7sus4, .dominant7sus2:
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
    case .ma7, .mi_ma7, .ma7_b5, .ma7_sh5, .ma7_b5_sh5:
      return .major7th
    case .dim7:
      switch self {
      case .dim7_add_ma7, .dim7_b13_add_ma7, .dim9_add_ma7, .dim9_b13_add_ma7, .dim11_add_ma7, .dim11_b13_add_ma7, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
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
    case .dominant7_b9, .dominant7_b9_sh11, .dominant7_b9_sh9, .dominant7_b9_b5, .dominant7_b9_sh5, .dominant7_alt_b9_sh9_sh11, .dominant7_alt_b9_sh9_b5,
      // ma6
        .ma6_b9, .ma6_b9sh11,
      // mi7
        .mi7_b9, .mi11_b9, .mi13_b9,
      // Phrygian
        .mi7_b9b13, .mi11_b9b13,
      // mi7(♭5)
        .mi7_b5b9, .mi11_b5b9, .locrian:
      return .flat9th
    default:
      return nil
    }
  }
  
  // MARK: hasMajor9th
  var hasMajor9th: Degree? {
    switch self {
      // has ♭9 or ♯9
    case let chordType where chordType.hasMinor9th != nil, let chordType where chordType.hasSharp9th != nil:
      return nil
      // ma7
    case .ma9, .ma13, .ma9_sh11, .ma13_sh11,
      // ma7(♭5)
        .ma9_b5, .ma13_b5,
      // ma7(♯5)
        .ma9_sh5, .ma13_sh5, .ma9_b5_sh5, .ma13_b5_sh5,
      // dom7
        .dominant9, .dominant9_b5, .dominant13, .dominant13_b5, .dominant9_sh11, .dominant13_sh11, .dominant9_sh5,
      // ma6
        .ma6_9, .ma6_9sh11,
      // mi7
        .mi9, .mi11, .mi13, .mi13_omit11,
      // mi(♭13)
        .mi9_b13, .mi11_b13,
      // mi7(♭5)
        .mi9_b5, .mi11_b5, .mi11_b5b13, .mi13_b5, .mi13_b5_omit11,
      // ˚7
        .dim9, .dim9_add_ma7, .dim9_b13, .dim9_b13_add_ma7, .dim11, .dim11_b13, .dim11_add_ma7, .dim11_b13_add_ma7,
      // mi(∆7)
        .mi_ma9, .mi_ma11, .mi_ma13,
      // mi6
        .mi6_9, .mi6_9_11,
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
    case .ma6_sh9, .ma6_sh9_sh11,
      // dom7
        .dominant7_sh9, .dominant7_b9_sh9, .dominant7_sh9_sh11, .dominant7_sh9_b5, .dominant7_sh9_sh5, .dominant7_alt_b9_sh9_sh11, .dominant7_alt_b9_sh9_b5:
      return .sharp9th
    default:
      return nil
    }
  }
  
  // MARK: hasPerfect11th
  var hasPerfect11th: Degree? {
    switch self {
      // dorian
    case .mi11, .mi11_omit9, .mi13, .mi13_omit9,
      // phrygian
        .mi11_b9, .mi11_b9b13, .mi13_b9,
      // mi(♭13)
        .mi11_b13, .mi11_b13_omit9,
      // mi7(♭5)
        .mi7_b5add11, .mi11_b5, .mi11_b5b9, .mi11_b5b13, .locrian, .mi13_b5, .mi13_b5_omit9,
      // ˚7
        .dim11, .dim7_add11, .dim11_b13, .dim11_b13_omit9, .dim11_add_ma7, .dim11_add_ma7_omit9, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9,
      // mi(∆7)
        .mi_ma11, .mi_ma13, .mi_ma11_omit9, .mi_ma13_omit9,
      // mi6
        .mi6_9_11:
      return .perfect11th
    default:
      return nil
    }
  }
  
  // MARK: hasSharp11th
  var hasSharp11th: Degree? {
    switch self {
      // ma7(♯11)
    case .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9,
      // dom7(♯11)
        .dominant7_sh11, .dominant7_b9_sh11, .dominant7_sh9_sh11, .dominant9_sh11, .dominant13_sh11, .dominant13_sh11_omit9, .dominant7_alt_b9_sh9_sh11,
      // ma6(♯11)
        .ma6_sh9_sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9sh11:
      return .sharp11th
    default:
      return nil
    }
  }
  
  // MARK: hasMinor13th
  var hasFlat13th: Degree? {
    switch self {
      // Min(♭13)
    case .mi7_b13, .mi9_b13, .mi11_b13, .mi11_b13_omit9,
      // Phrygian
        .mi7_b9b13, .mi11_b9b13,
      // mi7(♭5)
        .mi11_b5b13, .mi7_b5b13, .locrian,
      // ˚7
        .dim7_b13, .dim9_b13, .dim11_b13, .dim11_b13_omit9, .dim7_b13_add_ma7, .dim9_b13_add_ma7, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9:
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
      case let chordType where chordType.hasMinor6th != nil || chordType.hasFlat13th != nil:
        return nil
        // Extended Major 7th chords
      case .ma13, .ma13_omit9, .ma13_sh11, .ma13_sh11_omit9,
        // ma7(♭5)
          .ma13_b5, .ma13_b5_omit9,
        // ma7(♯5)
          .ma13_sh5, .ma13_sh5_omit9, .ma13_b5_sh5, .ma13_b5_sh5_omit9,
        // Extended Dominant 7th Chords
          .dominant13, .dominant13_sh11, .dominant13_sh11_omit9, .dominant13_b5, .dominant13_omit9, .dominant13_b5_omit9,
        // Extended Minor 7th chords
          .mi13, .mi13_omit9, .mi13_omit11, .mi7_add13, .mi13_b9,
        // Extended Min7(♭5) chords
          .mi13_b5, .mi13_b5_omit9, .mi13_b5_omit11, .mi7_b5add13,
        // mi(∆7)
          .mi_ma13, .mi_ma13_omit9,
        // 7sus4
          .dominant13sus4, .dominant13sus4_omit9,
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
  
  // MARK: degreeTagGroups
  var has2nd: Bool {
    degreeTags.intersectsWith([.major2nd])
  }
  
  var has3rd: Bool {
    degreeTags.intersectsWith([.major3rd, .minor3rd])
  }
  
  var has4th: Bool {
    degreeTags.intersectsWith([.perfect4th, .sharp4th])
  }
  
  var has5th: Bool {
    degreeTags.intersectsWith([.diminished5th, .perfect5th, .sharp5th])
  }
  
  var has6th: Bool {
    degreeTags.intersectsWith([.major6th, .minor6th])
  }
  
  var has7th: Bool {
    degreeTags.intersectsWith([.major7th, .minor7th, .diminished7th])
  }
  
  var has9th: Bool {
    degreeTags.intersectsWith([.flat9th, .major9th, .sharp9th])
  }
  
  var is9thChord: Bool {
    degreeTags.intersectsWith([.flat9th, .major9th, .sharp9th]) && !(degreeTags.intersectsWith([.perfect11th, .sharp11th]) && degreeTags.intersectsWith([.major13th, .flat13th]))
  }
  
  var has11th: Bool {
    degreeTags.intersectsWith([.perfect11th, .sharp11th])
  }
  
  var is11thChord: Bool {
    degreeTags.intersectsWith([.perfect11th, .sharp11th]) && !degreeTags.intersectsWith([.major13th, .flat13th])
  }
  
  var is13thChord: Bool {
    degreeTags.intersectsWith([.major13th, .flat13th])
  }
  
  var hasOneMiddleTriadNote: Bool {
    (has2nd || has3rd || has4th)
  }
  
  var hasTwoMiddleTriadNotes: Bool {
    (has2nd && has3rd) || (has2nd && has4th) || (has3rd && has4th)
  }
  
  var isTriad: Bool {
    degrees.count == 3 &&
    degreeTags.contains(.root) &&
    hasOneMiddleTriadNote &&
    !hasTwoMiddleTriadNotes &&
    has5th
  }
  
  var isModifiedTriad: Bool {
    degreeTags.contains(.root) &&
    hasTwoMiddleTriadNotes &&
    has5th
  }
  
  var isExtendedChord: Bool {
    degreeTags.intersectsWith(
      [
        .flat9th,
        .major9th,
        .sharp9th,
        .perfect11th,
        .sharp11th,
        .major13th,
        .flat13th
      ]
    )
  }
  
  var isFourNote6thChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    has6th
  }
  
  var isFourNote7thChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    has7th
  }
  
  var isFourNoteSimpleChord: Bool {
    degreeTags.count == 4 &&
    !isExtendedChord &&
    (has6th || has7th || isModifiedTriad)
  }
  
  var isSimpleChord: Bool {
    isTriad || isFourNoteSimpleChord
  }
}


extension ChordType: Comparable {
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

// MARK: static properties
extension ChordType {
  static var allSimpleChordTypes: [ChordType] {
    ChordType.allCases.filterInSimple()
  }
  
  static var allChordDegrees: [[Int]] {
    ChordType.allCases.map { $0.degrees }
  }
  
  static var typeByDegrees: [[Int]: ChordType] = Dictionary(uniqueKeysWithValues: zip(allChordDegrees, allCases))
  
  static func typeByDegreesFiltered(degreeCount: Int) -> [[Int]: ChordType] {
    typeByDegrees.filter { $0.key.count == degreeCount }
  }
  
  static let triadTypes: [ChordType] = [.ma, .mi, .aug, .dim, .sus4, .sus2]
  static let primary7thChords: [ChordType] = [.ma7, .dominant7, .mi7, .mi7_b5, .dim7, .mi_ma7]
  static let extendedMajor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .ma7 && $0 != .ma7 }
  static let alteredMajor7thChords: [ChordType] =  ChordType.allCases.filter { $0.baseChordType == .ma7_b5 || $0.baseChordType == .ma7_sh5 || $0.baseChordType == .ma7_b5_sh5 }
  static let extendedDominantChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7 && $0 != .dominant7 }
  static let extendedDominant7_b5_Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7_b5 }
  static let extendedDominant7_sh5_Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7_sh5 }
  static let suspendedDominant7_Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7sus4 || $0.baseChordType == .dominant7sus2 }
  static let extendedMinor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi7 && $0 != .mi7 && !minorFlat13Chords.contains($0) && !phrygianChords.contains($0) }
  static let extendedMinor7th_b5Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi7_b5 && $0 != .mi7_b5 }
  static let extendedDiminishedChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dim7 && $0 != .dim7 }
  static let extendedMajor6thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .ma6 }
  static let extendedMinor6thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi6 }
  static let extendedMinorMajor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi_ma7 && $0 != .mi_ma7}
  static let modifiedTriadTypes: [ChordType] = [.add4, .mi_add4, .add2, .mi_add2]
  
  static let phrygianChords: [ChordType] = [
    .mi7_b9,
    .mi7_b9b13,
    .mi11_b9,
    .mi11_b9b13,
    .mi13_b9
  ]
  
  static let minorFlat13Chords: [ChordType] = [
    .mi_b6,
    .mi7_b13,
    .mi9_b13,
    .mi11_b13,
    .mi11_b13_omit9
  ]
  
  static let allChordTypeArrays: [[ChordType]] = [
    triadTypes,
    primary7thChords,
    extendedMajor7thChords,
    alteredMajor7thChords,
    extendedDominantChords,
    extendedDominant7_b5_Chords,
    extendedDominant7_sh5_Chords,
    suspendedDominant7_Chords,
    extendedMinor7thChords,
    extendedMinor7th_b5Chords,
    extendedDiminishedChords,
    extendedMajor6thChords,
    extendedMinor6thChords,
    phrygianChords,
    minorFlat13Chords,
    extendedMinorMajor7thChords,
    modifiedTriadTypes
  ]
  
  static let sectionTitles: [String] = [
    "Triads",
    "Primary 7th Chords",
    "Extended Major 7th Chords",
    "Altered Major 7th Chords",
    "Extended Dominant Chords",
    "Extended 7(♭5) Chords",
    "Extended 7(♯5) Chords",
    "Suspended Dominant Chords",
    "Extended Minor 7th Chords",
    "Extended mi7(♭5) Chords",
    "Extended Diminished Chords",
    "Extended Major 6th Chords",
    "Extended Minor 6th Chords",
    "Phrygian Chords",
    "Extended Min(♭13) Chords",
    "Extended mi(∆7) Chords",
    "Modified Triads"
  ]
  
  static let sectionTagNames: [String] = [
    "Triads",
    "Std. 7ths",
    "ma7",
    "Alt. ma7",
    "dom7",
    "7(♭5)",
    "7(♯5)",
    "7sus",
    "mi7",
    "mi7(♭5)",
    "dim7",
    "ma6",
    "mi6",
    "Phrygian",
    "mi(♭13)",
    "mi(∆7)",
    "Mod. Triads"
  ]
  
  static var chordTypeSections: [ChordTypeSection] {
    var chordTypeSections: [ChordTypeSection] = []
    
    for (index, title) in sectionTitles.enumerated() {
      chordTypeSections.append(
        ChordTypeSection(
          id: index,
          title: title,
          tagName: sectionTagNames[index],
          chordTypes: allChordTypeArrays[index]
        )
      )
    }
    
    return chordTypeSections
  }
  
  
  static let sectionTitlesIndexed = sectionTitles.indexed()
  static let allChordTypeArraysIndexed = allChordTypeArrays.indexed()
  
  static let sectionsWithTitles = Array(zip(ChordType.sectionTitles, ChordType.allChordTypeArrays))
  
  static let allChordTypesMinusOmits: [[ChordType]] = allChordTypeArrays.map { $0.filterOmits() }
  
  static let allSimpleChordTypesMinusOmits: [[ChordType]] = allChordTypeArrays.map {
    $0.filterOmits().filterInSimple()
  }.filter { !$0.isEmpty }
  
  static let allChordTypesSorted: [ChordType] = allChordTypeArrays.flatMap { $0 }
  static let allChordTypesMinusOmitsSorted: [ChordType] = allChordTypesMinusOmits.flatMap { $0 }
}

struct ChordTypeSection {
  var id: Int
  var title: String
  var tagName: String
  var chordTypes: [ChordType]
}

extension ChordTypeSection: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(title)
    hasher.combine(tagName)
    hasher.combine(chordTypes)
  }
}
