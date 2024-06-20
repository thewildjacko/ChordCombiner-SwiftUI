//
//  Scale_Enums.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// Interval enum for describing a scale's intervallic formula
enum ScaleInterval: String {
  case halfStep = "H"
  case wholeStep = "W"
  case min3rd = "m3"
}

/// not sure why this is here, so far haven't used it...
enum ScaleType {
  case major, melodicMinor, harmonicMinor, harmonicMajor, diminished, halfWholeDim_b13, hexaSh9Sh11, chromatic
}
