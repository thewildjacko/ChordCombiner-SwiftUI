//
//  DC.Dim7.Sev_Alt_P5Down.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dim7 {
  enum Sev_Alt_P5Down: ComboChord, ComboChordInit {
    case alt_b9sh9b13, sev_b9b13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Alt_b9sh9b13.uprStrNotes): // 7alt/IV (5-b7-b9-3-b13-1-#9), (5-b7-b9-3-b13-#9)
        // maj triad, sus2 or sus4 on b2, sus 2 on b5, sus4 on b6
        self = .alt_b9sh9b13
      default: // 7b9b13/IV (5-b7-b9-3-b13), (5-b7-b9-3-b13-1)
        // min triad on b5, aug triad on b2, p4, 6
        self = .sev_b9b13
      }
    }
    
    static let validCombos: [[Int]] = Sev_Alt_P5Down.Alt_b9sh9b13.validCombos + Sev_Alt_P5Down.Sev_b9b13.validCombos
    
    struct Alt_b9sh9b13 {
      static let validCombos: [[Int]] = [[0, 1, 3, 5, 6, 8, 9], [0, 1, 3, 6, 8, 9]]
      static let uprStrNotes: [Int] = [1, 8]
    }
    
    struct Sev_b9b13 {
      static let validCombos: [[Int]] = [[0, 1, 3, 6, 9], [0, 1, 3, 5, 6, 9]]
      static let uprStrNotes: [Int] = [1]
    }
    
    var quality: Suffix {
      switch self {
      case .alt_b9sh9b13:
        return .sev_alt
      case .sev_b9b13:
        return .sev_b9b13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .alt_b9sh9b13:
        return Alt_b9sh9b13.uprStrNotes
      case .sev_b9b13:
        return Sev_b9b13.uprStrNotes
      }
    }
  }
}
