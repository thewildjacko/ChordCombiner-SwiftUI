//
//  Letter.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol SettableLetter {
  var letter: Letter  { get set }
}

/// Enum to get the letter name of a note
enum Letter: String, ChordAndScaleProperty{
  var id: Self { return self }
  
  case c = "C", d = "D" , e = "E", f = "F", g = "G", a = "A", b = "B"
  /// get Letter case from Int 0-6
  init(_ letterNum: Int) {
    switch letterNum {
    case 0:
      self = .c
    case 1:
      self = .d
    case 2:
      self = .e
    case 3:
      self = .f
    case 4:
      self = .g
    case 5:
      self = .a
    case 6:
      self = .b
    default:
      self = .c
    }
  }
}

extension Letter: Equatable {
  static func == (lhs: Letter, rhs: Letter) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

