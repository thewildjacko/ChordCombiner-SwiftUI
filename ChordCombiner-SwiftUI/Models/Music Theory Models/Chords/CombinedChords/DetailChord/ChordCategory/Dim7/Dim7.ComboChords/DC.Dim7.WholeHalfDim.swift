//
//  DC.Dim7.WholeHalfDim.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord.Dim7 {
  enum WholeHalfDim: ComboChord, ComboChordInit {
    case dim7, dim7_b13, dim7_add_ma7, dim7_b13_add_ma7, dim9, dim9_add_ma7, dim9_b13_add_ma7, dim11, dim11_b13, dim11_add_ma7, dim11_b13_add_ma7
    
    init(_ degSet: Set<Int>) {
      switch degSet {
      case let degs where degs.isSuperset(of: Dim11_b13_add_ma7.uprStrNotes): // dim11b13(add ma7) (1-3-b5-˚7-11-b13-ma7)
        // dim triad on p4
        self = .dim11_b13_add_ma7
      case let degs where degs.isSuperset(of: Dim9_b13_add_ma7.uprStrNotes): // dim9b13(add ma7) (1-3-b5-˚7-9-b13-ma7)
        // dim triad on b6
        self = .dim9_b13_add_ma7
      case let degs where degs.isSuperset(of: Dim11_add_ma7.uprStrNotes): // dim11(add ma7) (1-3-b5-˚7-11-b13-ma7)
        // dim triad on maj7
        self = .dim11_add_ma7
      case let degs where degs.isSuperset(of: Dim7_b13_add_ma7.uprStrNotes): // dim7b13(add ma7) (1-3-b5-˚7-b13-ma7)
        // min triad on b6
        self = .dim7_b13_add_ma7
      case let degs where degs.isSuperset(of: Dim11_b13.uprStrNotes): // dim11(b13) (1-3-b5-˚7-11-b13), (1-3-b5-˚7-9-11-b13)
        // dim triad on 2, min triad on p4
        self = .dim11_b13
      case let degs where degs.isSuperset(of: Dim9_add_ma7.uprStrNotes):  // dim9(add ma7) (1-3-b5-˚7-9-ma7)
        // min triad on ma7
        self = .dim9_add_ma7
      case let degs where degs.isSuperset(of: Dim7_add_ma7.uprStrNotes):  // dim7(add ma7) (1-3-b5-˚7-ma7)
        // maj triad on ma7
        self = .dim7_add_ma7
      case let degs where degs.isSuperset(of: Dim7_b13.uprStrNotes): // dim7(b13) (1-3-b5-˚7-b13)
        // maj triad on b6
        self = .dim7_b13
      case let degs where degs.isSuperset(of: Dim11.uprStrNotes): // dim11 (1-b3-b5-bb7-11), (1-b3-b5-˚7-9-11)
        // maj triad on p4, min triad on 2
        self = .dim11
      case let degs where degs.isSuperset(of: Dim9.uprStrNotes): // dim9 (1-b3-b5-˚7-9)
        // maj triad on 2
        self = .dim9
      default: // dim7 (1-b3-b5-˚7)
        // dim triad on root, b3, b5, ˚7
        self = .dim7
      }
      
    }
    
    static let validCombos: [[Int]] = Dim7.validCombos + Dim7_b13.validCombos + Dim7_add_ma7.validCombos + Dim7_b13_add_ma7.validCombos + Dim9.validCombos + Dim9_add_ma7.validCombos + Dim9_b13_add_ma7.validCombos + Dim11.validCombos + Dim11_b13.validCombos + Dim11_add_ma7.validCombos + Dim11_b13_add_ma7.validCombos
    
    struct Dim7 {
      static let validCombos: [[Int]] = [[0, 3, 6, 9]]
      static let uprStrNotes: [Int] = []
    }
    
    struct Dim7_b13 {
      static let validCombos: [[Int]] = [[0, 3, 6, 8, 9]]
      static let uprStrNotes: [Int] = [8]
    }
    
    struct Dim7_add_ma7 {
      static let validCombos: [[Int]] = [[0, 3, 6, 9, 11]]
      static let uprStrNotes: [Int] = [11]
    }
    
    struct Dim7_b13_add_ma7 {
      static let validCombos: [[Int]] = [[0, 3, 6, 8, 9, 11]]
      static let uprStrNotes: [Int] = [8, 11]
    }
    
    struct Dim9 {
      static let validCombos: [[Int]] = [[0, 2, 3, 6, 9]]
      static let uprStrNotes: [Int] = [2]
    }
    
    struct Dim9_add_ma7 {
      static let validCombos: [[Int]] = [[0, 2, 3, 6, 9, 11]]
      static let uprStrNotes: [Int] = [2, 11]
    }
    
    struct Dim9_b13_add_ma7 {
      static let validCombos: [[Int]] = [[0, 2, 3, 6, 8, 9, 11]]
      static let uprStrNotes: [Int] = [2, 8, 11]
    }
    
    struct Dim11 {
      static let validCombos: [[Int]] = [[0, 3, 5, 6, 9], [0, 2, 3, 5, 6, 9]]
      static let uprStrNotes: [Int] = [5]
    }
    
    struct Dim11_b13 {
      static let validCombos: [[Int]] = [[0, 3, 5, 6, 8, 9], [0, 2, 3, 5, 6, 8, 9]]
      static let uprStrNotes: [Int] = [5, 8]
    }
    
    struct Dim11_add_ma7 {
      static let validCombos: [[Int]] = [[0, 2, 3, 5, 6, 9, 11]]
      static let uprStrNotes: [Int] = [5, 11]
    }
    
    struct Dim11_b13_add_ma7 {
      static let validCombos: [[Int]] = [[0, 3, 5, 6, 8, 9, 11]]
      static let uprStrNotes: [Int] = [5, 8, 11]
    }
    
    var quality: Suffix {
      switch self {
      case .dim7:
        return .dim7
      case .dim7_b13:
        return .dim7_b13
      case .dim7_add_ma7:
        return .dim7_add_ma7
      case .dim7_b13_add_ma7:
        return .dim7_b13_add_ma7
      case .dim9:
        return .dim9
      case .dim9_add_ma7:
        return .dim9_add_ma7
      case .dim9_b13_add_ma7:
        return .dim9_b13_add_ma7
      case .dim11:
        return .dim11
      case .dim11_b13:
        return .dim11_b13
      case .dim11_add_ma7:
        return .dim11_add_ma7
      case .dim11_b13_add_ma7:
        return .dim11_b13_add_ma7
      }
    }
    
    var uprStrNotes: [Int] {
      switch self {
      case .dim7:
        return Dim7.uprStrNotes
      case .dim7_b13:
        return Dim7_b13.uprStrNotes
      case .dim7_add_ma7:
        return Dim7_add_ma7.uprStrNotes
      case .dim7_b13_add_ma7:
        return Dim7_b13_add_ma7.uprStrNotes
      case .dim9:
        return Dim9.uprStrNotes
      case .dim9_add_ma7:
        return Dim9_add_ma7.uprStrNotes
      case .dim9_b13_add_ma7:
        return Dim9_b13_add_ma7.uprStrNotes
      case .dim11:
        return Dim11.uprStrNotes
      case .dim11_b13:
        return Dim11_b13.uprStrNotes
      case .dim11_add_ma7:
        return Dim11_add_ma7.uprStrNotes
      case .dim11_b13_add_ma7:
        return Dim11_b13_add_ma7.uprStrNotes
      }
    }
  }

}
