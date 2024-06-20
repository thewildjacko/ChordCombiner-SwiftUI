//
//  DC.Maj6.HalfWholeDim.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_HalfWholeDim: ComboChord, ComboChordInit {
    case ma6_sh9, ma6_sh9sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Maj6_sh9sh11.uprStrNotes): // maj6(#9#11) (1-#9-3-#11-5-6-9)
        // dim triad on the root or b3
        self = .ma6_sh9sh11
      default: // maj6(#9) (1-#9-3-5-6-9)
        // min triad on the root, dim triad on the 6th
        self = .ma6_sh9
      }
    }
    
    static let validCombos: [[Int]] = Maj6_sh9.validCombos + Maj6_sh9sh11.validCombos
    
    struct Maj6_sh9 {
      static let validCombos = [[0, 3, 4, 7, 9]]
      static let uprStrNotes: [Int] = [3]
    }
    
    struct Maj6_sh9sh11 {
      static let validCombos = [[0, 3, 4, 6, 7, 9]]
      static let uprStrNotes: [Int] = [3, 6]
    }
    
    var quality: Suffix {
      switch self {
      case .ma6_sh9:
        return .ma6_sh9
      case .ma6_sh9sh11:
        return .ma6_sh9sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma6_sh9:
        return Maj6_sh9.uprStrNotes
      case .ma6_sh9sh11:
        return Maj6_sh9sh11.uprStrNotes
      }
    }
  }
  
}
