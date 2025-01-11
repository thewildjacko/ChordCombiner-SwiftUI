//
//  ComponentChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct ComponentChordsView: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()
  var isDualChordDetailView: Bool = true

  @ViewBuilder
  var body: some View {
    if isDualChordDetailView {
      Section(header: Text("Component Chords")) {
        SingleChordDetailNavigationView(
          keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
          chord: chordCombinerViewModel.lowerChord,
          color: .lowerChordHighlight,
          detailTitle: "Lower Chord",
          labelType: .detailRow)

        SingleChordDetailNavigationView(
          keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
          chord: chordCombinerViewModel.upperChord,
          color: .upperChordHighlight,
          detailTitle: "Upper Chord",
          labelType: .detailRow)
      }
    }
  }
}
