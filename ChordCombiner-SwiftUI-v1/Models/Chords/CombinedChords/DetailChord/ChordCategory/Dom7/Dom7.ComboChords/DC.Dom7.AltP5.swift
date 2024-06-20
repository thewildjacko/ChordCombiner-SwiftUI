//
//  DC.Dom7.AltP5.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum AltP5: ComboChord, ComboChordInit {
    case sev_b9b13, sev_sh9b13, alt
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: [1, 3, 8]): // 7alt (b9 #9 b13)
        // sus2 on the b2, sus4 on the b6
        self = .alt
      case let degs where degs.isSuperset(of: [1, 8]): // 7(b9b13)
        // min triad on b2
        self = .sev_b9b13
      default: // 7(#9b13)
        // sus4 on b3, maj or sus2 triad on b6
        self = .sev_sh9b13
      }
    }
    
    static let validCombos: [[Int]] = Sev_b9b13.validCombos + Sev_sh9b13.validCombos + Alt.validCombos
    
    struct Sev_b9b13 {
      static let validCombos: [[Int]] = [[0, 1, 4, 7, 8, 10]]
      static let uprStrNotes: [Int] = [1, 8]
    }
    
    struct Sev_sh9b13 {
      static let validCombos: [[Int]] = [[0, 3, 4, 7, 8, 10]]
      static let uprStrNotes: [Int] = [3, 8]
    }
    
    struct Alt {
      static let validCombos: [[Int]] = [[0, 1, 3, 4, 7, 8, 10]]
      static let uprStrNotes: [Int] = [1, 3, 8]
    }
    
    var quality: Suffix {
      switch self {
      case .sev_b9b13:
        return .sev_b9b13
      case .sev_sh9b13:
        return .sev_sh9b13
      case .alt:
        return .sev_alt
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .sev_b9b13:
        return Sev_b9b13.uprStrNotes
      case .sev_sh9b13:
        return Sev_sh9b13.uprStrNotes
      case .alt:
        return Alt.uprStrNotes
      }
    }
  }

}
