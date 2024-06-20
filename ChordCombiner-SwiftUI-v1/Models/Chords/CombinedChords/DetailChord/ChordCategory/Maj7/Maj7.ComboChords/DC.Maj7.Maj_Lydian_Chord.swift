//
//  DC.Maj7.Maj_Lydian_Chord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Maj7 {
  enum Maj_Lydian_Chord: ComboChord, ComboChordInit {
    case ma7, ma9, ma13, ma7_sh11, ma9_sh11, ma13_sh11
    
    init(_ degSet: Set<Int>) {
      if degSet.contains(6) {
        switch degSet {
        case let degs where degs.contains(9): // ma13#11
          // maj triad on the 2nd (1-3-5-7-9-#11-13)
          // dim triad on the #4 (1-3-5-7-#11-13-1)
          self = .ma13_sh11
        case let degs where degs.contains(2): // ma9#11 (1-3-5-7-9-#11)
          // min triad on maj7th
          self = .ma9_sh11
        default: // ma7#11
          // sus4 on the maj7th
          // sus2 on the maj 3rd
          self = .ma7_sh11
        }
      } else {
        switch degSet {
        case let degs where degs.contains(9): // ma13 (1-3-5-7-13)
          /*
           sus4 triad on the 2nd
           sus2 on the 2nd
           sus4 on the 3rd
           sus2 on the 5th
           min triad on 6th
           sus4 on the 6th
           sus2 on the 6th
           */
          self = .ma13
        case let degs where degs.contains(2): // ma9 (1-3-5-7-9)
          /*
           maj triad on the 5th (1-3-5-7-9)
           sus4 on the 5th
           sus2 on the root
           */
          self = .ma9
        default: // maj7 (1-3-5-7)
          /*
           maj triad on root
           min triad on maj 3rd
           */
          self = .ma7
        }
      }
    }
    
    static let validCombos: [[Int]] = Ma7.validCombos + Ma9.validCombos + Ma13.validCombos + Ma7_sh11.validCombos + Ma9_sh11.validCombos + Ma13_sh11.validCombos
    
    struct Ma7 {
      static let validCombos: [[Int]] = [[0, 4, 7, 11]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Ma9 {
      static let validCombos: [[Int]] = [[0, 2, 4, 7, 11]]
      static let uprStrNotes: [Int] = [2]
    }
    
    struct Ma13 {
      static let validCombos: [[Int]] = [[0, 4, 7, 9, 11], [0, 2, 4, 7, 9, 11]]
      static let uprStrNotes: [Int] = [9]
    }
    
    struct Ma7_sh11 {
      static let validCombos: [[Int]] = [[0, 4, 6, 7, 11]]
      static let uprStrNotes: [Int] = [6]
    }
    
    struct Ma9_sh11 {
      static let validCombos: [[Int]] = [[0, 2, 4, 6, 7, 11]]
      static let uprStrNotes: [Int] = [2, 6]
    }
    
    struct Ma13_sh11 {
      static let validCombos: [[Int]] = [[0, 2, 4, 6, 7, 9, 11], [0, 4, 6, 7, 9, 11]]
      static let uprStrNotes: [Int] = [6, 9]
    }
    
    var quality: Suffix {
      switch self {
      case .ma7:
        return .ma7
      case .ma9:
        return .ma9
      case .ma13:
        return .ma13
      case .ma7_sh11:
        return .ma7_sh11
      case .ma9_sh11:
        return .ma9_sh11
      case .ma13_sh11:
        return .ma13_sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .ma7:
        return Ma7.uprStrNotes
      case .ma9:
        return Ma9.uprStrNotes
      case .ma13:
        return Ma13.uprStrNotes
      case .ma7_sh11:
        return Ma7_sh11.uprStrNotes
      case .ma9_sh11:
        return Ma9_sh11.uprStrNotes
      case .ma13_sh11:
        return Ma13_sh11.uprStrNotes
      }
    }
  }
}
