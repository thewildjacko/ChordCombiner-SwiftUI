//
//  ComponentChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct ComponentChordsView: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()

  var body: some View {
    Section(header: Text("Component Chords")) {
      SingleChordDetailNavigationView(
        chord: chordCombinerViewModel.lowerChord,
        color: .lowerChordHighlight,
        detailTitle: "Lower Chord",
        labelType: .detailRow)

      SingleChordDetailNavigationView(
        chord: chordCombinerViewModel.upperChord,
        color: .lowerChordHighlight,
        detailTitle: "Upper Chord",
        labelType: .detailRow)
    }
  }
}
