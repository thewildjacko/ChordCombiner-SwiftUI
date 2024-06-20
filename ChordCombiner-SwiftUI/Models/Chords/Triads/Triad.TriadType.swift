//
//  Triad.TriadType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension Triad {
  enum TriadType: String, QualProtocol, CaseIterable {
    case ma, mi, aug, dim, sus4, sus2
    
    var quality: Suffix {
      switch self {
      case .ma:
        return .ma
      case .mi:
        return .mi
      case .aug:
        return .aug
      case .dim:
        return .dim
      case .sus4:
        return .sus4
      case .sus2:
        return .sus2
      }
    }
    
    var name: String {
      switch self {
      case .ma, .mi, .aug, .sus4, .sus2:
        return qualStr
      case .dim:
        return "˚"
      }
    }
    
    var orderNum: Int {
      switch self {
      case .ma:
        return 0
      case .mi:
        return 1
      case .aug:
        return 2
      case .dim:
        return 3
      case .sus4:
        return 4
      case .sus2:
        return 5
      }
    }
    
    static var qualities: [String] {
      return TriadType.allCases.map {$0.rawValue}
    }
  }
  
}
