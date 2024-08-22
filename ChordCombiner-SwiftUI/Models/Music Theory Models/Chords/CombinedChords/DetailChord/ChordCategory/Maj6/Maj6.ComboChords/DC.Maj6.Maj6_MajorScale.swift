//
//  DC.Maj6.MajorScale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj6 {
  enum Maj6_MajorScale: ComboChord, ComboChordInit {
    case ma6, ma6_9
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Maj6_9.uprStrNotes): // maj6/9 (1-3-5-6-9)
        // sus 4 triad on the 2nd, 5th, 6th; sus2 triad on the root, 2nd, 5th
        self = .ma6_9
      default: // maj6 (1-3-5-6)
        // maj triad on the root, min triad on the maj6
        self = .ma6
      }
    }
    
    static let validCombos: [[Int]] = Maj6.validCombos + Maj6_9.validCombos
    
    struct Maj6 {
      static let validCombos = [[0, 4, 7, 9]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Maj6_9 {
      static let validCombos: [[Int]] = [[0, 2, 4, 7, 9]]
      static let uprStrNotes: [Int] = [2]
    }
    
    var quality: Suffix {
      switch self {
      case .ma6:
        return .ma6
      case .ma6_9:
        return .ma6_9
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma6:
        return Maj6.uprStrNotes
      case .ma6_9:
        return Maj6_9.uprStrNotes
      }
    }
  }

}
