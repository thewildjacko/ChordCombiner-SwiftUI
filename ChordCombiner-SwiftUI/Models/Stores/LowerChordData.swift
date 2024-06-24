//
//  LowerChordData.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/21/24.
//

import Foundation

struct LowerChordData: Identifiable, Encodable {
  var id = UUID()
  
  var letter: Letter
  var accidental: RootAcc
  var type: FNCType
  var inversion: FNCInversion
  
  enum CodingKeys: String, CodingKey {
    case letter, accidental, type, inversion
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(letter, forKey: .letter)
    try container.encode(accidental, forKey: .accidental)
    try container.encode(type, forKey: .type)
    try container.encode(inversion, forKey: .inversion)
  }
}

extension LowerChordData: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    letter = try container.decode(Letter.self, forKey: .letter)
    accidental = try container.decode(RootAcc.self, forKey: .accidental)
    type = try container.decode(FNCType.self, forKey: .type)
    inversion = try container.decode(FNCInversion.self, forKey: .inversion)
  }
}

extension LowerChordData: Equatable {
  static func == (lhs: LowerChordData, rhs: LowerChordData) -> Bool {
    return lhs.letter == rhs.letter && lhs.accidental == rhs.accidental && lhs.inversion == rhs.inversion && lhs.type == rhs.type
  }
}
