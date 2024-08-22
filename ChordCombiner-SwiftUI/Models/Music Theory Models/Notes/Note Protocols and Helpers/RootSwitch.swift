//
//  RootSwitch.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// selects flat or sharp version of RootGen based on enharm
struct RootSwitch: Codable {
  var enharm: Enharmonic
  func pickRoot(_ flatKey: KeyName, _ sharpKey: KeyName, _ blackKeyFlats: KeyName, _ blackKeySharps: KeyName) -> RootGen {
    switch enharm {
    case .flat:
      return RootGen(flatKey)
    case .sharp:
      return RootGen(sharpKey)
    case .blackKeyFlats:
      return RootGen(blackKeyFlats)
    case .blackKeySharps:
      return RootGen(blackKeySharps)
    }
  }
}
