//
//  DC.Min7b5.Min7b5_Locrian_Chord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7_b5 {
  enum Min7b5_Locrian_Chord: ComboChord, ComboChordInit {
    case locrian, mi7_b5b9, mi11_b5b9
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Locrian.uprStrNotes): // locrian (1-3-b5-7-b9-11-b13)
        // maj triad, sus2 or sus4 on b2, sus2 on b5, sus4 on b6
        self = .locrian
      case let degs where degs.isSuperset(of: Mi11_b5b9.uprStrNotes): // mi11(b5b9) (1-3-b5-7-b9-11)
        // min triad on b7
        self = .mi11_b5b9
      default: // mi7(b5b9) (1-3-b5-7-b9)
        // maj triad on b5
        self = .mi7_b5b9
      }
    }
    
    static let validCombos: [[Int]] = Mi7_b5b9.validCombos + Mi11_b5b9.validCombos + Locrian.validCombos
    
    struct Locrian {
      static let validCombos = [[0, 1, 3, 6, 8, 10], [0, 1, 3, 5, 6, 8, 10]]
      static let uprStrNotes: [Int] = [1, 8]
    }
    
    struct Mi11_b5b9 {
      static let validCombos: [[Int]] = [[0, 1, 3, 5, 6, 10]]
      static let uprStrNotes: [Int] = [1, 5]
    }
    
    struct Mi7_b5b9 {
      static let validCombos: [[Int]] = [[0, 1, 3, 6, 10]]
      static let uprStrNotes: [Int] = [1]
    }
    
    var quality: Suffix {
      switch self {
      case .locrian:
        return .locrian
      case .mi11_b5b9:
        return .mi11_b5b9
      case .mi7_b5b9:
        return .mi7_b5b9
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .locrian:
        return Locrian.uprStrNotes
      case .mi11_b5b9:
        return Mi11_b5b9.uprStrNotes
      case .mi7_b5b9:
        return Mi7_b5b9.uprStrNotes
      }
    }
  }
  
}
