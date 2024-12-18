//
//  NoteEnum.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

protocol GettableNoteNumber {
  var noteNumber: NoteNumber { get }
}

/// enum assigns 0-11 for C-B
enum NoteNumber: Int, CaseIterable, CustomStringConvertible, Codable {
  case zero = 0, one, two, three, four, five, six, seven, eight, nine, ten, eleven

  var description: String {
    switch self {
    case .zero:
      return "_0"
    case .one:
      return "_1"
    case .two:
      return "_2"
    case .three:
      return "_3"
    case .four:
      return "_4"
    case .five:
      return "_5"
    case .six:
      return "_6"
    case .seven:
      return "_7"
    case .eight:
      return "_8"
    case .nine:
      return "_9"
    case .ten:
      return "_10"
    case .eleven:
      return "_11"
    }
  }

  init(_ number: Int) {
    let noteNumberMap: [Int: NoteNumber] = Dictionary(
      uniqueKeysWithValues: zip(Array(0...11), NoteNumber.allCases)
    )

      self = noteNumberMap[number] ?? .zero
  }

  func plusNoteNum(_ otherNoteNumber: NoteNumber) -> NoteNumber {
    NoteNumber((rawValue + otherNoteNumber.rawValue).degreeNumberInOctave)
  }

  func minusNoteNum(_ otherNoteNumber: NoteNumber) -> NoteNumber {
    NoteNumber((rawValue - otherNoteNumber.rawValue).degreeNumberInOctave)
  }
}
