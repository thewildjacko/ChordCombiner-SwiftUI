//
//  DC.Min7.Min_Slash_LydianDom_Maj6thDown.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7 {
  enum Min_Slash_LydianDom_Maj6thDown: ComboChord, ComboChordInit {
    case xiii_sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      default: // 13(#11) (1-3-5-7-9-#11-13)
        // aug triad on the b2, P4, maj6
        self = .xiii_sh11
      }
    }
    
    static let validCombos: [[Int]] = XIII_sh11.validCombos
    
    struct XIII_sh11 {
      static let validCombos = [[0, 1, 3, 5, 7, 9, 10]]
      static let uprStrNotes: [Int] = [1, 5, 9]
    }
    
    var quality: Suffix {
      switch self {
      case .xiii_sh11:
        return .xiii_sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .xiii_sh11:
        return XIII_sh11.uprStrNotes
      }
    }
  }

}
