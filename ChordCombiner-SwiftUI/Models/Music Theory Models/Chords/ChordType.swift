//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, CaseIterable, Identifiable, Comparable {
  var id: Self {
    return self
  }
  
  // MARK: Triads
  case ma           // [0, 4, 7]
  case mi           // [0, 3, 7]
  case aug          // [0, 4, 8]
  case dim = "˚"    // [0, 3, 6]
  case sus4         // [0, 5, 7]
  case sus2         // [0, 2, 7]
  
  // MARK: Major Lydian 7th Chords
  case ma7                                   // [0, 4, 7, 11]
  case ma9                                   // [0, 2, 4, 7, 11]
  case ma13                                  // [0, 2, 4, 7, 9, 11]
  case ma13_omit9 = "ma13(omit9)"            // [0, 4, 7, 9, 11]
  case ma7_sh11 = "ma7(♯11)"                 // [0, 4, 6, 7, 11]
  case ma9_sh11 = "ma9(♯11)"                 // [0, 2, 4, 6, 7, 11]
  case ma13_sh11 = "ma13(♯11)"               // [0, 2, 4, 6, 7, 9, 11]
  case ma13_sh11_omit9 = "ma13(♯11 omit9)"   // [0, 4, 6, 7, 9, 11]
  
  // MARK: Dominant 7th Chords
  case dominant7 = "7"                                   // [0, 4, 7, 10]
  case dominant7_sh11 = "7(♯11)"                         // [0, 4, 6, 7, 10]
  case dominant9 = "9"                                   // [0, 2, 4, 7, 10]
  case dominant9_sh11 = "9(♯11)"                         // [0, 2, 4, 6, 7, 10]
  case dominant13 = "13"                                 // [0, 2, 4, 7, 9, 10]
  case dominant13_sh11 = "13(♯11)"                       // [0, 2, 4, 6, 7, 9, 10]
  case dominant13_sh11_omit9 = "13(♯11 omit9)"           // [0, 4, 6, 7, 9, 10]
  // TODO: add more dominant chords
  
  // MARK: Major 6
  case ma6 = "6"                           // [0, 4, 7, 9]
  case ma6_sh9 = "6(♯9)"                   // [0, 3, 4, 7, 9]
  case ma6_b9 = "6(♭9)"                    // [0, 1, 4, 7, 9]
  case ma6_sh9sh11 = "6(♯9♯11)"            // [0, 3, 4, 6, 7, 9]
  case ma6_b9sh11 = "6(♭9♯11)"             // [0, 1, 4, 6, 7, 9]
  case ma6_sh11 = "6(♯11)"                 // [0, 4, 6, 7, 9]
  case ma6_9 = "⁶/₉"                       // [0, 2, 4, 7, 9]
  case ma6_9sh11 = "⁶/₉(♯11)"              // [0, 2, 4, 6, 7, 9]
  
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
  // TODO: add mi11_b13(omit9)             // [0, 3, 5, 7, 8, 10]
  
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
  
  var degrees: [Int] {
    switch self {
    case .ma:                              [0, 4, 7]
    case .mi:                              [0, 3, 7]
    case .aug:                             [0, 4, 8]
    case .dim:                             [0, 3, 6]
    case .sus4:                            [0, 5, 7]
    case .sus2:                            [0, 2, 7]
    
    // MARK: Major Lydian 7th Chords
    case .ma7:                             [0, 4, 7, 11]
    case .ma9:                             [0, 2, 4, 7, 11]
    case .ma13:                            [0, 2, 4, 7, 9, 11]
    case .ma13_omit9:                      [0, 4, 7, 9, 11]
    case .ma7_sh11:                        [0, 4, 6, 7, 11]
    case .ma9_sh11:                        [0, 2, 4, 6, 7, 11]
    case .ma13_sh11:                       [0, 2, 4, 6, 7, 9, 11]
    case .ma13_sh11_omit9:                 [0, 4, 6, 7, 9, 11]
    
    // MARK: Dominant 7th Chords
    case .dominant7:                       [0, 4, 7, 10]
    case .dominant7_sh11:                  [0, 4, 6, 7, 10]
    case .dominant9:                       [0, 2, 4, 7, 10]
    case .dominant9_sh11:                  [0, 2, 4, 6, 7, 10]
    case .dominant13:                      [0, 2, 4, 7, 9, 10]
    case .dominant13_sh11:                 [0, 2, 4, 6, 7, 9, 10]
    case .dominant13_sh11_omit9:           [0, 4, 6, 7, 9, 10]
    // TODO: add more dominant chords
    
    // MARK: Major 6
    case .ma6:                             [0, 4, 7, 9]
    case .ma6_sh9:                         [0, 3, 4, 7, 9]
    case .ma6_b9:                          [0, 1, 4, 7, 9]
    case .ma6_sh9sh11:                     [0, 3, 4, 6, 7, 9]
    case .ma6_b9sh11:                      [0, 1, 4, 6, 7, 9]
    case .ma6_sh11:                        [0, 4, 6, 7, 9]
    case .ma6_9:                           [0, 2, 4, 7, 9]
    case .ma6_9sh11:                       [0, 2, 4, 6, 7, 9]
    
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
    // TODO: add mi11_b13(omit9         // [0, 3, 5, 7, 8, 10]
    
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
    }
  }
  
  init(degrees: [Int]) {
    switch degrees {
    case [0, 4, 7]:
     self = .ma
    case [0, 3, 7]:
     self = .mi
    case [0, 4, 8]:
     self = .aug
    case [0, 3, 6]:
     self = .dim
    case [0, 5, 7]:
     self = .sus4
    case [0, 2, 7]:
     self = .sus2
    
    // MARK: Major Lydian 7th Chords
    case [0, 4, 7, 11]:
     self = .ma7
    case [0, 2, 4, 7, 11]:
     self = .ma9
    case [0, 2, 4, 7, 9, 11]:
     self = .ma13
    case [0, 4, 7, 9, 11]:
     self = .ma13_omit9
    case [0, 4, 6, 7, 11]:
     self = .ma7_sh11
    case [0, 2, 4, 6, 7, 11]:
     self = .ma9_sh11
    case [0, 2, 4, 6, 7, 9, 11]:
     self = .ma13_sh11
    case [0, 4, 6, 7, 9, 11]:
     self = .ma13_sh11_omit9
    
    // MARK: Dominant 7th Chords
    case [0, 4, 7, 10]:
     self = .dominant7
    case [0, 4, 6, 7, 10]:
     self = .dominant7_sh11
    case [0, 2, 4, 7, 10]:
     self = .dominant9
    case [0, 2, 4, 6, 7, 10]:
     self = .dominant9_sh11
    case [0, 2, 4, 7, 9, 10]:
     self = .dominant13
    case [0, 2, 4, 6, 7, 9, 10]:
     self = .dominant13_sh11
    case [0, 4, 6, 7, 9, 10]:
     self = .dominant13_sh11_omit9
    // TODO: add more dominant chords
    
    // MARK: Major 6
    case [0, 4, 7, 9]:
     self = .ma6
    case [0, 3, 4, 7, 9]:
     self = .ma6_sh9
    case [0, 1, 4, 7, 9]:
     self = .ma6_b9
    case [0, 3, 4, 6, 7, 9]:
     self = .ma6_sh9sh11
    case [0, 1, 4, 6, 7, 9]:
     self = .ma6_b9sh11
    case [0, 4, 6, 7, 9]:
     self = .ma6_sh11
    case [0, 2, 4, 7, 9]:
     self = .ma6_9
    case [0, 2, 4, 6, 7, 9]:
     self = .ma6_9sh11
    
    // MARK: Minor Dorian 7th Chords
    case [0, 3, 7, 10]:
     self = .mi7
    case [0, 2, 3, 7, 10]:
     self = .mi9
    case [0, 2, 3, 5, 7, 10]:
     self = .mi11
    case [0, 3, 5, 7, 10]:
     self = .mi11_omit9
    case [0, 2, 3, 5, 7, 9, 10]:
     self = .mi13
    case [0, 3, 5, 7, 9, 10]:
     self = .mi13_omit9
    case [0, 2, 3, 7, 9, 10]:
     self = .mi13_omit11
    case [0, 3, 7, 9, 10]:
     self = .mi7_add13
    
    // MARK: Phrygian
    case [0, 1, 3, 7, 10]:
     self = .mi7_b9
    case [0, 1, 3, 7, 8, 10]:
     self = .mi7_b9b13
    case [0, 1, 3, 5, 7, 10]:
     self = .mi11_b9
    case [0, 1, 3, 5, 7, 8, 10]:
     self = .mi11_b9b13
    case [0, 1, 3, 5, 7, 9, 10]:
     self = .mi13_b9
    
    // MARK: Min(♭13)
    case [0, 3, 7, 8]:
     self = .mi_b6
    case [0, 3, 7, 8, 10]:
     self = .mi7_b13
    case [0, 2, 3, 7, 8, 10]:
     self = .mi9_b13
    case [0, 2, 3, 5, 7, 8, 10]:
     self = .mi11_b13
    // TODO: add mi11_b13(omit9         // [0, 3, 5, 7, 8, 10]
    
    // MARK: mi7(♭5)
    case [0, 3, 6, 10]:
     self = .mi7_b5
    case [0, 2, 3, 6, 10]:
     self = .mi9_b5
    case [0, 3, 5, 6, 10]:
     self = .mi7_b5add11
    case [0, 2, 3, 5, 6, 10]:
     self = .mi11_b5
    case [0, 2, 3, 5, 6, 8, 10]:
     self = .mi11_b5b13
    case [0, 1, 3, 6, 10]:
     self = .mi7_b5b9
    case [0, 1, 3, 5, 6, 10]:
     self = .mi11_b5b9
    case [0, 3, 6, 8, 10]:
     self = .mi7_b5b13
    case [0, 1, 3, 5, 6, 8, 10]:
     self = .locrian
    case [0, 2, 3, 5, 6, 9, 10]:
     self = .mi13_b5
    case [0, 3, 5, 6, 9, 10]:
     self = .mi13_b5_omit9
    case [0, 2, 3, 6, 9, 10]:
     self = .mi13_b5_omit11
    case [0, 3, 6, 9, 10]:
     self = .mi7_b5add13
    
    // MARK: diminished
    case [0, 3, 6, 9]:
     self = .dim7
    case [0, 3, 6, 8, 9]:
     self = .dim7_b13
    case [0, 3, 6, 9, 11]:
     self = .dim7_add_ma7
    case [0, 3, 6, 8, 9, 11]:
     self = .dim7_b13_add_ma7
    case [0, 2, 3, 6, 9]:
     self = .dim9
    case [0, 2, 3, 6, 9, 11]:
     self = .dim9_add_ma7
    case [0, 2, 3, 6, 8, 9]:
     self = .dim9_b13
    case [0, 2, 3, 6, 8, 9, 11]:
     self = .dim9_b13_add_ma7
    case [0, 2, 3, 5, 6, 9]:
     self = .dim11
    case [0, 3, 5, 6, 9]:
     self = .dim7_add11
    case [0, 2, 3, 5, 6, 8, 9]:
     self = .dim11_b13
    case [0, 3, 5, 6, 8, 9]:
     self = .dim11_b13_omit9
    case [0, 2, 3, 5, 6, 9, 11]:
     self = .dim11_add_ma7
    case [0, 3, 5, 6, 9, 11]:
     self = .dim11_add_ma7_omit9
    case [0, 2, 3, 5, 6, 8, 9, 11]:
     self = .dim11_b13_add_ma7
    case [0, 3, 5, 6, 8, 9, 11]:
     self = .dim11_b13_add_ma7_omit9
    default:
      print("Couldn't find a match for degrees: \(degrees)")
      self = .ma
    }
  }
  
  var baseChordType: ChordType {
    switch self {
      // Triads and unextended + unaltered 7th and 6th chords
    case .ma, .mi, .aug, .dim, .sus4, .sus2, .ma7, .ma6, .mi7, .mi7_b5, .mi_b6, .dominant7:
      return self
      // Extended Major 7th chords
    case .ma9, .ma13, .ma13_omit9, .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9:
      return .ma7
      // Extended Dominant 7th Chords
      // TODO: add dominant baseChordTypes
    case .dominant9, .dominant13, .dominant7_sh11, .dominant9_sh11, .dominant13_sh11, .dominant13_sh11_omit9:
      return .dominant7
      // Extended Major 6th chords
    case .ma6_sh9, .ma6_b9, .ma6_sh9sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9, .ma6_9sh11:
      return .ma6
      // Extended Minor 7th chords
    case .mi9, .mi11, .mi11_omit9, .mi13, .mi13_omit9, .mi13_omit11, .mi7_add13, .mi7_b9, .mi7_b9b13, .mi11_b9, .mi11_b9b13, .mi13_b9, .mi7_b13, .mi9_b13, .mi11_b13:
      return .mi7
      // Extended Min7(♭5) chords
    case .mi9_b5, .mi7_b5add11, .mi11_b5, .mi11_b5b13, .mi7_b5b9, .mi11_b5b9, .mi7_b5b13, .locrian, .mi13_b5, .mi13_b5_omit9, .mi13_b5_omit11, .mi7_b5add13:
      return .mi7_b5
      // Diminished
    case .dim7, .dim7_b13, .dim7_add_ma7, .dim7_b13_add_ma7, .dim9, .dim9_add_ma7, .dim9_b13, .dim9_b13_add_ma7, .dim11, .dim11_b13, .dim11_add_ma7, .dim11_b13_add_ma7, .dim7_add11, .dim11_b13_omit9, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
      return .dim7
    }
  }
  
  // TODO: add dominant degree tags
  var hasRoot: Degree? {
    return .root
  }
  
  var hasMinor9th: Degree? {
    switch self {
    case .ma6_b9, .mi7_b9, .mi11_b9, .mi13_b9, .mi7_b9b13, .ma6_b9sh11, .mi11_b9b13, .mi7_b5b9, .mi11_b5b9, .locrian:
      return .minor9th
    default:
      return nil
    }
  }
  
  var hasMajor9th: Degree? {
    switch self {
      // has ♭9 or ♯9
    case let type where type.hasMinor9th != nil, let type where type.hasSharp9th != nil:
      return nil
      // triads
    case .ma, .mi, .aug, .dim, .sus4,
      // ma7
        .ma7, .ma7_sh11, .ma13_omit9, .ma13_sh11_omit9,
      // dom7
        .dominant7, .dominant7_sh11, .dominant13_sh11_omit9,
      // ma6
        .ma6, .ma6_sh11,
      // mi7
        .mi7, .mi11_omit9, .mi7_add13, .mi13_omit9,
      // mi(♭13)
        .mi_b6, .mi7_b13,
      // mi7(♭5)
        .mi7_b5, .mi7_b5add11, .mi7_b5b13, .locrian, .mi13_b5_omit9, .mi7_b5add13,
      // ˚7
        .dim7, .dim7_b13, .dim7_add_ma7, .dim7_b13_add_ma7, .dim7_add11, .dim11_b13_omit9, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
      return nil
    default:
      return .major9th
    }
  }
  
  var hasSharp9th: Degree? {
    switch self {
    case .ma6_sh9, .ma6_sh9sh11:
      return .sharp9th
    default:
      return nil
    }
  }
  
  var hasMinor3rd: Degree? {
    switch baseChordType {
    case .ma, .aug, .ma7, .dominant7, .ma6, .sus2, .sus4:
      return nil
    default:
      return .minor3rd
    }
  }
  
  var hasMajor3rd: Degree? {
    switch baseChordType {
    case .ma, .aug, .ma7, .dominant7, .ma6:
      return .major3rd
    default:
      return nil
    }
  }
  
  var hasPerfect4th: Degree? {
    switch self {
      // triads
    case .sus4,
      // dorian
        .mi11, .mi11_omit9, .mi13, .mi13_omit9,
      // phrygian
        .mi11_b9, .mi11_b9b13, .mi13_b9,
      // mi7(♭5)
        .mi7_b5add11, .mi11_b5, .mi11_b5b9, .mi11_b5b13, .locrian, .mi13_b5, .mi13_b5_omit9,
      // mi(♭13)
        .mi11_b13,
      // ˚7
        .dim11, .dim7_add11, .dim11_b13, .dim11_b13_omit9, .dim11_add_ma7, .dim11_add_ma7_omit9, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9:
      return .perfect4th
    default:
      return nil
    }
  }
  
  var hasSharp4th: Degree? {
    switch self {
      // ma7(♯11)
    case .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9,
      // dom7(♯11)
        .dominant7_sh11, .dominant9_sh11, .dominant13_sh11, .dominant13_sh11_omit9,
      // ma6(♯11)
        .ma6_sh9sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9sh11:
      return .sharp4th
    default:
      return nil
    }
  }
  
  var hasDim5th: Degree? {
    switch baseChordType {
    case .dim, .mi7_b5, .dim7:
      return .dim5th
    default:
      return nil
    }
  }
  
  var hasPerfect5th: Degree? {
    switch self {
      // has ♭5 or ♯5
    case let type where type.hasDim5th != nil, let type where type.hasSharp5th != nil:
      return nil
    default:
      return .perfect5th
    }
  }
  
  var hasSharp5th: Degree? {
    switch self {
    case .aug:
      return .sharp5th
    default:
      return nil
    }
  }
  
  var hasMinor6th: Degree? {
    switch self {
      // Min(♭13)
    case .mi_b6, .mi7_b13, .mi9_b13, .mi11_b13,
      // Phrygian
        .mi7_b9b13, .mi11_b9b13,
      // mi7(♭5)
        .mi11_b5b13, .mi7_b5b13, .locrian,
      // ˚7
        .dim7_b13, .dim9_b13, .dim11_b13, .dim11_b13_omit9, .dim7_b13_add_ma7, .dim9_b13_add_ma7, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9:
      return .minor6th
    default:
      return nil
    }
  }
  
  var hasMajor6th: Degree? {
    switch baseChordType {
      // ma6 chords
    case .ma6:
      return .major6th
      // any ˚7 chord
    case .dim7:
      return nil
    default:
      switch self {
        // has ♭6
      case let type where type.hasMinor6th != nil:
        return nil
        // Triads and unextended + unaltered 7th and 6th chords
      case .ma, .mi, .aug, .dim, .sus4, .sus2, .ma7, .mi7, .mi7_b5, .mi_b6,
        // dom7
          .dominant7, .dominant9, .dominant7_sh11, .dominant9_sh11,
        // Extended Major 7th chords
          .ma9, .ma7_sh11, .ma9_sh11,
        // Extended Minor 7th chords
          .mi9, .mi11, .mi11_omit9, .mi7_b9, .mi11_b9,
        // Extended Min7(♭5) chords
          .mi9_b5, .mi7_b5add11, .mi11_b5, .mi7_b5b9, .mi11_b5b9, .locrian:
        return nil
      default:
        return .major6th
      }
    }
  }
  
  var hasDim7th: Degree? {
    baseChordType == .dim7 ? .dim7th : nil
  }
  
  var hasMinor7th: Degree? {
    switch baseChordType {
    case .dominant7, .mi7, .mi7_b5:
      return .minor7th
    default:
      return nil
    }
  }
  
  var hasMajor7th: Degree? {
    switch baseChordType {
    case let type where type.hasMinor7th != nil || type == .ma6:
      return nil
    case .ma7:
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
  
  var degreeTags: [Degree] {
    let optionalDegreeTags = [hasRoot,
                              hasMinor9th,
                              hasMajor9th,
                              hasSharp9th,
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
                              hasMajor7th
    ]
    
    return optionalDegreeTags.compactMap { $0 }
  }
  
  func setNotesByDegree(root: Root, rootKey: RootGen) -> [NoteProtocol] { 
    var allNotes: [NoteProtocol] = []
    
    //    let timeMeasure = ContinuousClock().measure {
    
    for degreeTag in degreeTags {
      switch degreeTag {
      case .root:
        // allNotes.append(root)
        allNotes.append(Note(rootKey))
            case .minor9th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Min9(rootKey))
        allNotes.append(Note(.minor9th, of: rootKey))
      case .sharp9th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Sh_9(rootKey))
        allNotes.append(Note(.sharp9th, of: rootKey))
      case .major9th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Maj9(rootKey))
        allNotes.append(Note(.major9th, of: rootKey))
      case .minor3rd:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Min3(rootKey))
        allNotes.append(Note(.minor3rd, of: rootKey))
      case .major3rd:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Maj3(rootKey))
        allNotes.append(Note(.major3rd, of: rootKey))
      case .perfect4th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(P4(rootKey))
        allNotes.append(Note(.perfect4th, of: rootKey))
      case .sharp4th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Sh_4(rootKey))
        allNotes.append(Note(.sharp4th, of: rootKey))
      case .dim5th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Dim5(rootKey))
        allNotes.append(Note(.dim5th, of: rootKey))
      case .sharp5th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Sh_5(rootKey))
        allNotes.append(Note(.sharp5th, of: rootKey))
      case .perfect5th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(P5(rootKey))
        allNotes.append(Note(.perfect5th, of: rootKey))
      case .minor6th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Min6(rootKey))
        allNotes.append(Note(.minor6th, of: rootKey))
      case .major6th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Maj6(rootKey))
        allNotes.append(Note(.major6th, of: rootKey))
      case .dim7th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Dim7(rootKey))
        allNotes.append(Note(.dim7th, of: rootKey))
      case .minor7th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Min7(rootKey))
        allNotes.append(Note(.minor7th, of: rootKey))
      case .major7th:
        // print("degree is: \(degreeTag)")
        // allNotes.append(Maj7(rootKey))
        allNotes.append(Note(.major7th, of: rootKey))
      }
    }
    //    }
    
    //    print("\(timeMeasure) for setNotesByDegree")
    return allNotes
  }
  
  func setNotes(root: Root, rootKey: RootGen) -> [NoteProtocol] {
    var allNotes: [NoteProtocol] = [root]
    
    //    let timeMeasure = ContinuousClock().measure {
    
    switch self {
      // MARK: Triads
    case .ma:
      // [0, 4, 7]
      allNotes = [root, Maj3(rootKey), P5(rootKey)]
    case .mi:
      // [0, 3, 7]
      allNotes = [root, Min3(rootKey), P5(rootKey)]
    case .aug:
      // [0, 4, 8]
      allNotes = [root, Maj3(rootKey), Sh_5(rootKey)]
    case .dim:
      // [0, 3, 6]
      allNotes = [root, Min3(rootKey), Dim5(rootKey)]
    case .sus4:
      // [0, 5, 7]
      allNotes = [root, P4(rootKey), P5(rootKey)]
    case .sus2:
      // [0, 2, 7]
      allNotes = [root, Maj9(rootKey), P5(rootKey)]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:
      // [0, 4, 7, 11]
      allNotes = [root, Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9:
      // [0, 2, 4, 7, 11]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13:
      // [0, 2, 4, 7, 9, 11]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_omit9:
      // [0, 4, 7, 9, 11]
      allNotes = [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma7_sh11:
      // [0, 4, 6, 7, 11]
      allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9_sh11:
      // [0, 2, 4, 6, 7, 11]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13_sh11:
      // [0, 2, 4, 6, 7, 9, 11]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_sh11_omit9:
      // [0, 4, 6, 7, 9, 11]
      allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
      
      // MARK: Dominant 7th Chords
    case .dominant7:
      // [0, 4, 7, 10]
      allNotes = [root, Maj3(rootKey), P5(rootKey), Min7(rootKey)]
    case .dominant7_sh11:
      // [0, 4, 6, 7, 10]
      allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Min7(rootKey)]
    case .dominant9:
      // [0, 2, 4, 7, 10]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Min7(rootKey)]
    case .dominant9_sh11:
      // [0, 2, 4, 6, 7, 10]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Min7(rootKey)]
    case .dominant13:
      // [0, 2, 4, 7, 9, 10]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
      // TODO: add dominant allNotes
    case .dominant13_sh11:
      // [0, 2, 4, 6, 7, 9, 10]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .dominant13_sh11_omit9:
      // [0, 4, 6, 7, 9, 10]
      allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    
      // MARK: Major 6
    case .ma6:
      // [0, 4, 7, 9]
      allNotes = [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh9:
      // [0, 3, 4, 7, 9]
      allNotes = [root, Sh_9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_b9:
      // [0, 1, 4, 7, 9]
      allNotes = [root, Min9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh9sh11:
      // [0, 3, 4, 6, 7, 9]
      allNotes = [root, Sh_9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_b9sh11:
      // [0, 1, 4, 6, 7, 9]
      allNotes = [root, Min9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh11:
      // [0, 4, 6, 7, 9]
      allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_9:
      // [0, 2, 4, 7, 9]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_9sh11:
      // [0, 2, 4, 6, 7, 9]
      allNotes = [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      // [0, 3, 7, 10]
      allNotes = [root, Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi9:
      // [0, 2, 3, 7, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11:
      // [0, 2, 3, 5, 7, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_omit9:
      // [0, 3, 5, 7, 10]
      allNotes = [root, Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi13:
      // [0, 2, 3, 5, 7, 9, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit9:
      // [0, 3, 5, 7, 9, 10]
      allNotes = [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit11:
      // [0, 2, 3, 7, 9, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi7_add13:
      // [0, 3, 7, 9, 10]
      allNotes = [root, Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: Phrygian
    case .mi7_b9:
      // [0, 1, 3, 7, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi7_b9b13:
      // [0, 1, 3, 7, 8, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi11_b9:
      // [0, 1, 3, 5, 7, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_b9b13:
      // [0, 1, 3, 5, 7, 8, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi13_b9:
      // [0, 1, 3, 5, 7, 9, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: Min(♭13)
    case .mi_b6:
      // [0, 3, 7, 8]
      allNotes = [root, Min3(rootKey), P5(rootKey), Min6(rootKey)]
    case .mi7_b13:
      // [0, 3, 7, 8, 10]
      allNotes = [root, Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi9_b13:
      // [0, 2, 3, 7, 8, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi11_b13:
      // [0, 2, 3, 5, 7, 8, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
      
      // MARK: mi7(♭5)
    case .mi7_b5:
      // [0, 3, 6, 10]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi9_b5:
      // [0, 2, 3, 6, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi7_b5add11:
      // [0, 3, 5, 6, 10]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5:
      // [0, 2, 3, 5, 6, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5b13: // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi7_b5b9:
      // [0, 1, 3, 6, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5b9:
      // [0, 1, 3, 5, 6, 10]
      allNotes = [root, Min9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi7_b5b13:
      // [0, 3, 6, 8, 10]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .locrian: // [0, 1, 3, 5, 6, 8, 10] (mi11(♭5♭9♭13))
      allNotes = [root, Min9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi13_b5: // [0, 2, 3, 5, 6, 9, 10] (dorian ♭5 / 2nd
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_b5_omit9: // [0, 3, 5, 6, 9, 10]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_b5_omit11: // [0, 2, 3, 6, 9, 10]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi7_b5add13: // [0, 3, 6, 9, 10]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: diminished
    case .dim7: // [0, 3, 6, 9]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim7_b13: // [0, 3, 6, 8, 9]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim7_add_ma7: // [0, 3, 6, 9, 11]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim7_b13_add_ma7: // [0, 3, 6, 8, 9, 11]
      allNotes = [root, Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim9: // [0, 2, 3, 6, 9]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim9_add_ma7: // [0, 2, 3, 6, 9, 11]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim9_b13: // [0, 2, 3, 6, 8, 9]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim9_b13_add_ma7: // [0, 2, 3, 6, 8, 9, 11]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11: // [0, 2, 3, 5, 6, 9]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim7_add11: // [0, 3, 5, 6, 9]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim11_b13: // [0, 2, 3, 5, 6, 8, 9]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim11_b13_omit9: // [0, 3, 5, 6, 8, 9]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim11_add_ma7: // [0, 2, 3, 5, 6, 9, 11]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_add_ma7_omit9:  // [0, 3, 5, 6, 9, 11]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_b13_add_ma7: // [0, 2, 3, 5, 6, 8, 9, 11]
      allNotes = [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_b13_add_ma7_omit9: // [0, 3, 5, 6, 8, 9, 11]
      allNotes = [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    }
    //    }
    
    //    print("\(timeMeasure) for allNotes")
    return allNotes
  }
  
  var degreesInC: [Int] {
    let root = Root(.c)
    return setNotes(root: root, rootKey: root.rootKey).map { $0.basePitchNum }
//    return setNotesByDegree(root: root, rootKey: root.rootKey).map { $0.basePitchNum }
  }
  
  static var allChordDegrees: [[Int]] {
    ChordType.allCases.map { $0.degrees }
  }
  
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
  static func getChordTypeByDegrees(degrees: [Int]) -> ChordType? {
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
    case [0, 4, 7, 10]:
      return .dominant7
    case [0, 4, 6, 7, 10]:
      return .dominant7_sh11
    case [0, 2, 4, 7, 10]:
      return .dominant9
    case [0, 2, 4, 6, 7, 10]:
      return .dominant9_sh11
    case [0, 2, 4, 7, 9, 10]:
      return .dominant13
    case [0, 2, 4, 6, 7, 9, 10]:
      return .dominant13_sh11
    case [0, 4, 6, 7, 9, 10]:
      return .dominant13_sh11_omit9
    // TODO: add more dominant chords
    
    // MARK: Major 6
    case [0, 4, 7, 9]:
      return .ma6
    case [0, 3, 4, 7, 9]:
      return .ma6_sh9
    case [0, 1, 4, 7, 9]:
      return .ma6_b9
    case [0, 3, 4, 6, 7, 9]:
      return .ma6_sh9sh11
    case [0, 1, 4, 6, 7, 9]:
      return .ma6_b9sh11
    case [0, 4, 6, 7, 9]:
      return .ma6_sh11
    case [0, 2, 4, 7, 9]:
      return .ma6_9
    case [0, 2, 4, 6, 7, 9]:
      return .ma6_9sh11
    
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
    // TODO: add mi11_b13(omit9         // [0, 3, 5, 7, 8, 10]
    
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
    default:
      print("Couldn't find a match for degrees: \(degrees)")
       return nil
    }

  }
  
  //  func getBaseChord(root: Root) -> Chord {
  //    switch self {
  //      // Triads and unextended + unaltered 7th and 6th chords
  //    case .ma, .mi, .aug, .dim, .sus4, .sus2, .ma7, .ma6, .mi7, .mi7_b5, .mi_b6:
  //      return Chord(RootGen(root.key), self.baseChord)
  //      // Extended Major 7th chords
  //    case .ma9, .ma13, .ma13_omit9, .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9:
  //      return Chord(RootGen(root.key), .ma7)
  //      // Extended Major 6th chords
  //    case .ma6_sh9, .ma6_b9, .ma6_sh9sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9, .ma6_9sh11:
  //      return Chord(RootGen(root.key), .ma6)
  //      // Extended Minor 7th chords
  //    case .mi9, .mi11, .mi11_omit9, .mi13, .mi13_omit9, .mi13_omit11, .mi7_add13, .mi7_b9, .mi7_b9b13, .mi11_b9, .mi11_b9b13, .mi13_b9, .mi7_b13, .mi9_b13, .mi11_b13:
  //      return Chord(RootGen(root.key), .mi7)
  //      // Extended Min7(♭5) chords
  //    case .mi9_b5, .mi7_b5add11, .mi11_b5, .mi11_b5b13, .mi7_b5b9, .mi11_b5b9, .mi7_b5b13, .locrian:
  //      return Chord(RootGen(root.key), .mi7_b5)
  //    case .dim7, .dim7_b13, .dim7_add_ma7, .dim7_b13_add_ma7, .dim9, .dim9_add_ma7, .dim9_b13_add_ma7, .dim11, .dim11_b13, .dim11_add_ma7, .dim11_b13_add_ma7:
  //      return Chord(RootGen(root.key), .dim7)
  //    }
  //  }
  
}

