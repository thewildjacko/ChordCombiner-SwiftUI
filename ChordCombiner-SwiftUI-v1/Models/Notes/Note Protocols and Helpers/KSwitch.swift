//
//  KSwitch.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// selects flat or sharp version of KeyName based on enharm
struct KeySwitch {
  var enharm: Enharmonic
  func pickKey(_ flatKey: KeyName, _ sharpKey: KeyName) -> KeyName {
    return enharm == .flat ? flatKey : sharpKey
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
