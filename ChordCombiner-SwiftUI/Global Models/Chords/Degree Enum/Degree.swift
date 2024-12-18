//
//  Degree.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// long, medium and numeric names for scale/chord degrees
enum Degree: CaseIterable, Codable {
  case root
  case minor2nd
  case major2nd
  case sharp2nd
  case minor3rd
  case major3rd
  case perfect4th
  case sharp4th
  case diminished5th
  case perfect5th
  case sharp5th
  case minor6th
  case major6th
  case diminished7th
  case minor7th
  case major7th
  case octave
  case flat9th
  case major9th
  case sharp9th
  case minor10th
  case major10th
  case perfect11th
  case sharp11th
  case flat12th
  case perfect12th
  case sharp12th
  case flat13th
  case major13th
  case diminished14th
  case minor14th
  case major14th
  case perfect15th
}

// MARK: Computed properties
extension Degree {
  /// long form names
  var long: String {
    switch self {
    case .root:
      return "Perfect Unison"
    case .minor2nd:
      return "minor 2nd"
    case .major2nd:
      return "Major 2nd"
    case .sharp2nd:
      return "Augmented 2nd"
    case .minor3rd:
      return "minor 3rd"
    case .major3rd:
      return "Major 3rd"
    case .perfect4th:
      return "Perfect 4th"
    case .sharp4th:
      return "Augmented 4th"
    case .diminished5th:
      return "diminished 5th"
    case .perfect5th:
      return "Perfect 5th"
    case .sharp5th:
      return "Augmented 5th"
    case .minor6th:
      return "minor 6th"
    case .major6th:
      return "Major 6th"
    case .diminished7th:
      return "diminished 7th"
    case .minor7th:
      return "minor 7th"
    case .major7th:
      return "Major 7th"
    case .octave:
      return "Perfect Octave"
    case .flat9th:
      return "minor 9th"
    case .major9th:
      return "Major 9th"
    case .sharp9th:
      return "Augmented 9th"
    case .minor10th:
      return "minor 10th"
    case .major10th:
      return "Major 10th"
    case .perfect11th:
      return "Perfect 11th"
    case .sharp11th:
      return "Augmented 11th"
    case .flat12th:
      return "diminished 12th"
    case .perfect12th:
      return "Perfect 12th"
    case .sharp12th:
      return "Augmented 12th"
    case .flat13th:
      return "minor 13th"
    case .major13th:
      return "Major 13th"
    case .diminished14th:
      return "Diminished 14th"
    case .minor14th:
      return "minor 14th"
    case .major14th:
      return "Major 14th"
    case .perfect15th:
      return "Perfect 15th"
    }
  }

  /// partly spelled-out degree names
  var name: String {
    switch self {
    case .root:
      return "Root"
    case .minor2nd:
      return "min 2nd"
    case .major2nd:
      return "Maj 2nd"
    case .sharp2nd:
      return "Aug 2nd"
    case .minor3rd:
      return "min 3rd"
    case .major3rd:
      return "Maj 3rd"
    case .perfect4th:
      return "4th"
    case .sharp4th:
      return "Aug 4th"
    case .diminished5th:
      return "dim 5th"
    case .perfect5th:
      return "5th"
    case .sharp5th:
      return "Aug 5th"
    case .minor6th:
      return "min 6th"
    case .major6th:
      return "Maj 6th"
    case .diminished7th:
      return "dim 7th"
    case .minor7th:
      return "min 7th"
    case .major7th:
      return "Maj 7th"
    case .octave:
      return "Octave"
    case .flat9th:
      return "min 9th"
    case .major9th:
      return "Maj 9th"
    case .sharp9th:
      return "Aug 9th"
    case .minor10th:
      return "min 10th"
    case .major10th:
      return "Major 10th"
    case .perfect11th:
      return "11th"
    case .sharp11th:
      return "Aug 11th"
    case .flat12th:
      return "dim 12th"
    case .perfect12th:
      return "12th"
    case .sharp12th:
      return "Aug 12th"
    case .flat13th:
      return "min 13th"
    case .major13th:
      return "Maj 13th"
    case .diminished14th:
      return "dim 14th"
    case .minor14th:
      return "min 14th"
    case .major14th:
      return "Maj 14th"
    case .perfect15th:
      return "15th"
    }
  }

  /// concise names (3 characters or less)
  var numeric: String {
    switch self {
    case .root:
      return "1"
    case .minor2nd:
      return "♭2"
    case .major2nd:
      return "♭2"
    case .sharp2nd:
      return "♯2"
    case .minor3rd:
      return "♭3"
    case .major3rd:
      return "3"
    case .perfect4th:
      return "4"
    case .sharp4th:
      return "♯4"
    case .diminished5th:
      return "♭5"
    case .perfect5th:
      return "5"
    case .sharp5th:
      return "♯5"
    case .minor6th:
      return "♭6"
    case .major6th:
      return "6"
    case .diminished7th:
      return "˚7"
    case .minor7th:
      return "♭7"
    case .major7th:
      return "7"
    case .octave:
      return "8"
    case .flat9th:
      return "♭9"
    case .major9th:
      return "9"
    case .sharp9th:
      return "♯9"
    case .minor10th:
      return "♭10"
    case .major10th:
      return "10"
    case .perfect11th:
      return "11"
    case .sharp11th:
      return "♯11"
    case .flat12th:
      return "♭12"
    case .perfect12th:
      return "12"
    case .sharp12th:
      return "♯12"
    case .flat13th:
      return "♭13"
    case .major13th:
      return "13"
    case .diminished14th:
      return "˚14"
    case .minor14th:
      return "♭14"
    case .major14th:
      return "14"
    case .perfect15th:
      return "15th"
    }
  }

  var size: Int {
    switch self {
    case .root:
      0
    case .minor2nd:
      1
    case .major2nd:
      2
    case .sharp2nd, .minor3rd:
      3
    case .major3rd:
      4
    case .perfect4th:
      5
    case .sharp4th, .diminished5th:
      6
    case .perfect5th:
      7
    case .sharp5th, .minor6th:
      8
    case .major6th, .diminished7th:
      9
    case .minor7th:
      10
    case .major7th:
      11
    case .octave:
      12
    case .flat9th:
      13
    case .major9th:
      14
    case .sharp9th, .minor10th:
      15
    case .major10th:
      16
    case .perfect11th:
      17
    case .sharp11th, .flat12th:
      18
    case .perfect12th:
      19
    case .sharp12th, .flat13th:
      20
    case .major13th, .diminished14th:
      21
    case .minor14th:
      22
    case .major14th:
      23
    case .perfect15th:
      24
    }
  }
}

extension Degree: GettableNoteNumber {
  /// noteNumber
  var noteNumber: NoteNumber {
    switch self {
    case .root, .octave, .perfect15th:
      return .zero
    case .minor2nd, .flat9th:
      return .one
    case .major2nd, .major9th:
      return .two
    case .sharp2nd, .minor3rd, .sharp9th, .minor10th:
      return .three
    case .major3rd, .major10th:
      return .four
    case .perfect4th, .perfect11th:
      return .five
    case .sharp4th, .sharp11th:
      return .six
    case .diminished5th, .flat12th:
      return .six
    case .perfect5th, .perfect12th:
      return .seven
    case .sharp5th, .sharp12th:
      return .eight
    case .minor6th, .flat13th:
      return .eight
    case .major6th, .major13th:
      return .nine
    case .diminished7th, .diminished14th:
      return .nine
    case .minor7th, .minor14th:
      return .ten
    case .major7th, .major14th:
      return .eleven
    }
  }
}
