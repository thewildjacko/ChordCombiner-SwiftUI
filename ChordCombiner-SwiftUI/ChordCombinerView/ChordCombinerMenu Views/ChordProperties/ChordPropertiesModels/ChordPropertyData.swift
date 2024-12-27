//
//  ChordPropertyData.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/24/24.
//

import Foundation

struct ChordPropertyData: Encodable {
  var lowerChordProperties: ChordProperties
  var upperChordProperties: ChordProperties
  var initial: Bool = true
  var width: CGFloat = 351

  enum CodingKeys: String, CodingKey {
     case lowerChordProperties, upperChordProperties, initial, width
   }

  enum PropertiesKeys: CodingKey {
    case letter, accidental, chordType
  }

   func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)

     try container.encode(lowerChordProperties, forKey: .lowerChordProperties)
     try container.encode(upperChordProperties, forKey: .upperChordProperties)
     try container.encode(initial, forKey: .initial)
     try container.encode(width, forKey: .width)

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
    initial = try container.decode(Bool.self, forKey: .initial)
    width = try container.decode(CGFloat.self, forKey: .width)

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
