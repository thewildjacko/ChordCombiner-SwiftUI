//
//  FourNoteChord.FNCType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension FourNoteChord {
  enum FNCType: String, QualProtocol, CaseIterable, Identifiable, Codable {
    var id: Self {
      return self
    }
    
    case ma7, dom7 = "7", mi7, mi7_b5 = "mi7(♭5)", dim7 = "˚7", ma6 = "6"
    
    var quality: Suffix {
      switch self {
      case .dom7:
        return .sev
      case .ma7:
        return .ma7
      case .mi7:
        return .mi7
      case .mi7_b5:
        return .mi7_b5
      case .dim7:
        return .dim7
      case .ma6:
        return .ma6
      }
    }
    
    var name: String {
      return qualStr
    }
    
    static var qualities: [String] {
      return FNCType.allCases.map {$0.rawValue}
    }
  }
}
