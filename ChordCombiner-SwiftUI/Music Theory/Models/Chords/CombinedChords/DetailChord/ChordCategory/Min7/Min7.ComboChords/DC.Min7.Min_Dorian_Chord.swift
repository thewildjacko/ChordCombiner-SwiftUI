//
//  DC.Min7.Min_Dorian_Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7 {
  enum Min_Dorian_Chord: ComboChord, ComboChordInit {
    case mi7, mi9, mi11, mi13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Mi13.uprStrNotes): // mi13 (1-3-5-7-13), (1-3-5-7-9-13), (1-3-5-7-11-13), (1-3-5-7-9-11-13)
        //maj triad on 4th, min triad or sus 4 on 2nd, dim triad on the 6th, sus2 triad on 5th
        self = .mi13
      case let degs where degs.isSuperset(of: Mi11.uprStrNotes): // mi11 (1-3-5-7-11), (1-3-5-7-9-11)
        //maj triad, sus2 or sus4 on b7th, sus4 on root, sus 2 on 4th
        self = .mi11
      case let degs where degs.isSuperset(of: Mi9.uprStrNotes): // mi9 (1-3-5-7-9)
        // min triad or sus 4 on 5th, sus 2 on the root
        self = .mi9
      default: // mi7 (1-3-5-7)
        //maj triad on min 3rd, min triad on root
        self = .mi7
      }
    }
    
    static let validCombos: [[Int]] = Mi7.validCombos + Mi9.validCombos + Mi11.validCombos + Mi13.validCombos
    
    struct Mi7 {
      static let validCombos = [[0, 3, 7, 10]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Mi9 {
      static let validCombos: [[Int]] = [[0, 2, 3, 7, 10]]
      static let uprStrNotes: [Int] = [2]
    }
    
    struct Mi11 {
      static let validCombos: [[Int]] = [[0, 3, 5, 7, 10], [0, 2, 3, 5, 7, 10]]
      static let uprStrNotes: [Int] = [5]
    }
    
    struct Mi13 {
      static let validCombos: [[Int]] = [[0, 3, 5, 7, 9, 10], [0, 2, 3, 5, 7, 9, 10], [0, 3, 7, 9, 10], [0, 2, 3, 7, 9, 10]]
      static let uprStrNotes: [Int] = [9]
    }
    
    var quality: Suffix {
      switch self {
      case .mi7:
        return .mi7
      case .mi9:
        return .mi9
      case .mi11:
        return .mi11
      case .mi13:
        return .mi13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .mi7:
        return Mi7.uprStrNotes
      case .mi9:
        return Mi9.uprStrNotes
      case .mi11:
        return Mi11.uprStrNotes
      case .mi13:
        return Mi13.uprStrNotes
      }
    }
  }

}
