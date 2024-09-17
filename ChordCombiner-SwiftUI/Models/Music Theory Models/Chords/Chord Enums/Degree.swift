  //
//  Degree.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// long, medium and short names for scale/chord degrees
enum Degree: String, CaseIterable, GettableNoteNum, Codable {
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
  
  /// noteNum
  var noteNum: NoteNum {
    switch self {
    case .root:
      return .zero
    case .minor9th:
      return .one 
    case .major9th:
      return .two
    case .sharp9th:
      return .three
    case .minor3rd:
      return .three
    case .major3rd:
      return .four
    case .perfect4th:
      return .five
    case .sharp4th:
      return .six
    case .dim5th:
      return .six
    case .perfect5th:
      return .seven
    case .sharp5th:
      return .eight
    case .minor6th:
      return .eight
    case .major6th:
      return .nine
    case .dim7th:
      return .nine
    case .minor7th:
      return .ten
    case .major7th:
      return .eleven
    }
  }
  
  /// long form names
  var long: String {
    switch self {
    case .root:
      return "Root"
    case .minor9th:
      return "♭9"
    case .major9th:
      return "Major 9th"
    case .sharp9th:
      return "♯9"
    case .minor3rd:
      return "Minor 3rd"
    case .major3rd:
      return "Major 3rd"
    case .perfect4th:
      return "Perfect 4th"
    case .sharp4th:
      return "♯11"
    case .dim5th:
      return "Diminished 5th"
    case .perfect5th:
      return "Perfect 5th"
    case .sharp5th:
      return "♯5"
    case .minor6th:
      return "Minor 6th"
    case .major6th:
      return "Major 6th"
    case .dim7th:
      return "Diminished 7th"
    case .minor7th:
      return "Minor 7th"
    case .major7th:
      return "Major 7th"
    }
  }

/// partly spelled-out degree names  
  var name: String {
    switch self {
    case .root:
      return "Root"
    case .minor9th:
      return "♭9"
    case .major9th:
      return "Maj9"
    case .sharp9th:
      return "♯9"
    case .minor3rd:
      return "Min3"
    case .major3rd:
      return "Maj3"
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
      return "Min6"
    case .major6th:
      return "Maj6"
    case .dim7th:
      return "˚7"
    case .minor7th:
      return "♭7"
    case .major7th:
      return "Maj7"
    }
  }

/// concise names (3 characters or less)
  var numeric: String {
      switch self {
      case .root:
        return "1"
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
        return "4"
      case .sharp4th:
        return "♯11"
      case .dim5th:
        return "♭5"
      case .perfect5th:
        return "5"
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
