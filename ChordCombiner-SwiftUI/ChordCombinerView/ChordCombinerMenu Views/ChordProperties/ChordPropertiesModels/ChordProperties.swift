//
//  ChordProperties.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/22/24.
//

import SwiftUI

typealias ChordPropertyType = ChordProperties.ChordPropertyType

struct ChordProperties: Equatable, Identifiable {
  static let initial: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil)

  enum ChordPropertyType {
    case letter, accidental, chordType
  }

  var id: UUID = UUID()
  var letter: Letter?
  var accidental: RootAccidental?
  var chordType: ChordType?

  var propertiesAreSet: Bool {
    return letter != nil && accidental != nil && chordType != nil
  }

  init(letter: Letter? = nil, accidental: RootAccidental? = nil, chordType: ChordType? = nil) {
    self.letter = letter
    self.accidental = accidental
    self.chordType = chordType
  }
}

extension ChordProperties: Encodable {
  enum CodingKeys: String, CodingKey {
    case letter, accidental, chordType
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(letter, forKey: .letter)
    try container.encode(accidental, forKey: .accidental)
    try container.encode(chordType, forKey: .chordType)
  }
}

extension ChordProperties: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.letter = try container.decodeIfPresent(Letter.self, forKey: .letter)
    self.accidental = try container.decodeIfPresent(RootAccidental.self, forKey: .accidental)
    self.chordType = try container.decodeIfPresent(ChordType.self, forKey: .chordType)
  }
}
