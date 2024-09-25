//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, CaseIterable {
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
  case ma7_sh5                     // [0, 4, 8, 11]
  
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
  case mi_ma7 = "mi(∆7)"     // [0, 3, 7, 11]
  case mi_ma9 = "mi(∆9)"     // [0, 2, 3, 7, 11]
  
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
    case .mi11_omit9, .mi13_omit9, .mi13_omit11:
      return "mi11"
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
    case .ma7_sh5:
      return .ma7_sh5
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
    case .mi_ma7, .mi_ma9:
      return .mi_ma7
    }
  }
  
  // MARK: degrees
  var degrees: [Int] {
    switch self {
    case .ma:                              [0, 4, 7]
    case .mi:                              [0, 3, 7]
    case .aug:                             [0, 4, 8]
    case .dim:                             [0, 3, 6]
    case .sus4:                            [0, 5, 7]
    case .sus2:                            [0, 2, 7]
      
      // MARK: Modified Triads
    case .add4:                            [0, 4, 5, 7]
    case .mi_add4:                         [0, 3, 5, 7]
    case .add2:                            [0, 2, 4, 7]
    case .mi_add2:                         [0, 2, 3, 7]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:                             [0, 4, 7, 11]
    case .ma9:                             [0, 2, 4, 7, 11]
    case .ma13:                            [0, 2, 4, 7, 9, 11]
    case .ma13_omit9:                      [0, 4, 7, 9, 11]
    case .ma7_sh11:                        [0, 4, 6, 7, 11]
    case .ma9_sh11:                        [0, 2, 4, 6, 7, 11]
    case .ma13_sh11:                       [0, 2, 4, 6, 7, 9, 11]
    case .ma13_sh11_omit9:                 [0, 4, 6, 7, 9, 11]
      
      // MARK: Altered Major 7th Chords
    case .ma7_sh5:                         [0, 4, 8, 11]
      // TODO: add Dominant degrees
      // MARK: Dominant 7th Chords
      // unaltered
    case .dominant7:                       [0, 4, 7, 10]
    case .dominant9:                       [0, 2, 4, 7, 10]
    case .dominant13:                      [0, 2, 4, 7, 9, 10]
    case .dominant13_omit9:                [0, 4, 7, 9, 10]
      // ♭9
    case .dominant7_b9:                    [0, 1, 4, 7, 10]
    case .dominant7_b9_b5:                 [0, 1, 4, 6, 10]
    case .dominant7_b9_sh5:                [0, 1, 4, 8, 10]
    case .dominant7_b9_sh9:                [0, 1, 3, 4, 7, 10]
    case .dominant7_b9_sh11:               [0, 1, 4, 6, 7, 10]
    case .dominant7_alt_b9_sh9_sh11:       [0, 1, 3, 4, 6, 7, 10]
    case .dominant7_alt_b9_sh9_b5:         [0, 1, 3, 4, 6, 10]
      // ♯9
    case .dominant7_sh9:                   [0, 3, 4, 7, 10]
    case .dominant7_sh9_b5:                [0, 3, 4, 6, 10]
    case .dominant7_sh9_sh5:               [0, 3, 4, 8, 10]
    case .dominant7_sh9_sh11:              [0, 3, 4, 6, 7, 10]
      // ♯11
    case .dominant7_sh11:                  [0, 4, 6, 7, 10]
    case .dominant9_sh11:                  [0, 2, 4, 6, 7, 10]
    case .dominant13_sh11:                 [0, 2, 4, 6, 7, 9, 10]
    case .dominant13_sh11_omit9:           [0, 4, 6, 7, 9, 10]
      // ♭5
    case .dominant7_b5:                    [0, 4, 6, 10]
    case .dominant9_b5:                    [0, 2, 4, 6, 10]
    case .dominant13_b5:                   [0, 2, 4, 6, 9, 10]
    case .dominant13_b5_omit9:             [0, 4, 6, 9, 10]
    case .dominant9_sh5:                   [0, 2, 4, 8, 10]
    case .dominant7_b5_sh5:                [0, 4, 6, 8, 10]
      // ♯5
    case .dominant7_sh5:                   [0, 4, 8, 10]
      // TODO: add more dominant chords
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:                             [0, 3, 7, 10]
    case .mi9:                             [0, 2, 3, 7, 10]
    case .mi11:                            [0, 2, 3, 5, 7, 10]
    case .mi11_omit9:                      [0, 3, 5, 7, 10]
    case .mi13:                            [0, 2, 3, 5, 7, 9, 10]
    case .mi13_omit9:                      [0, 3, 5, 7, 9, 10]
    case .mi13_omit11:                     [0, 2, 3, 7, 9, 10]
    case .mi7_add13:                       [0, 3, 7, 9, 10]
      
      // MARK: Phrygian
    case .mi7_b9:                          [0, 1, 3, 7, 10]
    case .mi7_b9b13:                       [0, 1, 3, 7, 8, 10]
    case .mi11_b9:                         [0, 1, 3, 5, 7, 10]
    case .mi11_b9b13:                      [0, 1, 3, 5, 7, 8, 10]
    case .mi13_b9:                         [0, 1, 3, 5, 7, 9, 10]
      
      // MARK: Min(♭13)
    case .mi_b6:                           [0, 3, 7, 8]
    case .mi7_b13:                         [0, 3, 7, 8, 10]
    case .mi9_b13:                         [0, 2, 3, 7, 8, 10]
    case .mi11_b13:                        [0, 2, 3, 5, 7, 8, 10]
    case .mi11_b13_omit9:                  [0, 3, 5, 7, 8, 10]
      
      // MARK: mi7(♭5)
    case .mi7_b5:                          [0, 3, 6, 10]
    case .mi9_b5:                          [0, 2, 3, 6, 10]
    case .mi7_b5add11:                     [0, 3, 5, 6, 10]
    case .mi11_b5:                         [0, 2, 3, 5, 6, 10]
    case .mi11_b5b13:                      [0, 2, 3, 5, 6, 8, 10]
    case .mi7_b5b9:                        [0, 1, 3, 6, 10]
    case .mi11_b5b9:                       [0, 1, 3, 5, 6, 10]
    case .mi7_b5b13:                       [0, 3, 6, 8, 10]
    case .locrian:                         [0, 1, 3, 5, 6, 8, 10]
    case .mi13_b5:                         [0, 2, 3, 5, 6, 9, 10]
    case .mi13_b5_omit9:                   [0, 3, 5, 6, 9, 10]
    case .mi13_b5_omit11:                  [0, 2, 3, 6, 9, 10]
    case .mi7_b5add13:                     [0, 3, 6, 9, 10]
      
      // MARK: diminished
    case .dim7:                            [0, 3, 6, 9]
    case .dim7_b13:                        [0, 3, 6, 8, 9]
    case .dim7_add_ma7:                    [0, 3, 6, 9, 11]
    case .dim7_b13_add_ma7:                [0, 3, 6, 8, 9, 11]
    case .dim9:                            [0, 2, 3, 6, 9]
    case .dim9_add_ma7:                    [0, 2, 3, 6, 9, 11]
    case .dim9_b13:                        [0, 2, 3, 6, 8, 9]
    case .dim9_b13_add_ma7:                [0, 2, 3, 6, 8, 9, 11]
    case .dim11:                           [0, 2, 3, 5, 6, 9]
    case .dim7_add11:                      [0, 3, 5, 6, 9]
    case .dim11_b13:                       [0, 2, 3, 5, 6, 8, 9]
    case .dim11_b13_omit9:                 [0, 3, 5, 6, 8, 9]
    case .dim11_add_ma7:                   [0, 2, 3, 5, 6, 9, 11]
    case .dim11_add_ma7_omit9:             [0, 3, 5, 6, 9, 11]
    case .dim11_b13_add_ma7:               [0, 2, 3, 5, 6, 8, 9, 11]
    case .dim11_b13_add_ma7_omit9:         [0, 3, 5, 6, 8, 9, 11]
      
      // MARK: Major 6
    case .ma6:                             [0, 4, 7, 9]
    case .ma6_9:                           [0, 2, 4, 7, 9]
    case .ma6_9sh11:                       [0, 2, 4, 6, 7, 9]
    case .ma6_b9:                          [0, 1, 4, 7, 9]
    case .ma6_b9sh11:                      [0, 1, 4, 6, 7, 9]
    case .ma6_sh9:                         [0, 3, 4, 7, 9]
    case .ma6_sh9_sh11:                    [0, 3, 4, 6, 7, 9]
    case .ma6_sh11:                        [0, 4, 6, 7, 9]
      
      // MARK: minor 6
    case .mi6:                             [0, 3, 7, 9]
    case .mi6_9:                           [0, 3, 4, 7, 9]
    case .mi6_9_11:                        [0, 3, 4, 5, 7, 9]
      
      // MARK: mi(∆7)
    case .mi_ma7:                          [0, 3, 7, 11]
    case .mi_ma9:                          [0, 2, 3, 7, 11]
    }
  }

  // MARK: static func getChordTypeByDegrees
  static func getChordTypeByDegrees(degrees: [Int]) -> ChordType? {
    // MARK: Triads
    switch degrees {
    case [0, 4, 7]:
      return .ma
    case [0, 3, 7]:
      return .mi
    case [0, 4, 8]:
      return .aug
    case [0, 3, 6]:
      return .dim
    case [0, 5, 7]:
      return .sus4
    case [0, 2, 7]:
      return .sus2
      
      // MARK: Modified Triads
    case [0, 4, 5, 7]:
      return .add4
    case [0, 3, 5, 7]:
      return .mi_add4
    case [0, 2, 4, 7]:
      return .add2
    case [0, 2, 3, 7]:
      return .mi_add2

      // MARK: Major Lydian 7th Chords
    case [0, 4, 7, 11]:
      return .ma7
    case [0, 2, 4, 7, 11]:
      return .ma9
    case [0, 2, 4, 7, 9, 11]:
      return .ma13
    case [0, 4, 7, 9, 11]:
      return .ma13_omit9
    case [0, 4, 6, 7, 11]:
      return .ma7_sh11
    case [0, 2, 4, 6, 7, 11]:
      return .ma9_sh11
    case [0, 2, 4, 6, 7, 9, 11]:
      return .ma13_sh11
    case [0, 4, 6, 7, 9, 11]:
      return .ma13_sh11_omit9
      
      // MARK: Dominant 7th Chords
      // unaltered
    case [0, 4, 7, 10]:
      return .dominant7
    case [0, 2, 4, 7, 10]:
      return .dominant9
    case [0, 2, 4, 7, 9, 10]:
      return .dominant13
    case [0, 4, 7, 9, 10]:
      return .dominant13_omit9
      // ♭9
    case [0, 1, 4, 7, 10]:
      return .dominant7_b9
    case [0, 1, 4, 6, 10]:
      return .dominant7_b9_b5
    case [0, 1, 4, 8, 10]:
      return .dominant7_b9_sh5
    case [0, 1, 3, 4, 7, 10]:
      return .dominant7_b9_sh9
    case [0, 1, 4, 6, 7, 10]:
      return .dominant7_b9_sh11
    case [0, 1, 3, 4, 6, 7, 10]:
      return .dominant7_alt_b9_sh9_sh11
    case [0, 1, 3, 4, 6, 10]:
      return .dominant7_alt_b9_sh9_b5
      // ♯9
    case [0, 3, 4, 7, 10]:
      return .dominant7_sh9
    case [0, 3, 4, 6, 10]:
      return .dominant7_sh9_b5
    case [0, 3, 4, 6, 7, 10]:
      return .dominant7_sh9_sh11
      // ♯11
    case [0, 4, 6, 7, 10]:
      return .dominant7_sh11
    case [0, 2, 4, 6, 7, 10]:
      return .dominant9_sh11
    case [0, 2, 4, 6, 7, 9, 10]:
      return .dominant13_sh11
    case [0, 4, 6, 7, 9, 10]:
      return .dominant13_sh11_omit9
      // ♭5
    case [0, 4, 6, 10]:
      return .dominant7_b5
    case [0, 2, 4, 6, 10]:
      return .dominant9_b5
    case [0, 2, 4, 6, 9, 10]:
      return .dominant13_b5
    case [0, 4, 6, 8, 10]:
      return .dominant7_b5_sh5
      // ♯5
    case [0, 4, 8, 10]:
      return .dominant7_sh5
    case [0, 2, 4, 8, 10]:
      return .dominant9_sh5
      // TODO: add more dominant chords
      
      // MARK: Minor Dorian 7th Chords
    case [0, 3, 7, 10]:
      return .mi7
    case [0, 2, 3, 7, 10]:
      return .mi9
    case [0, 2, 3, 5, 7, 10]:
      return .mi11
    case [0, 3, 5, 7, 10]:
      return .mi11_omit9
    case [0, 2, 3, 5, 7, 9, 10]:
      return .mi13
    case [0, 3, 5, 7, 9, 10]:
      return .mi13_omit9
    case [0, 2, 3, 7, 9, 10]:
      return .mi13_omit11
    case [0, 3, 7, 9, 10]:
      return .mi7_add13
      
      // MARK: Phrygian
    case [0, 1, 3, 7, 10]:
      return .mi7_b9
    case [0, 1, 3, 7, 8, 10]:
      return .mi7_b9b13
    case [0, 1, 3, 5, 7, 10]:
      return .mi11_b9
    case [0, 1, 3, 5, 7, 8, 10]:
      return .mi11_b9b13
    case [0, 1, 3, 5, 7, 9, 10]:
      return .mi13_b9
      
      // MARK: Min(♭13)
    case [0, 3, 7, 8]:
      return .mi_b6
    case [0, 3, 7, 8, 10]:
      return .mi7_b13
    case [0, 2, 3, 7, 8, 10]:
      return .mi9_b13
    case [0, 2, 3, 5, 7, 8, 10]:
      return .mi11_b13
    case [0, 1, 3, 5, 7, 9, 10]:
      return .mi13_b9
    case [0, 1, 3, 5, 7, 9, 10]:
      return .mi13_b9
      
      // MARK: mi7(♭5)
    case [0, 3, 6, 10]:
      return .mi7_b5
    case [0, 2, 3, 6, 10]:
      return .mi9_b5
    case [0, 3, 5, 6, 10]:
      return .mi7_b5add11
    case [0, 2, 3, 5, 6, 10]:
      return .mi11_b5
    case [0, 2, 3, 5, 6, 8, 10]:
      return .mi11_b5b13
    case [0, 1, 3, 6, 10]:
      return .mi7_b5b9
    case [0, 1, 3, 5, 6, 10]:
      return .mi11_b5b9
    case [0, 3, 6, 8, 10]:
      return .mi7_b5b13
    case [0, 1, 3, 5, 6, 8, 10]:
      return .locrian
    case [0, 2, 3, 5, 6, 9, 10]:
      return .mi13_b5
    case [0, 3, 5, 6, 9, 10]:
      return .mi13_b5_omit9
    case [0, 2, 3, 6, 9, 10]:
      return .mi13_b5_omit11
    case [0, 3, 6, 9, 10]:
      return .mi7_b5add13
      
      // MARK: diminished
    case [0, 3, 6, 9]:
      return .dim7
    case [0, 3, 6, 8, 9]:
      return .dim7_b13
    case [0, 3, 6, 9, 11]:
      return .dim7_add_ma7
    case [0, 3, 6, 8, 9, 11]:
      return .dim7_b13_add_ma7
    case [0, 2, 3, 6, 9]:
      return .dim9
    case [0, 2, 3, 6, 9, 11]:
      return .dim9_add_ma7
    case [0, 2, 3, 6, 8, 9]:
      return .dim9_b13
    case [0, 2, 3, 6, 8, 9, 11]:
      return .dim9_b13_add_ma7
    case [0, 2, 3, 5, 6, 9]:
      return .dim11
    case [0, 3, 5, 6, 9]:
      return .dim7_add11
    case [0, 2, 3, 5, 6, 8, 9]:
      return .dim11_b13
    case [0, 3, 5, 6, 8, 9]:
      return .dim11_b13_omit9
    case [0, 2, 3, 5, 6, 9, 11]:
      return .dim11_add_ma7
    case [0, 3, 5, 6, 9, 11]:
      return .dim11_add_ma7_omit9
    case [0, 2, 3, 5, 6, 8, 9, 11]:
      return .dim11_b13_add_ma7
    case [0, 3, 5, 6, 8, 9, 11]:
      return .dim11_b13_add_ma7_omit9
      
      // MARK: Major 6
    case [0, 4, 7, 9]:
      return .ma6
    case [0, 3, 4, 7, 9]:
      return .ma6_sh9
    case [0, 1, 4, 7, 9]:
      return .ma6_b9
    case [0, 3, 4, 6, 7, 9]:
      return .ma6_sh9_sh11
    case [0, 1, 4, 6, 7, 9]:
      return .ma6_b9sh11
    case [0, 4, 6, 7, 9]:
      return .ma6_sh11
    case [0, 2, 4, 7, 9]:
      return .ma6_9
    case [0, 2, 4, 6, 7, 9]:
      return .ma6_9sh11
      
      // MARK: minor 6
    case [0, 3, 7, 9]:
      return .mi6
    case [0, 3, 4, 7, 9]:
      return .mi6_9
    case [0, 3, 4, 5, 7, 9]:
      return .mi6_9_11
      
      // MARK: mi(∆7)
    case [0, 3, 7, 11]:
      return .mi_ma7
    default:
  //      print("Couldn't find a match for degrees: \(degrees)")
      return nil
    }
  }
  
  // MARK: hasDegreeTags
  
  // TODO: add dominant degree tags
  
  // MARK: hasRoot
  var hasRoot: Degree? {
    return .root
  }
  
  // MARK: hasMajor2nd
  var hasMajor2nd: Degree? {
    switch self {
    case let type where type.rawValue.contains(/sus2|add2/):
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
    case .ma, .aug, .ma7, .dominant7, .dominant7_b5, .dominant7_sh5, .ma6, .add4, .add2, .ma7_sh5:
      return .major3rd
    default:
      return nil
    }
  }
  
  // MARK: hasPerfect4th
  var hasPerfect4th: Degree? {
    switch self {
      // sus4 & add4
      case let type where type.rawValue.contains(/sus4|add4/):
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
    case .dim, .mi7_b5, .dim7, .dominant7_b5:
      return .diminished5th
    case .dominant7, .ma7:
      switch self {
        // 7(♭5)
      case let type where type.rawValue.contains(/♭5/):
        return .diminished5th
      default:
        return nil
      }
    default:
      return nil
    }
  }
  
  // MARK: hasPerfect5th
  var hasPerfect5th: Degree? {
    switch self {
      // has ♭5 or ♯5
    case let type where type.hasDim5th != nil, let type where type.hasSharp5th != nil:
      return nil
    default:
      return .perfect5th
    }
  }
  
  // MARK: hasSharp5th
  var hasSharp5th: Degree? {
    switch self {
      // aug triad, ma7(♯5), 7(♯5)
    case let type where type == .aug || type.rawValue.contains(/♯5/):
      return .sharp5th
    default:
      return nil
    }
  }
  
  // MARK: hasMinor6th
  var hasMinor6th: Degree? {
    switch self {
      // Min(♭6)
    case let type where type.rawValue.contains(/♭6/):
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
    case .dominant7, .dominant7_b5, .dominant7_sh5, .mi7, .mi7_b5:
      return .minor7th
    default:
      return nil
    }
  }
  
  // MARK: hasMajor7th
  var hasMajor7th: Degree? {
    switch baseChordType {
    case let type where type.hasMinor7th != nil || type == .ma6:
      return nil
    case .ma7, .mi_ma7, .ma7_sh5:
      return .major7th
    case .dim7:
      switch self {
      case let type where type.rawValue.contains(/add∆7/):
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
    case let type where type.rawValue.contains(/♭9|locrian/):
      return .minor9th
    default:
      return nil
    }
  }
  
  // MARK: hasMajor9th
  var hasMajor9th: Degree? {
    switch self {
      // has ♭9 or ♯9
    case let type where type.hasMinor9th != nil, let type where type.hasSharp9th != nil:
      return nil
      // ma7
    case let type where !type.rawValue.contains(/omit 9|add .*11|add .*13/) && type.rawValue.contains(/9|11|13|⁶\/₉/):
      return .major9th
    default:
      return nil
    }
  }
  
  // MARK: hasSharp9th
  var hasSharp9th: Degree? {
    switch self {
    case let type where type.rawValue.contains(/♯9/):
      return .sharp9th
    default:
      return nil
    }
  }
  
  // MARK: hasPerfect11th
  var hasPerfect11th: Degree? {
    switch self {
    case let type where !type.rawValue.contains(/omit11|♯11/) && type.rawValue.contains(/11|mi13|locrian/):
      return .perfect11th
    default:
      return nil
    }
  }
  
  // MARK: hasSharp11th
  var hasSharp11th: Degree? {
    switch self {
    case let type where type.rawValue.contains(/♯11/):
      return .sharp11th
    default:
      return nil
    }
  }
  
  // MARK: hasMinor13th
  var hasFlat13th: Degree? {
    switch self {
      // Min(♭13)
    case let type where type.rawValue.contains(/♭13/):
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
      case let type where type.hasMinor6th != nil || type.hasFlat13th != nil:
        return nil
        // Extended Major 7th chords
      case let type where type.rawValue.contains(/13/):
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
                              hasMajor13th
    ]
    
    return optionalDegreeTags.compactMap { $0 }
  }
}

extension ChordType: Identifiable, Comparable {
  var id: Self {
    return self
  }
  
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

// MARK: static properties
extension ChordType {
  static var allChordDegrees: [[Int]] {
    ChordType.allCases.map { $0.degrees }
  }
  
  static let triadTypes: [ChordType] = [.ma, .mi, .aug, .dim, .sus4, .sus2]
  static let primary7thChords: [ChordType] = [.ma7, .dominant7, .mi7, .mi7_b5, .dim7]
  static let extendedMajor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .ma7 && $0 != .ma7 }
  static let extendedDominantChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7 && $0 != .dominant7 }
  static let extendedDominant7_b5_Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7_b5 }
  static let extendedDominant7_sh5_Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dominant7_sh5 }
  static let extendedMinor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi7 && $0 != .mi7 && !minorFlat13Chords.contains($0) && !phrygianChords.contains($0) }
  static let extendedMinor7th_b5Chords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi7_b5 && $0 != .mi7_b5 }
  static let extendedDiminishedChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .dim7 && $0 != .dim7 }
  static let extendedMajor6thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .ma6 }
  static let extendedMinor6thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi6 }
  static let extendedMinorMajor7thChords: [ChordType] = ChordType.allCases.filter { $0.baseChordType == .mi_ma7 }
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
    extendedDominantChords,
    extendedDominant7_b5_Chords,
    extendedDominant7_sh5_Chords,
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
  
  static let allChordTypesMinusOmits: [[ChordType]] = allChordTypeArrays.map { $0.filterOmits() }
  
  static let allChordTypesSorted: [ChordType] = allChordTypeArrays.flatMap { $0 }
  static let allChordTypesMinusOmitsSorted: [ChordType] = allChordTypesMinusOmits.flatMap { $0 }
}
