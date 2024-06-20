//
//  DC.Dom7.HalfWholeDim.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum HalfWholeDim: ComboChord, ComboChordInit {
    case sev_b9, sev_sh9, sev_b9sh11, xiii_b9, xiii_b9sh11, xiii_sh9, xiii_sh9sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: [1, 6, 9]): // 13(b9#11)
        // min triad on the #11
        self = .xiii_b9sh11
      case let degs where degs.isSuperset(of: [3, 6, 9]): // 13(#9#11)
        // dim triad on #9
        self = .xiii_sh9sh11
      case let degs where degs.isSuperset(of: [3, 9]): // 13(#9)
        // dim triad on the 6th
        self = .xiii_sh9
      case let degs where degs.isSuperset(of: [1, 9]): // 13(b9)
        //maj triad on the maj6
        self = .xiii_b9
      case let degs where degs.isSuperset(of: [1, 6]): // 7(b9#11)
        // maj triad on #11
        self = .sev_b9sh11
      case let degs where degs.contains(1): // 7(b9)
        // dim triad on b2, 5th, b7
        self = .sev_b9
      default: // 7(#9)
        // min triad on root, maj triad on b3
        self = .sev_sh9
      }
    }
    
    static let validCombos: [[Int]] = Sev_b9.validCombos + Sev_sh9.validCombos + Sev_b9sh11.validCombos + XIII_b9.validCombos + XIII_b9sh11.validCombos + XIII_sh9.validCombos + XIII_sh9sh11.validCombos
    
    struct Sev_b9 {
      static let validCombos: [[Int]] = [[0, 1, 4, 7, 10]]
      static let uprStrNotes: [Int] = [1]
    }
    
    struct Sev_sh9 {
      static let validCombos: [[Int]] = [[0, 3, 4, 7, 10]]
      static let uprStrNotes: [Int] = [3]
    }
    
    struct Sev_b9sh11 {
      static let validCombos: [[Int]] = [[0, 1, 4, 6, 7, 10]]
      static let uprStrNotes: [Int] = [1, 6]
    }
    
    struct XIII_b9 {
      static let validCombos: [[Int]] = [[0, 1, 4, 7, 9, 10]]
      static let uprStrNotes: [Int] = [1, 9]
    }
    
    struct XIII_b9sh11 {
      static let validCombos: [[Int]] = [[0, 1, 4, 6, 7, 9, 10]]
      static let uprStrNotes: [Int] = [1, 6, 9]
    }
    
    struct XIII_sh9 {
      static let validCombos: [[Int]] = [[0, 3, 4, 7, 9, 10]]
      static let uprStrNotes: [Int] = [3, 9]
    }
    
    struct XIII_sh9sh11 {
      static let validCombos: [[Int]] = [[0, 3, 4, 6, 7, 9, 10]]
      static let uprStrNotes: [Int] = [3, 6, 9]
    }
    
    var quality: Suffix {
      switch self {
      case .sev_b9:
        return .sev_b9
      case .sev_sh9:
        return .sev_sh9
      case .sev_b9sh11:
        return .sev_b9sh11
      case .xiii_b9:
        return .xiii_b9
      case .xiii_b9sh11:
        return .xiii_b9sh11
      case .xiii_sh9:
        return .xiii_sh9
      case .xiii_sh9sh11:
        return .xiii_sh9sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .sev_b9:
        return Sev_b9.uprStrNotes
      case .sev_sh9:
        return Sev_sh9.uprStrNotes
      case .sev_b9sh11:
        return Sev_b9sh11.uprStrNotes
      case .xiii_b9:
        return XIII_b9.uprStrNotes
      case .xiii_b9sh11:
        return XIII_b9sh11.uprStrNotes
      case .xiii_sh9:
        return XIII_sh9.uprStrNotes
      case .xiii_sh9sh11:
        return XIII_sh9sh11.uprStrNotes
      }
    }
  }
}
