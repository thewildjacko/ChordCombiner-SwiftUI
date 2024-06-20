//
//  DetailChord.Dom7.Mixolydian.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum Mixolydian: ComboChord, ComboChordInit {
    case seven, nine, xiii
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: XIII.uprStrNotes): // 13
        self = .xiii
        /*
         sus2 triad on the 2nd
         sus4 triad on the 2nd
         sus2 triad on the 5th
         min triad on the 6th
         sus4 triad on the 6th
         */
      case let degs where degs.isSuperset(of: Nine.uprStrNotes): // 9
        // sus2 on root, min or sus4 triad on p5
        self = .nine
      default: // 7
        //maj triad on root, dim triad on 3rd
        self = .seven
      }
    }
    
    static let validCombos: [[Int]] = Seven.validCombos + Nine.validCombos + XIII.validCombos
    
    struct Seven {
      static let validCombos = [[0, 4, 7, 10]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Nine {
      static let validCombos: [[Int]] = [[0, 2, 4, 7, 10]]
      static let uprStrNotes: [Int] = [2]
    }
    
    struct XIII {
      static let validCombos: [[Int]] = [[0, 2, 4, 7, 9, 10], [0, 4, 7, 9, 10]]
      static let uprStrNotes: [Int] = [9]
    }
    
    var quality: Suffix {
      switch self {
      case .seven:
        return .sev
      case .nine:
        return .nine
      case .xiii:
        return .xiii
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .seven:
        return Seven.uprStrNotes
      case .nine:
        return Nine.uprStrNotes
      case .xiii:
        return XIII.uprStrNotes
      }
    }
  }
}
