//
//  DC.Min7_b5.Min7b5_LocrianSharp2_Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Min7_b5 {
  enum Min7b5_LocrianSharp2_Chord: ComboChord, ComboChordInit {
    case mi7_b5, mi9_b5, mi11_b5, mi7_b5b13, mi11_b5b13
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Mi11_b5b13.uprStrNotes): // mi11(b5b13) (1-3-b5-7-11-b13), (1-3-b5-7-9-11-b13)
        // dim triad on 2, min triad on p4
        self = .mi11_b5b13
      case let degs where degs.isSuperset(of: Mi11_b5.uprStrNotes): // mi11(b5) (1-3-b5-7-9-11) or (1-3-b5-7-11)
        // maj triad on b7, sus4 on p4, sus2 on b7
        self = .mi11_b5
      case let degs where degs.isSuperset(of: Mi7_b5b13.uprStrNotes): // mi7(b5b13) (1-3-b5-7-b13)
        // maj or sus2 on b6, sus4 triad on b3
        self = .mi7_b5b13
      case let degs where degs.isSuperset(of: Mi9_b5.uprStrNotes): // mi9(b5) (1-3-b5-7-9)
        // aug triad on 2, b5, b7
        self = .mi9_b5
      default: // mi7(b5) (1-3-b5-7)
        // dim triad on root, min triad on b3
        self = .mi7_b5
      }
    }
    
    static let validCombos: [[Int]] = Mi7_b5.validCombos + Mi9_b5.validCombos + Mi11_b5.validCombos + Mi7_b5b13.validCombos + Mi11_b5b13.validCombos
    
    struct Mi7_b5 {
      static let validCombos = [[0, 3, 6, 10]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Mi9_b5 {
      static let validCombos = [[0, 2, 3, 6, 10]]
      static let uprStrNotes: [Int] = [2]
    }
    
    struct Mi11_b5 {
      static let validCombos = [[0, 3, 5, 6, 10], [0, 2, 3, 5, 6, 10]]
      static let uprStrNotes: [Int] = [5]
    }
    
    struct Mi7_b5b13 {
      static let validCombos = [[0, 3, 6, 8, 10]]
      static let uprStrNotes: [Int] = [8]
    }
    
    struct Mi11_b5b13 {
      static let validCombos = [[0, 3, 5, 6, 8, 10], [0, 2, 3, 5, 6, 8, 10]]
      static let uprStrNotes: [Int] = [5, 8]
    }
    
    var quality: Suffix {
      switch self {
      case .mi7_b5:
        return .mi7_b5
      case .mi9_b5:
        return .mi9_b5
      case .mi11_b5:
        return .mi11_b5
      case .mi7_b5b13:
        return .mi7_b5b13
      case .mi11_b5b13:
        return .mi11_b5b13
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .mi7_b5:
        return Mi7_b5.uprStrNotes
      case .mi9_b5:
        return Mi9_b5.uprStrNotes
      case .mi11_b5:
        return Mi11_b5.uprStrNotes
      case .mi7_b5b13:
        return Mi7_b5b13.uprStrNotes
      case .mi11_b5b13:
        return Mi11_b5b13.uprStrNotes
      }
    }
  }
}
