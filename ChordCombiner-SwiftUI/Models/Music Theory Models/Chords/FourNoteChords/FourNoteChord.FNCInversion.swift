//
//  FourNoteChord.FNCInversion.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension FourNoteChord {
  enum FNCInversion: String, ChordInversion, CaseIterable, Codable {
    case root, first, second, third
    
    var name: (short: String, long: String) {
      switch self {
      case .root:
        return (short: "Root pos.", long: "root position")
      case .first:
        return (short: "1st inv.", long: "1st inversion")
      case .second:
        return (short: "2nd inv.", long: "2nd inversion")
      case .third:
        return (short: "3rd inv.", long: "3rd inversion")
      }
    }
    
    var num: FNCInversion {
      return self
    }
  }
}
