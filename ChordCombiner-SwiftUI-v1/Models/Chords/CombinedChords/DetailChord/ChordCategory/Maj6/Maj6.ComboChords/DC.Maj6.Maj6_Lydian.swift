//
//  DC.Maj6.Maj6_Lydian.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_Lydian: ComboChord, ComboChordInit {
    case ma6_sh11, ma6_9sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Maj6_9sh11.uprStrNotes): // maj6/9(#11) (1-9-3-#11-5-6-9)
        // maj triad on the maj 2nd
        self = .ma6_9sh11
      default: // maj6(#11) (1-3-#11-5-6-9)
        // dim triad on the #11
        self = .ma6_sh11
      }
    }
    
    static let validCombos: [[Int]] = Maj6_sh11.validCombos + Maj6_9sh11.validCombos
    
    struct Maj6_sh11 {
      static let validCombos = [[0, 4, 6, 7, 9]]
      static let uprStrNotes: [Int] = [6]
    }
    
    struct Maj6_9sh11 {
      static let validCombos = [[0, 2, 4, 6, 7, 9]]
      static let uprStrNotes: [Int] = [2, 6]
    }
    
    var quality: Suffix {
      switch self {
      case .ma6_sh11:
        return .ma6_sh11
      case .ma6_9sh11:
        return .ma6_9sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma6_sh11:
        return Maj6_sh11.uprStrNotes
      case .ma6_9sh11:
        return Maj6_9sh11.uprStrNotes
      }
    }
  }

}
