//
//  DC.Min7.Min_Slash_LydianMaj3rdDown.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7 {
  enum Min_Slash_LydianMaj3rdDown: ComboChord, ComboChordInit {
    case ma9
    init(_ degSet: Set<Int>) {
      self = .ma9
    }
    
    static let validCombos: [[Int]] = Flat6_Ma9.validCombos
    
    struct Flat6_Ma9 {
      static let validCombos = [[0, 3, 7, 8, 10]]
      static let uprStrNotes: [Int] = [8]
    }
    
    var quality: Suffix {
      switch self {
      case .ma9:
        return .ma9
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma9:
        return Flat6_Ma9.uprStrNotes
      }
    }
  }

}
