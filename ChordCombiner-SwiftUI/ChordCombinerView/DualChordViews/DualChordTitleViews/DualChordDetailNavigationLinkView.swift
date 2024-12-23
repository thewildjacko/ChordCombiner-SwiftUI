//
// DualChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordDetailNavigationLinkView: View {
  let chordCombinerViewModel = ChordCombinerViewModel.singleton()
  let showCaption: Bool

  var chord: Chord? {
    if let lowerChord = chordCombinerViewModel.lowerChord {
      return lowerChord
    } else if let upperChord = chordCombinerViewModel.upperChord {
      return upperChord
    } else {
      return nil
    }
  }

  var color: Color {
    chordCombinerViewModel.lowerChord != nil ?
      .lowerChordHighlight :
      .upperChordHighlight
  }

  @ViewBuilder
  var body: some View {
    if chordCombinerViewModel.resultChord != nil {
      NavigationLink(
        destination: DualChordDetailView(
          showCaption: showCaption)) {
            InfoLinkImageView()
          }
    } else {
      SingleChordDetailNavigationView(
        keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
        chord: chord,
        color: color)
    }
  }
}

#Preview {
  DualChordDetailNavigationLinkView(showCaption: true)
}
