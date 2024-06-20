//
//  DC.Dom7.LydianDom.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dom7 {
  enum LydianDom: ComboChord, ComboChordInit {
    case nine_sh11, xiii_sh11
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: LydianDom.XIII_sh11.uprStrNotes): // 13(#11)
        /*
         maj triad on maj2
         dim triad on #4
         */
        self = LydianDom.xiii_sh11
      default: // 9(#11)
        // aug triad on 2, #4, b7
        self = LydianDom.nine_sh11
      }
    }
    
    static let validCombos: [[Int]] = Nine_sh11.validCombos + XIII_sh11.validCombos
    
    struct Nine_sh11 {
      static let validCombos: [[Int]] = [[0, 2, 4, 6, 7, 10]]
      static let uprStrNotes: [Int] = [2, 6]
    }
    
    struct XIII_sh11 {
      static let validCombos: [[Int]] = [[0, 2, 4, 6, 7, 9, 10], [0, 4, 6, 7, 9, 10]]
      static let uprStrNotes: [Int] = [6, 9]
    }
    
    var quality: Suffix {
      switch self {
      case .nine_sh11:
        return .nine_sh11
      case .xiii_sh11:
        return .xiii_sh11
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .nine_sh11:
        return Nine_sh11.uprStrNotes
      case .xiii_sh11:
        return XIII_sh11.uprStrNotes
      }
    }
  }
}
