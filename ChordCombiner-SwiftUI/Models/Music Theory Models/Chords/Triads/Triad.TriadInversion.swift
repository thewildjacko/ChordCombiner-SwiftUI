//
//  Triad.TriadInversion.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension Triad {
  enum TriadInversion: String, ChordInversion, CaseIterable, Codable {
    case root, first, second
    
    var name: (short: String, long: String) {
      switch self {
      case .root:
        return (short: "Root pos.", long: "root position")
      case .first:
        return (short: "1st inv.", long: "1st inversion")
      case .second:
        return (short: "2nd inv.", long: "2nd inversion")
      }
    }
    
    var num: FNCInversion {
      switch self {
      case .root:
        return .root
      case .first:
        return .first
      case .second:
        return .third
      }
    }
    
    init(_ num: FNCInversion) {
      switch num {
      case .root, .third:
        self = .root
      case .first:
        self = .first
      case .second:
        self = .second
      }
    }
  }
}

let inv = TriadInversion(FNCInversion(rawValue: "root")!)
