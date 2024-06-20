//
//  DC.Dom7.MelodicMinor_Chord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum MelodicMinor_Chord: ComboChord, ComboChordInit {
    case sev_b13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case [0, 4, 7, 8, 10]: // 7(b13)
        //aug triad on root, 3, b6
        self = .sev_b13
      default:
        self = .sev_b13
      }
    }
    static let validCombos: [[Int]] = Sev_b13.validCombos
    
    struct Sev_b13 {
      static let validCombos: [[Int]] = [[0, 4, 7, 8, 10]]
      static let uprStrNotes: [Int] = [8]
    }
    
    var quality: Suffix {
      return .sev_b13
    }
    
    var uprStrNotes: [Int] {
      return Sev_b13.uprStrNotes
    }
  }
}
