//
//  DC.Min7.Min_Slash_DorianP5Down.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7 {
  enum Min_Slash_DorianP5Down: ComboChord, ComboChordInit {
    case mi11, mi13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Mi13.uprStrNotes): // mi13 (1-3-5-7-9-11-13)
        // dim triad on the 2nd
        self = .mi13
      default:
        self = .mi11 // min triad on the P4
      }
    }
    
    static let validCombos: [[Int]] = Mi11.validCombos + Mi13.validCombos
    
    struct Mi11 {
      static let validCombos = [[0, 3, 5, 7, 8, 10]]
      static let uprStrNotes: [Int] = [5, 8]
    }
    
    struct Mi13 {
      static let validCombos = [[0, 2, 3, 5, 7, 8, 10]]
      static let uprStrNotes: [Int] = [2, 5, 8]
    }
    
    var quality: Suffix {
      switch self {
      case .mi11:
        return .mi11
      case .mi13:
        return .mi13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .mi11:
        return Mi11.uprStrNotes
      case .mi13:
        return Mi13.uprStrNotes
      }
    }
  }

}
