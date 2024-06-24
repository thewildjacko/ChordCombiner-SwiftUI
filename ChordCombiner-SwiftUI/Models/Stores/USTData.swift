//
//  USTData.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/21/24.
//

import Foundation

struct USTData: Identifiable, Encodable {
  var id = UUID()
  
  var letter: Letter
  var accidental: RootAcc
  var type: TriadType
  var inversion: TriadInversion
  
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

extension USTData: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    letter = try container.decode(Letter.self, forKey: .letter)
    accidental = try container.decode(RootAcc.self, forKey: .accidental)
    type = try container.decode(TriadType.self, forKey: .type)
    inversion = try container.decode(TriadInversion.self, forKey: .inversion)
  }
}

extension USTData: Equatable {
  static func == (lhs: USTData, rhs: USTData) -> Bool {
    return lhs.letter == rhs.letter && lhs.accidental == rhs.accidental && lhs.inversion == rhs.inversion && lhs.type == rhs.type
  }
}
