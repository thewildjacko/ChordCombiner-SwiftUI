//
//  All_C_Triads.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// Enum to test all cases of an upper structure triad in a single key against the lower chord.
enum All_C_Triads: String, CaseIterable {
  case ma, mi, aug, dim, sus4, sus2
  
  var chord: Triad {
    switch self {
    case .ma:
      return Triad(.c, .ma)
    case .mi:
      return Triad(.c, .mi)
    case .aug:
      return Triad(.c, .aug)
    case .dim:
      return Triad(.c, .dim)
    case .sus4:
      return Triad(.c, .sus4)
    case .sus2:
      return Triad(.c, .sus2)
    }
  }
}
