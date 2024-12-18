//
//  Enharmonic.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol Enharmonic {
  var enharmonic: EnharmonicSymbol { get }  // sets whether note belongs to sharp key or flat key
}

protocol EnharmonicID: Enharmonic, SettableLetter, SettableAccidental { }

/// enum to determine whether a key is "flat" or "sharp"
enum EnharmonicSymbol: Int, CaseIterable, CustomStringConvertible, Codable {
  case flat = 0, sharp

  var description: String {
    switch self {
    case .flat:
      return "♭"
    case .sharp:
      return "♯"
    }
  }
}
