//
//  DC.Dom7.HexatonicSh9Sh11_Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum HexatonicSh9Sh11_Chord: ComboChord, ComboChordInit {
    case sev_sh9sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case [0, 3, 4, 6, 7, 10]: // 7(#9#11)
        //dim triad on the root, min triad on b3
        self = .sev_sh9sh11
      default:
        self = .sev_sh9sh11
      }
    }
    
    static let validCombos: [[Int]] = Sev_sh9sh11.validCombos
    
    struct Sev_sh9sh11 {
      static let validCombos: [[Int]] = [[0, 3, 4, 6, 7, 10]]
      static let uprStrNotes: [Int] = [3, 6]
    }
    
    var quality: Suffix {
      return .sev_sh9sh11
    }
    
    var uprStrNotes: [Int] {
      return Sev_sh9sh11.uprStrNotes
    }
  }
}
