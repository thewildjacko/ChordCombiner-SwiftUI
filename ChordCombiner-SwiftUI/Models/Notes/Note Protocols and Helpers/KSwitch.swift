//
//  KSwitch.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// selects flat or sharp version of KeyName based on enharm
struct KeySwitch: Codable {
  var enharm: Enharmonic
  func pickKey(_ flatKey: KeyName, _ sharpKey: KeyName, _ blackKeyFlats: KeyName, _ blackKeySharps: KeyName) -> KeyName {
    switch enharm {
    case .flat:
      return flatKey
    case .sharp:
      return sharpKey
    case .blackKeyFlats:
      return blackKeyFlats
    case .blackKeySharps:
      return blackKeySharps
    }
  }
}

/// a protocol to allow notes to adopt `Enharmonic` and `KeySwitch` variables
protocol KSwitch {
  var enharm: Enharmonic { get set }
  var ks: KeySwitch { get }
}

extension KSwitch {
  /// returns a `KeySwitch` set to sharp or flat
  var ks: KeySwitch {
    return KeySwitch(enharm: enharm)
  }
}
