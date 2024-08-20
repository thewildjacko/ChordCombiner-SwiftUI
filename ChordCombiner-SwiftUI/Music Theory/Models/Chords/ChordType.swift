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
  case ma
  case mi
  case aug
  case dim = "˚"
  case sus4
  case sus2
  
  // MARK: Major Lydian 7th Chords
  case ma7
  case ma9
  case ma13
  case ma13_omit9 = "ma13(omit9)"
  case ma7_sh11 = "ma7(♯11)"
  case ma9_sh11 = "ma9(♯11)"
  case ma13_sh11 = "ma13(♯11)"
  case ma13_sh11_no9 = "ma13(♯11 omit9)"
  
  // MARK: Major 6
  case ma6 = "6"
  case ma6_sh9 = "6(♯9)"
  case ma6_b9 = "6(♭9)"
  case ma6_sh9sh11 = "6(♯9♯11)"
  case ma6_b9sh11 = "6(♭9♯11)"
  case ma6_sh11 = "6(♯11)"
  case ma6_9 = "⁶/₉"
  case ma6_9sh11 = "⁶/₉(♯11)"
  
  // MARK: Minor Dorian 7th Chords
  case mi7
  case mi9
  case mi11
  case mi11_omit9 = "mi11(omit9)"
  case mi13
  case mi13_omit9 = "mi13(omit9)"
  case mi13_omit11 = "mi13(omit11)"
  case mi7_add13 = "mi7(add13)"
  
  // MARK: Phrygian
  case mi7_b9 = "mi7(♭9)"
  case mi7_b9b13  = "mi7(♭9♭13)"
  case mi11_b9 = "mi11(♭9)"
  case mi11_b9b13 = "mi11(♭9♭13)"
  case mi13_b9 = "mi13(♭9)"
  
  // MARK: Min(b13)
  case mi_b6 = "mi(♭6)"
  case mi7_b13 = "mi7(♭13)"
  case mi9_b13 = "mi9(♭13)"
  case mi11_b13 = "mi11(♭13)"
  
  // MARK: mi7(b5)
  case mi7_b5 = "mi7(♭5)"
  case mi9_b5 = "mi9(♭5)"
  case mi7_b5add11 = "mi7(♭5add11)"
  case mi11_b5 = "mi11(♭5)"
  case mi11_b5b13 = "mi11(♭5♭13)" // locrian ♯2
  case mi7_b5b9 = "mi7(♭5♭9)"
  case mi11_b5b9 = "mi11(♭5♭9)"
  case mi7_b5b13 = "mi7(♭5♭13)"
  case locrian = " locrian" // mi11(♭5♭9♭13)
  
  func setNotesAndEnharms(root: Root, rootKey: RootGen) -> [Note] {
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
      return [root, Maj2(rootKey), P5(rootKey)]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:
      // [0, 4, 7, 11]
      return [root, Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9:
      // [0, 2, 4, 7, 11]
      return [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13:
      // [0, 2, 4, 7, 9, 11]
      return [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_omit9:
      // [0, 4, 7, 9, 11]
      return [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma7_sh11:
      // [0, 4, 6, 7, 11]
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9_sh11:
      // [0, 2, 4, 6, 7, 11]
      return [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13_sh11:
      // [0, 2, 4, 6, 7, 9, 11]
      return [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_sh11_no9:
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
      return [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey)]
    case .ma6_9sh11:
      // [0, 2, 4, 6, 7, 9]
      return [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey)]
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      // [0, 3, 7, 10]
      return [root, Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi9:
      // [0, 2, 3, 7, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11:
      // [0, 2, 3, 5, 7, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_omit9:
      // [0, 3, 5, 7, 10]
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi13:
      // [0, 2, 3, 5, 7, 9, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit9:
      // [0, 3, 5, 7, 9, 10]
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_omit11:
      // [0, 2, 3, 7, 9, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
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
      
      // MARK: Min(b13)
    case .mi_b6:
      // [0, 3, 7, 8]
      return [root, Min3(rootKey), P5(rootKey), Min6(rootKey)]
    case .mi7_b13:
      // [0, 3, 7, 8, 10]
      return [root, Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi9_b13:
      // [0, 2, 3, 7, 8, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
    case .mi11_b13:
      // [0, 2, 3, 5, 7, 8, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min6(rootKey), Min7(rootKey)]
      
      // MARK: mi7(b5)
    case .mi7_b5:
      // [0, 3, 6, 10]
      return [root, Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi9_b5:
      // [0, 2, 3, 6, 10]
      return [root, Maj2(rootKey), Min3(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi7_b5add11:
      // [0, 3, 5, 6, 10]
      return [root, Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5:
      // [0, 2, 3, 5, 6, 10]
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min7(rootKey)]
    case .mi11_b5b13: // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), Dim5(rootKey), Min6(rootKey), Min7(rootKey)]
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
    }
  }
  
  var degreesInC: [Int] {
    let root = Root(.c)
    return setNotesAndEnharms(root: root, rootKey: root.rootKey).map { $0.num }
  }
}

