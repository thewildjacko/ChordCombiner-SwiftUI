//
//  ChordData.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/23/24.
//

import Foundation

struct ChordData: Identifiable, Encodable, Equatable {
  var id = UUID()
  
  var lowerChordData: LowerChordData
  var ustData: USTData
  
  enum CodingKeys: String, CodingKey {
    case lowerChordData, ustData
  }
  
  enum LowerChordDataKeys: CodingKey {
    case letter, accidental, type, inversion
  }
  
  enum ustDataKeys: CodingKey {
    case letter, accidental, type, inversion
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    var lowerChordDataContainer = container.nestedContainer(keyedBy: LowerChordDataKeys.self, forKey: .lowerChordData)
    
    var ustDataContainer = container.nestedContainer(keyedBy: ustDataKeys.self, forKey: .ustData)
    
    try lowerChordDataContainer.encode(lowerChordData.letter, forKey: .letter)
    try lowerChordDataContainer.encode(lowerChordData.accidental, forKey: .accidental)
    try lowerChordDataContainer.encode(lowerChordData.type, forKey: .type)
    try lowerChordDataContainer.encode(lowerChordData.inversion, forKey: .inversion)
    
    try ustDataContainer.encode(ustData.letter, forKey: .letter)
    try ustDataContainer.encode(ustData.accidental, forKey: .accidental)
    try ustDataContainer.encode(ustData.type, forKey: .type)
    try ustDataContainer.encode(ustData.inversion, forKey: .inversion)
  }
}

extension ChordData: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let lowerChordDataContainer = try container.nestedContainer(keyedBy: LowerChordDataKeys.self, forKey: .lowerChordData)
    
    let ustDataContainer = try container.nestedContainer(keyedBy: ustDataKeys.self, forKey: .ustData)

    lowerChordData = try container.decode(LowerChordData.self, forKey: .lowerChordData)
    lowerChordData.letter = try lowerChordDataContainer.decode(Letter.self, forKey: .letter)
    lowerChordData.accidental = try lowerChordDataContainer.decode(RootAcc.self, forKey: .accidental)
    lowerChordData.type = try lowerChordDataContainer.decode(FNCType.self, forKey: .type)
    lowerChordData.inversion = try lowerChordDataContainer.decode(FNCInversion.self, forKey: .inversion)
    
    ustData = try container.decode(USTData.self, forKey: .ustData)
    ustData.letter = try ustDataContainer.decode(Letter.self, forKey: .letter)
    ustData.accidental = try ustDataContainer.decode(RootAcc.self, forKey: .accidental)
    ustData.type = try ustDataContainer.decode(TriadType.self, forKey: .type)
    ustData.inversion = try ustDataContainer.decode(TriadInversion.self, forKey: .inversion)
  }
}
