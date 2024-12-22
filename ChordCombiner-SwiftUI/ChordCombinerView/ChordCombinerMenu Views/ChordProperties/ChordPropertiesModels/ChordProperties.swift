//
//  ChordProperties.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/22/24.
//

import SwiftUI

struct ChordProperties: Equatable, Identifiable {
  static let initial: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil)

  enum ChordPropertyChanged {
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

struct ChordPropertyData: Encodable {
  var lowerChordProperties: ChordProperties
  var upperChordProperties: ChordProperties

  enum CodingKeys: String, CodingKey {
     case lowerChordProperties, upperChordProperties
   }

  enum PropertiesKeys: CodingKey {
    case letter, accidental, chordType
  }

   func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)

     try container.encode(lowerChordProperties, forKey: .lowerChordProperties)
     try container.encode(upperChordProperties, forKey: .upperChordProperties)

     var lowerChordPropertiesContainer = container.nestedContainer(
      keyedBy: PropertiesKeys.self,
      forKey: .lowerChordProperties)

     try lowerChordPropertiesContainer.encode(lowerChordProperties.letter, forKey: .letter)
     try lowerChordPropertiesContainer.encode(lowerChordProperties.accidental, forKey: .accidental)
     try lowerChordPropertiesContainer.encode(lowerChordProperties.chordType, forKey: .chordType)

     var upperChordPropertiesContainer = container.nestedContainer(
      keyedBy: PropertiesKeys.self,
      forKey: .upperChordProperties)

     try upperChordPropertiesContainer.encode(upperChordProperties.letter, forKey: .letter)
     try upperChordPropertiesContainer.encode(upperChordProperties.accidental, forKey: .accidental)
     try upperChordPropertiesContainer.encode(upperChordProperties.chordType, forKey: .chordType)
   }
 }

extension ChordPropertyData: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    lowerChordProperties = try container.decode(ChordProperties.self, forKey: .lowerChordProperties)
    upperChordProperties = try container.decode(ChordProperties.self, forKey: .upperChordProperties)

    let lowerChordPropertiesContainer = try container.nestedContainer(
      keyedBy: PropertiesKeys.self,
      forKey: .lowerChordProperties)
    lowerChordProperties.letter = try lowerChordPropertiesContainer.decodeIfPresent(
      Letter.self,
      forKey: .letter)
    lowerChordProperties.accidental = try lowerChordPropertiesContainer.decodeIfPresent(
      RootAccidental.self,
      forKey: .accidental)
    lowerChordProperties.chordType = try lowerChordPropertiesContainer.decodeIfPresent(
      ChordType.self,
      forKey: .chordType)

    let upperChordPropertiesContainer = try container.nestedContainer(
      keyedBy: PropertiesKeys.self,
      forKey: .upperChordProperties)
    upperChordProperties.letter = try upperChordPropertiesContainer.decodeIfPresent(
      Letter.self,
      forKey: .letter)
    upperChordProperties.accidental = try upperChordPropertiesContainer.decodeIfPresent(
      RootAccidental.self,
      forKey: .accidental)
    upperChordProperties.chordType = try upperChordPropertiesContainer.decodeIfPresent(
      ChordType.self,
      forKey: .chordType)
  }
}
