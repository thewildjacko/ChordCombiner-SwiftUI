//
//  DC.Maj6.Maj6_Slash_AltP5_Min3_Down.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_Slash_AltP5_Min3_Down: ComboChord, ComboChordInit {
    case sev_sh9b13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      default:
        // aug triad on the b9, P4 or maj6
        self = .sev_sh9b13
      }
    }
    
    static let validCombos: [[Int]] = Sev_sh9b13.validCombos
    
    struct Sev_sh9b13 {
      static let validCombos = [[0, 1, 4, 5, 7, 9]]
      static let uprStrNotes: [Int] = [1, 5]
    }
    
    
    var quality: Suffix {
      switch self {
      case .sev_sh9b13:
        return .sev_sh9b13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .sev_sh9b13:
        return Sev_sh9b13.uprStrNotes
      }
    }
  }

}
