  //
//  DegName.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// long, medium and short names for scale/chord degrees
enum DegName {
  /// long form names
  enum Long: String {
    case root = "root"
    case min9 = "♭9"
    case maj2 = "major 9th"
    case sh_9 = "♯9"
    case min3 =  "minor 3rd"
    case maj3 = "major 3rd"
    case p4 = "perfect 4th"
    case sh_4 = "♯11"
    case dim5 = "♭5"
    case p5 = "perfect 5th"
    case sh_5 = "♯5"
    case min6 = "minor 6th"
    case maj6 = "major 6th"
    case dim7 = "diminished 7th"
    case min7 = "minor 7th"
    case maj7 = "major 7th"
    
    /// initialize with a short DegName
    init(_ name: DegName.Short) {
      switch name {
      case .rt:
        self = .root
      case .mi9:
        self = .min9
      case .ma2:
        self = .maj2
      case .sh9:
        self = .sh_9
      case .mi3:
        self = .min3
      case .ma3:
        self = .maj3
      case .p4:
        self = .p4
      case .sh4:
        self = .sh_4
      case .d5:
        self = .dim5
      case .p5:
        self = .p5
      case .sh5:
        self = .sh_5
      case .mi6:
        self = .min6
      case .ma6:
        self = .maj6
      case .d7:
        self = .dim7
      case .mi7:
        self = .min7
      case .ma7:
        self = .maj7
      }
    }
  }
  /// partly spelled-out degree names
  enum Name: String, Codable {
    case root = "root"
    case min9 = "♭9"
    case maj2 = "maj9"
    case sh_9 = "♯9"
    case min3 =  "min3"
    case maj3 = "maj3"
    case p4 = "P4"
    case sh_4 = "♯11"
    case dim5 = "♭5"
    case p5 = "P5"
    case sh_5 = "♯5"
    case min6 = "min6"
    case maj6 = "maj6"
    case dim7 = "˚7"
    case min7 = "♭7"
    case maj7 = "maj7"
    
    /// initialize with a short DegName
    init(_ name: DegName.Short) {
      switch name {
      case .rt:
        self = .root
      case .mi9:
        self = .min9
      case .ma2:
        self = .maj2
      case .sh9:
        self = .sh_9
      case .mi3:
        self = .min3
      case .ma3:
        self = .maj3
      case .p4:
        self = .p4
      case .sh4:
        self = .sh_4
      case .d5:
        self = .dim5
      case .p5:
        self = .p5
      case .sh5:
        self = .sh_5
      case .mi6:
        self = .min6
      case .ma6:
        self = .maj6
      case .d7:
        self = .dim7
      case .mi7:
        self = .min7
      case .ma7:
        self = .maj7
      }
    }
  }
  /// concise names (3 characters or less)
  enum Short: String, Codable {
    case rt = "R"
    case mi9 = "♭9" // b9
    case ma2 = "9"
    case sh9 = "♯9" // #9
    case mi3 =  "♭3" // b3
    case ma3 = "3"
    case p4 = "P4"
    case sh4 = "♯11" // #11
    case d5 = "♭5" // b5
    case p5 = "P5"
    case sh5 = "♯5" // #5
    case mi6 = "♭13" // b13
    case ma6 = "13"
    case d7 = "˚7"
    case mi7 = "♭7" // b7
    case ma7 = "7"
    
  }
  /// enum to initialize DegNames
  enum Deg: Int, Codable {
    case root = 0, min9, maj2, sh_9, min3, maj3, p4, sh_4, dim5, p5, sh_5, min6, maj6, dim7, min7, maj7
  }
}
