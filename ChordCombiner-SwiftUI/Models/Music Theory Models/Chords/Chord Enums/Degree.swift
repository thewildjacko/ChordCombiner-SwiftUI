  //
//  DegName.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// long, medium and short names for scale/chord degrees
enum Degree: String, CaseIterable {
  case root
  case minor9th
  case major9th
  case sharp9th
  case minor3rd
  case major3rd
  case perfect4th
  case sharp4th
  case dim5th
  case perfect5th
  case sharp5th
  case minor6th
  case major6th
  case dim7th
  case minor7th
  case major7th
  
  /// long form names
  var long: String {
    switch self {
    case .root:
      return "root"
    case .minor9th:
      return "♭9"
    case .major9th:
      return "major 9th"
    case .sharp9th:
      return "♯9"
    case .minor3rd:
      return "minor 3rd"
    case .major3rd:
      return "major 3rd"
    case .perfect4th:
      return "perfect 4th"
    case .sharp4th:
      return "♯11"
    case .dim5th:
      return "♯11"
    case .perfect5th:
      return "perfect 5th"
    case .sharp5th:
      return "♯5"
    case .minor6th:
      return "minor 6th"
    case .major6th:
      return "major 6th"
    case .dim7th:
      return "diminished 7th"
    case .minor7th:
      return "minor 7th"
    case .major7th:
      return "major 7th"
    }
  }

/// partly spelled-out degree names  
  var name: String {
    switch self {
    case .root:
      return "root"
    case .minor9th:
      return "♭9"
    case .major9th:
      return "maj9"
    case .sharp9th:
      return "♯9"
    case .minor3rd:
      return "min3"
    case .major3rd:
      return "maj3"
    case .perfect4th:
      return "P4"
    case .sharp4th:
      return "♯11"
    case .dim5th:
      return "♭5"
    case .perfect5th:
      return "P5"
    case .sharp5th:
      return "♯5"
    case .minor6th:
      return "min6"
    case .major6th:
      return "maj6"
    case .dim7th:
      return "˚7"
    case .minor7th:
      return "♭7"
    case .major7th:
      return "maj7"
    }
  }

/// concise names (3 characters or less)
  var short: String {
      switch self {
      case .root:
        return "R"
      case .minor9th:
        return "♭9"
      case .major9th:
        return "9"
      case .sharp9th:
        return "♯9"
      case .minor3rd:
        return "♭3"
      case .major3rd:
        return "3"
      case .perfect4th:
        return "P4"
      case .sharp4th:
        return "♯11"
      case .dim5th:
        return "♭5"
      case .perfect5th:
        return "P5"
      case .sharp5th:
        return "♯5"
      case .minor6th:
        return "♭13"
      case .major6th:
        return "13"
      case .dim7th:
        return "˚7"
      case .minor7th:
        return "♭7"
      case .major7th:
        return "7"
      }
    }
}
