//
//  SingleChordKeyboardTitleSelector.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/19/24.
//

import SwiftUI

struct SingleChordKeyboardTitleSelector {
  let chord: Chord?

  var chordTitle: String {
    let chordPrompt = "Please select a chord"

    guard let chord = chord else {
        return chordPrompt
      }

    return chord.commonName
  }

  var chordSymbolCaptionText: String {
    guard let chord = chord else { return "" }

    return "(\(chord.preciseName))"
  }
}
