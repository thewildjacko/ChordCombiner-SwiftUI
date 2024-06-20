//
//  DC.Maj6.Maj6_Slash_Lydian_P5_Down.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_Slash_Lydian_P5_Down: ComboChord, ComboChordInit {
    case ma9, ma13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Ma13.uprStrNotes): // ma13 P5 down (5-13-7-1-9-3)
        // min triad on the maj2
        self = .ma13
      default: // ma9 P5 down (5-7-1-9-3)
        // maj triad on the P4, sus 4 triad on the root, sus2 triad on the P4
        self = .ma9
      }
    }
    
    static let validCombos: [[Int]] = Ma13.validCombos + Ma9.validCombos
    
    struct Ma13 {
      static let validCombos = [[0, 2, 4, 5, 7, 9]]
      static let uprStrNotes: [Int] = [2, 5]
    }
    
    struct Ma9 {
      static let validCombos = [[0, 4, 5, 7, 9]]
      static let uprStrNotes: [Int] = [5]
    }
    
    var quality: Suffix {
      switch self {
      case .ma9:
        return .ma9
      case .ma13:
        return .ma13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma9:
        return Ma9.uprStrNotes
      case .ma13:
        return Ma13.uprStrNotes
      }
    }
  }

}

