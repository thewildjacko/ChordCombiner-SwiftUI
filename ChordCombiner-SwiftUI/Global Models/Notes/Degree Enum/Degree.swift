//
//  Degree.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

enum Degree: CaseIterable, Codable {
  case root
  case minor2nd
  case major2nd
  case sharp2nd
  case minor3rd
  case major3rd
  case flat4th
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
  case minor9th
  case major9th
  case sharp9th
  case minor10th
  case major10th
  case flat11th
  case perfect11th
  case sharp11th
  case diminished12th
  case perfect12th
  case sharp12th
  case flat13th
  case major13th
  case diminished14th
  case minor14th
  case major14th
  case perfect15th
}

extension Degree {
  var inversion: Degree {
    switch self {
    case .root:
        .root
    case .minor2nd:
        .major7th
    case .major2nd:
        .minor7th
    case .sharp2nd:
        .diminished7th
    case .minor3rd:
        .major6th
    case .major3rd:
        .minor6th
    case .flat4th:
        .sharp5th
    case .perfect4th:
        .perfect5th
    case .sharp4th:
        .diminished5th
    case .diminished5th:
        .sharp4th
    case .perfect5th:
        .perfect4th
    case .sharp5th:
        .flat4th
    case .minor6th:
        .major3rd
    case .major6th:
        .minor3rd
    case .diminished7th:
        .sharp2nd
    case .minor7th:
        .major2nd
    case .major7th:
        .minor2nd
    case .octave:
        .octave
    case .minor9th:
        .major7th
    case .major9th:
        .minor7th
    case .sharp9th:
        .diminished7th
    case .minor10th:
        .major6th
    case .major10th:
        .minor6th
    case .flat11th:
        .sharp5th
    case .perfect11th:
        .perfect5th
    case .sharp11th:
        .diminished5th
    case .diminished12th:
        .sharp4th
    case .perfect12th:
        .perfect4th
    case .sharp12th:
        .flat4th
    case .flat13th:
        .major3rd
    case .major13th:
        .minor3rd
    case .diminished14th:
        .sharp2nd
    case .minor14th:
        .major2nd
    case .major14th:
        .minor2nd
    case .perfect15th:
        .root
    }
  }
}

extension Degree {
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
    case .major3rd, .flat4th:
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
    case .minor9th:
      13
    case .major9th:
      14
    case .sharp9th, .minor10th:
      15
    case .major10th, .flat11th:
      16
    case .perfect11th:
      17
    case .sharp11th, .diminished12th:
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
    case .minor2nd, .minor9th:
      return .one
    case .major2nd, .major9th:
      return .two
    case .sharp2nd, .minor3rd, .sharp9th, .minor10th:
      return .three
    case .major3rd, .major10th, .flat4th, .flat11th:
      return .four
    case .perfect4th, .perfect11th:
      return .five
    case .sharp4th, .sharp11th:
      return .six
    case .diminished5th, .diminished12th:
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

extension Degree {
  var tensionScore: Double {
    // root 0
    // P5 0.05
    // P4 0.1
    // maj 3rd 0.15
    // min 3rd .2
    // maj 6th .25
    // min 6th .30
    // min 7th / maj 9th 0.4
    // major 7ths - +0.5
    // half steps - +3.0
    // whole steps +2
    // tritones +4.5
    // minor 9th - against root - +4
    // minor 9th - against other degree - +5
    // multiple half steps - +6 or more

    return switch self {
    case .root, .octave, .perfect15th:
      0
    case .minor2nd:
      3.0
    case .major2nd:
      2.00
    case .minor3rd, .minor10th, .sharp2nd, .sharp9th:
      0.20
    case .major3rd, .major10th, .flat4th, .flat11th:
      0.15
    case .perfect4th, .perfect11th:
      0.10
    case .sharp4th, .sharp11th, .diminished5th, .diminished12th:
      3.5
    case .perfect5th, .perfect12th:
      0.05
    case .sharp5th, .minor6th, .sharp12th, .flat13th:
      0.30
    case .major6th, .major13th, .diminished7th, .diminished14th:
      0.25
    case .minor7th, .minor14th, .major9th:
      0.40
    case .major7th, .major14th:
      0.50
    case .minor9th:
      4.0
    }

  }
}
