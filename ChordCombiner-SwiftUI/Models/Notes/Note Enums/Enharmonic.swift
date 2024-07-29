//
//  Enharmonic.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// enum to determine whether a key is "flat" or "sharp"
enum Enharmonic: Int, CaseIterable, CustomStringConvertible, Codable {
  case flat = 0, sharp, blackKeyFlats, blackKeySharps
  
  var description: String {
    switch self {
    case .flat:
      return "♭"
    case .sharp:
      return "♯"
    case .blackKeyFlats:
      return "black key ♭'s, white key ♮'s"
    case .blackKeySharps:
      return "black key ♯'s, white key ♮'s"
    }
  }
}


