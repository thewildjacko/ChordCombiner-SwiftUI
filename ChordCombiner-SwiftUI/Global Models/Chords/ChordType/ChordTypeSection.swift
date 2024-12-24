//
//  ChordTypeSection.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/11/24.
//

import Foundation

struct ChordTypeSection {
  var id: Int
  var title: String
  var tagName: String
  var chordTypes: [ChordType]
}

extension ChordTypeSection: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(title)
    hasher.combine(tagName)
    hasher.combine(chordTypes)
  }
}
