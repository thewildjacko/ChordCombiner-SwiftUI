//
//  DC.Min7.Min_Phrygian.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7 {
  enum Min_Phrygian: ComboChord, ComboChordInit {
    case mi7_b9, mi11_b9, mi7_b9b13, mi11_b9b13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Mi11_b9b13.uprStrNotes): // mi11(b9b13) (1-3-5-7-b9-11-b13)
        // maj triad on b2
        self = .mi11_b9b13
      case let degs where degs.isSuperset(of: Mi7_b9b13.uprStrNotes): // mi7(b9b13) (1-3-5-7-b9-b13)
        // sus2 triad on b2, sus4 on b6
        self = .mi7_b9b13
      case let degs where degs.isSuperset(of: Mi11_b9.uprStrNotes): // mi11(b9) (1-3-5-7-b9-11)
        // min triad on b7
        self = .mi11_b9
      default: // mi7(b9) (1-3-5-7-b9)
        // dim triad on 5th
        self = .mi7_b9
      }
    }
    
    static let validCombos: [[Int]] = Mi7_b9.validCombos + Mi11_b9.validCombos + Mi7_b9b13.validCombos + Mi11_b9b13.validCombos
    
    struct Mi7_b9 {
      static let validCombos = [[0, 1, 3, 7, 10]]
      static let uprStrNotes: [Int] = [1]
    }
    
    struct Mi11_b9 {
      static let validCombos = [[0, 1, 3, 5, 7, 10]]
      static let uprStrNotes: [Int] = [1, 5]
    }
    
    struct Mi7_b9b13 {
      static let validCombos = [[0, 1, 3, 7, 8, 10]]
      static let uprStrNotes: [Int] = [1, 8]
    }
    
    struct Mi11_b9b13 {
      static let validCombos = [[0, 1, 3, 5, 7, 8, 10]]
      static let uprStrNotes: [Int] = [1, 5, 8]
    }
    
    var quality: Suffix {
      switch self {
      case .mi7_b9:
        return .mi7_b9
      case .mi11_b9:
        return .mi11_b9
      case .mi7_b9b13:
        return .mi7_b9b13
      case .mi11_b9b13:
        return .mi11_b9b13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .mi7_b9:
        return Mi7_b9.uprStrNotes
      case .mi11_b9:
        return Mi11_b9.uprStrNotes
      case .mi7_b9b13:
        return Mi7_b9b13.uprStrNotes
      case .mi11_b9b13:
        return Mi11_b9b13.uprStrNotes
      }
    }
  }

}
