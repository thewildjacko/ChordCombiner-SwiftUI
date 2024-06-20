//
//  DC.Maj6.Maj6_Slash_HalfWholeDim_Min3_Down.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_Slash_HalfWholeDim_Min3_Down: ComboChord, ComboChordInit {
    case sev_sh9, xiii_sh9sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: XIII_sh9sh11.uprStrNotes):
        // min triad on the #11
        self = .xiii_sh9sh11
      default:
        // dim triad on the b9, maj triad on the 6th
        self = .sev_sh9
      }
    }
    
    static let validCombos: [[Int]] = Sev_sh9.validCombos + XIII_sh9sh11.validCombos
    
    struct Sev_sh9 {
      static let validCombos = [[0, 1, 4, 7, 9]]
      static let uprStrNotes: [Int] = [1]
    }
    
    struct XIII_sh9sh11 {
      static let validCombos: [[Int]] = [[0, 1, 4, 6, 7, 9]]
      static let uprStrNotes: [Int] = [1, 6]
    }
    
    var quality: Suffix {
      switch self {
      case .sev_sh9:
        return .sev_sh9
      case .xiii_sh9sh11:
        return .xiii_sh9sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .sev_sh9:
        return Sev_sh9.uprStrNotes
      case .xiii_sh9sh11:
        return XIII_sh9sh11.uprStrNotes
      }
    }
  }

}
