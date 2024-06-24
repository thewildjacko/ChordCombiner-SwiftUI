//
//  ChordData.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/23/24.
//

import Foundation

struct ChordData: Identifiable, Encodable, Equatable {
  var id = UUID()
  
  var lowerChord: FourNoteChord
  var triad: Triad
  
  enum CodingKeys: String, CodingKey {
    case triad, lowerChord
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
        
    try container.encode(triad, forKey: .triad)
    try container.encode(lowerChord, forKey: .lowerChord)
  }
}

extension ChordData: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    triad = try container.decode(Triad.self, forKey: .triad)
    lowerChord = try container.decode(FourNoteChord.self, forKey: .lowerChord)
  }
}
