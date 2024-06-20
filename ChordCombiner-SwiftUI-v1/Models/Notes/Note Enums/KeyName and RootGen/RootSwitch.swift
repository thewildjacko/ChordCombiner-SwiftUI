//
//  RootSwitch.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// selects flat or sharp version of RootGen based on enharm
struct RootSwitch {
  var enharm: Enharmonic
  func pickRoot(_ flatKey: KeyName, _ sharpKey: KeyName) -> RootGen {
    return enharm == .flat ? RootGen(flatKey) : RootGen(sharpKey)
  }
}
