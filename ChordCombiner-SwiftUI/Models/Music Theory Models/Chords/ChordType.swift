//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, CaseIterable, Identifiable, Comparable {
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
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
  
  // MARK: Min♭13)
  case mi_b6 = "mi(♭6)"                    // [0, 3, 7, 8]
  case mi7_b13 = "mi7(♭13)"                // [0, 3, 7, 8, 10]
  case mi9_b13 = "mi9(♭13)"                // [0, 2, 3, 7, 8, 10]
  case mi11_b13 = "mi11(♭13)"              // [0, 2, 3, 5, 7, 8, 10]
  
  // MARK: mi7(♭5)
  case mi7_b5 = "mi7(♭5)"                  // [0, 3, 6, 10]
  case mi9_b5 = "mi9(♭5)"                  // [0, 2, 3, 6, 10]
  case mi7_b5add11 = "mi7(♭5add11)"        // [0, 3, 5, 6, 10]
  case mi11_b5 = "mi11(♭5)"                // [0, 2, 3, 5, 6, 10]
  case mi11_b5b13 = "mi11(♭5♭13)"          // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
  case mi7_b5b9 = "mi7(♭5♭9)"              // [0, 1, 3, 6, 10]
  case mi11_b5b9 = "mi11(♭5♭9)"            // [0, 1, 3, 5, 6, 10]
  case mi7_b5b13 = "mi7(♭5♭13)"            // [0, 1, 3, 6, 8, 10]
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
  case dim11_b13_omit9 = "˚11(♭13 omit9)"               // [0, 2, 3, 5, 6, 8, 9]
  case dim11_add_ma7 = "˚11(add∆7)"                     // [0, 2, 3, 5, 6, 9, 11]
  case dim11_add_ma7_omit9 = "˚11(add∆7 omit9)"         // [0, 3, 5, 6, 9, 11]
  case dim11_b13_add_ma7 = "˚11(♭13add∆7)"              // [0, 2, 3, 5, 6, 8, 9, 11]
  case dim11_b13_add_ma7_omit9 = "˚11(♭13add∆7 omit9)"  // [0, 3, 5, 6, 8, 9, 11]
  
  var baseChordType: ChordType {
    switch self {
      // Triads and unextended + unaltered 7th and 6th chords
    case .ma, .mi, .aug, .dim, .sus4, .sus2, .ma7, .ma6, .mi7, .mi7_b5, .mi_b6:
      return self
      // Extended Major 7th chords
    case .ma9, .ma13, .ma13_omit9, .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9:
      return .ma7
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
      
  var hasMinor9th: Bool {
    switch self {
    case .ma6_b9, .mi7_b9, .mi11_b9, .mi13_b9, .mi7_b9b13, .ma6_b9sh11, .mi11_b9b13:
      return true
    default:
      return false
    }
  }
  
  var hasMajor9th: Bool {
    switch self {
      // has ♭9 or ♯9
    case let type where type.hasMinor9th, let type where type.hasSharp9th:
      return false
      // triads
    case .ma, .mi, .aug, .dim, .sus4,
      // ma7
        .ma7, .ma13_omit9, .ma13_sh11_omit9,
      // ma6
        .ma6, .ma6_sh11,
      // mi7
        .mi7, .mi11_omit9, .mi7_add13, .mi13_omit9,
      // mi(♭13)
        .mi_b6, .mi7_b13,
      // mi7(♭5)
        .mi7_b5, .mi7_b5add11, .mi7_b5b13, .locrian,
      // ˚7
        .dim7, .dim7_b13, .dim7_add_ma7, .dim7_b13_add_ma7, .dim7_add11, .dim11_b13_omit9, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
      return false
    default:
      return true
    }
  }

  var hasSharp9th: Bool {
    switch self {
    case .ma6_sh9, .ma6_sh9sh11:
      return true
    default:
      return false
    }
  }

  var hasMinor3rd: Bool {
    switch baseChordType {
    case .ma, .aug, .ma7, .ma6, .sus2, .sus4:
      return false
    default:
      return true
    }
  }
  
  var hasMajor3rd: Bool {
    switch baseChordType {
    case .ma, .aug, .ma7, .ma6:
      return true
    default:
      return false
    }
  }
  
  var hasPerfect4th: Bool {
    switch self {
      // triads
    case .sus4,
      // dorian
        .mi11, .mi11_omit9, .mi13, .mi13_omit9,
      // phrygian
        .mi11_b9, .mi11_b9b13, .mi13_b9,
      // mi7(♭5)
        .mi11_b5, .mi11_b5b9, .mi11_b5b13, .locrian,
      // mi(♭13)
        .mi11_b13,
      // ˚7
        .dim11, .dim7_add11, .dim11_b13, .dim11_b13_omit9, .dim11_add_ma7, .dim11_add_ma7_omit9, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9:
      return true
    default:
      return false
    }
  }
  
  var hasSharp4th: Bool {
    switch self {
      // ma7(♯11)
    case .ma7_sh11, .ma9_sh11, .ma13_sh11, .ma13_sh11_omit9,
      // ma6(♯11)
        .ma6_sh9sh11, .ma6_b9sh11, .ma6_sh11, .ma6_9sh11:
      return true
    default:
      return false
    }
  }
  
  var hasDim5th: Bool {
    switch baseChordType {
    case .dim, .mi7_b5, .dim7:
      return true
    default:
      return false
    }
  }
  
  var hasPerfect5th: Bool {
    switch self {
      // has ♭5 or ♯5
    case let type where type.hasDim5th, let type where type.hasSharp5th:
      return false
    default:
      return true
    }
  }
  
  var hasSharp5th: Bool {
    switch self {
    case .aug:
      return true
    default:
      return false
    }
  }
  
  var hasMinor6th: Bool {
    switch self {
    case .mi_b6, .mi7_b13, .mi9_b13, .mi11_b13,
        .dim7_b13, .dim9_b13, .dim11_b13, .dim11_b13_omit9, .dim7_b13_add_ma7, .dim9_b13_add_ma7, .dim11_b13_add_ma7, .dim11_b13_add_ma7_omit9:
      return true
    default:
      return false
    }
  }
  
  var hasMajor6th: Bool {
    switch baseChordType {
      // ma6 chords
    case .ma6:
      return true
      // any ˚7 chord
    case .dim7:
      return false
    default:
      switch self {
        // has ♭6
      case let type where type.hasMinor6th:
        return false
        // Triads and unextended + unaltered 7th and 6th chords
      case .ma, .mi, .aug, .dim, .sus4, .sus2, .ma7, .mi7, .mi7_b5, .mi_b6,
        // Extended Major 7th chords
          .ma9, .ma7_sh11, .ma9_sh11,
        // Extended Minor 7th chords
          .mi9, .mi11, .mi11_omit9, .mi7_b9, .mi11_b9,
        // Extended Min7(♭5) chords
          .mi9_b5, .mi7_b5add11, .mi11_b5, .mi7_b5b9, .mi11_b5b9, .locrian:
        return false
      default:
        return true
      }
    }
  }
  
  var hasDim7th: Bool {
    baseChordType == .dim7 ? true : false
  }
  
  var hasMinor7th: Bool {
    switch baseChordType {
    case .mi7, .mi7_b5:
      return true
    default:
      return false
    }
  }
  
  var hasMajor7th: Bool {
    switch baseChordType {
    case .ma7:
      return true
    case .mi7, .mi7_b5, .ma6:
      return false
    case .dim7:
      switch self {
      case .dim7_add_ma7, .dim7_b13_add_ma7, .dim9_add_ma7, .dim9_b13_add_ma7, .dim11_add_ma7, .dim11_b13_add_ma7, .dim11_add_ma7_omit9, .dim11_b13_add_ma7_omit9:
        return true
      default:
        return false
      }
    default:
      return false
    }
  }
  
  var hasDegrees: [Bool] {
    [hasMinor9th,
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
  }
    
  enum HasDegree {
    case minor9th
    case major9th
    case sharp9th
    case minor3rd
    case major3rd
    case perfect4th
    case sharp4th
    case dim5th
    case perfect5th
    case sharp5th
    case minor6th
    case major6th
    case dim7th
    case minor7th
    case major7th
  }
  
  func setNotesByDegree(root: Root, rootKey: RootGen) -> [Note] {
    var allNotes: [Note] = [root]
    
    return allNotes
  }
  
  func setNotes(root: Root, rootKey: RootGen) -> [Note] {
    switch self {
      // MARK: Triads
    case .ma:
      // [0, 4, 7]
      return [root, Maj3(rootKey), P5(rootKey)]
    case .mi:
      // [0, 3, 7]
      return [root, Min3(rootKey), P5(rootKey)]
    case .aug:
      // [0, 4, 8]
      return [root, Maj3(rootKey), Sh_5(rootKey)]
    case .dim:
      // [0, 3, 6]
      return [root, Min3(rootKey), Dim5(rootKey)]
    case .sus4:
      // [0, 5, 7]
      return [root, P4(rootKey), P5(rootKey)]
    case .sus2:
      // [0, 2, 7]
      return [root, Maj9(rootKey), P5(rootKey)]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:
      // [0, 4, 7, 11]
      return [root, Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9:
      // [0, 2, 4, 7, 11]
      return [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13:
      // [0, 2, 4, 7, 9, 11]
      return [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_omit9:
      // [0, 4, 7, 9, 11]
      return [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma7_sh11:
      // [0, 4, 6, 7, 11]
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9_sh11:
      // [0, 2, 4, 6, 7, 11]
      return [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13_sh11:
      // [0, 2, 4, 6, 7, 9, 11]
      return [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_sh11_omit9:
      // [0, 4, 6, 7, 9, 11]
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
      
      // MARK: Major 6
    case .ma6:
      // [0, 4, 7, 9]
      return [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh9:
      // [0, 3, 4, 7, 9]
      return [root, Sh_9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_b9:
      // [0, 1, 4, 7, 9]
      return [root, Min9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh9sh11:
      // [0, 3, 4, 6, 7, 9]
      return [root, Sh_9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_b9sh11:
      // [0, 1, 4, 6, 7, 9]
      return [root, Min9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_sh11:
      // [0, 4, 6, 7, 9]
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_9:
      // [0, 2, 4, 7, 9]
      return [root, Maj9(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_9sh11:
      // [0, 2, 4, 6, 7, 9]
      return [root, Maj9(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      // [0, 3, 7, 10]
      return [root, Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi9:
      // [0, 2, 3, 7, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11:
      // [0, 2, 3, 5, 7, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_omit9:
      // [0, 3, 5, 7, 10]
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi13:
      // [0, 2, 3, 5, 7, 9, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit9:
      // [0, 3, 5, 7, 9, 10]
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit11:
      // [0, 2, 3, 7, 9, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi7_add13:
      // [0, 3, 7, 9, 10]
      return [root, Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: Phrygian
    case .mi7_b9:
      // [0, 1, 3, 7, 10]
      return [root, Min9(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi7_b9b13:
      // [0, 1, 3, 7, 8, 10]
      return [root, Min9(rootKey), Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi11_b9:
      // [0, 1, 3, 5, 7, 10]
      return [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_b9b13:
      // [0, 1, 3, 5, 7, 8, 10]
      return [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi13_b9:
      // [0, 1, 3, 5, 7, 9, 10]
      return [root, Min9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: Min(♭13)
    case .mi_b6:
      // [0, 3, 7, 8]
      return [root, Min3(rootKey), P5(rootKey), Min6(rootKey)]
    case .mi7_b13:
      // [0, 3, 7, 8, 10]
      return [root, Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi9_b13:
      // [0, 2, 3, 7, 8, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi11_b13:
      // [0, 2, 3, 5, 7, 8, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
      
      // MARK: mi7(♭5)
    case .mi7_b5:
      // [0, 3, 6, 10]
      return [root, Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi9_b5:
      // [0, 2, 3, 6, 10]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi7_b5add11:
      // [0, 3, 5, 6, 10]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5:
      // [0, 2, 3, 5, 6, 10]
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5b13: // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi7_b5b9:
      // [0, 1, 3, 6, 10]
      return [root, Min9(rootKey), Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5b9:
      // [0, 1, 3, 5, 6, 10]
      return [root, Min9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi7_b5b13:
      // [0, 1, 3, 6, 8, 10]
      return [root, Min9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .locrian: // [0, 1, 3, 5, 6, 8, 10] (mi11(♭5♭9♭13))
      return [root, Min9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi13_b5: // [0, 2, 3, 5, 6, 9, 10] (dorian ♭5 / 2nd
      return [root, Maj9(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_b5_omit9: // [0, 3, 5, 6, 9, 10]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_b5_omit11: // [0, 2, 3, 6, 9, 10]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi7_b5add13: // [0, 3, 6, 9, 10]
      return [root, Min3(rootKey), Dim5(rootKey), Maj6(rootKey), Min7(rootKey)]
      
      // MARK: diminished
    case .dim7: // [0, 3, 6, 9]
      return [root, Min3(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim7_b13: // [0, 3, 6, 8, 9]
      return [root, Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim7_add_ma7: // [0, 3, 6, 9, 11]
      return [root, Min3(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim7_b13_add_ma7: // [0, 3, 6, 8, 9, 11]
      return [root, Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim9: // [0, 2, 3, 6, 9]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim9_add_ma7: // [0, 2, 3, 6, 9, 11]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim9_b13: // [0, 2, 3, 6, 8, 9]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim9_b13_add_ma7: // [0, 2, 3, 6, 8, 9, 11]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11: // [0, 2, 3, 5, 6, 9]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim7_add11: // [0, 3, 5, 6, 9]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey)]
    case .dim11_b13: // [0, 2, 3, 5, 6, 8, 9]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim11_b13_omit9: // [0, 2, 3, 5, 6, 8, 9]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey)]
    case .dim11_add_ma7: // [0, 2, 3, 5, 6, 9, 11]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_add_ma7_omit9:  // [0, 3, 5, 6, 9, 11]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_b13_add_ma7: // [0, 2, 3, 5, 6, 8, 9, 11]
      return [root, Maj9(rootKey), Min3(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    case .dim11_b13_add_ma7_omit9: // [0, 3, 5, 6, 8, 9, 11]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Dim7(rootKey), Maj7(rootKey)]
    }
  }
  
  var degreesInC: [Int] {
    let root = Root(.c)
    return setNotes(root: root, rootKey: root.rootKey).map { $0.basePitchNum }
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

