//
//  ScaleFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation
import Algorithms

struct ScaleFactory {
  static var allScales: [Scale] {
    var scales: [Scale] = []

    for (root, scaleType) in product(RootKeyNote.allCases, ScaleType.allCases) {
      scales.append(Scale(root, scaleType))
    }

    return scales
  }
}
