//
//  ArrayExtensions+.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import SwiftUI

extension Array where Element == Key {
  mutating func highlightIfSelected(pitches: [Int], color: Color) {
    for key in self {
      if let index = pitches.firstIndex(where: { $0 == key.pitch }) {
        self[index].highlight(color: color)
      }
    }
  }
}
