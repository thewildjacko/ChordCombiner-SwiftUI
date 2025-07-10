//
//  ScaleType+degreeTypeIDGroups.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/20/25.
//

import Foundation

extension ScaleType {
  var isMinorAdjacent: Bool { degreeTags.contains(.minor3rd) }
  var isMajorAdjacent: Bool { degreeTags.contains(.major3rd) }
  var isPentatonic: Bool { self.parentScaleType == .pentatonic }
}
