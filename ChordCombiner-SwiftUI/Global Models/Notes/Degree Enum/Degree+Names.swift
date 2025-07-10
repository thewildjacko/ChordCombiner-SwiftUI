//
//  Degree+Names.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import Foundation

// long, medium and numeric names for scale/chord degrees
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
    case .flat4th:
      return "diminished 4th"
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
    case .minor9th:
      return "minor 9th"
    case .major9th:
      return "Major 9th"
    case .sharp9th:
      return "Augmented 9th"
    case .minor10th:
      return "minor 10th"
    case .major10th:
      return "Major 10th"
    case .flat11th:
      return "diminished 11th"
    case .perfect11th:
      return "Perfect 11th"
    case .sharp11th:
      return "Augmented 11th"
    case .diminished12th:
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
    case .flat4th:
      return "dim 4th"
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
    case .minor9th:
      return "min 9th"
    case .major9th:
      return "Maj 9th"
    case .sharp9th:
      return "Aug 9th"
    case .minor10th:
      return "min 10th"
    case .major10th:
      return "Major 10th"
    case .flat11th:
      return "dim 11th"
    case .perfect11th:
      return "11th"
    case .sharp11th:
      return "Aug 11th"
    case .diminished12th:
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
  var short: String {
    switch self {
    case .root:
      return "R"
    case .minor2nd:
      return "m2"
    case .major2nd:
      return "M2"
    case .sharp2nd:
      return "A2"
    case .minor3rd:
      return "m3"
    case .major3rd:
      return "M3"
    case .flat4th:
      return "d4"
    case .perfect4th:
      return "P4"
    case .sharp4th:
      return "A4"
    case .diminished5th:
      return "d5"
    case .perfect5th:
      return "P5"
    case .sharp5th:
      return "A5"
    case .minor6th:
      return "m6"
    case .major6th:
      return "M6"
    case .diminished7th:
      return "d7"
    case .minor7th:
      return "m7"
    case .major7th:
      return "M7"
    case .octave:
      return "P8"
    case .minor9th:
      return "m9"
    case .major9th:
      return "M9"
    case .sharp9th:
      return "A9"
    case .minor10th:
      return "m1th"
    case .major10th:
      return "M10"
    case .flat11th:
      return "d11"
    case .perfect11th:
      return "P11"
    case .sharp11th:
      return "A11"
    case .diminished12th:
      return "d12"
    case .perfect12th:
      return "P12"
    case .sharp12th:
      return "A12"
    case .flat13th:
      return "m13"
    case .major13th:
      return "M13"
    case .diminished14th:
      return "d14t"
    case .minor14th:
      return "m14"
    case .major14th:
      return "M14"
    case .perfect15th:
      return "P15"
    }
  }

  /// numeric names
  var numeric: String {
    switch self {
    case .root:
      return "1"
    case .minor2nd:
      return "♭2"
    case .major2nd:
      return "2"
    case .sharp2nd:
      return "♯2"
    case .minor3rd:
      return "♭3"
    case .major3rd:
      return "3"
    case .flat4th:
      return "♭4"
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
      return "1"
    case .minor9th:
      return "♭9"
    case .major9th:
      return "9"
    case .sharp9th:
      return "♯9"
    case .minor10th:
      return "♭3"
    case .major10th:
      return "3"
    case .flat11th:
      return "♭11"
    case .perfect11th:
      return "11"
    case .sharp11th:
      return "♯11"
    case .diminished12th:
      return "♭7"
    case .perfect12th:
      return "7"
    case .sharp12th:
      return "♯7"
    case .flat13th:
      return "♭13"
    case .major13th:
      return "13"
    case .diminished14th:
      return "˚7"
    case .minor14th:
      return "♭7"
    case .major14th:
      return "7"
    case .perfect15th:
      return "1"
    }
  }
}
