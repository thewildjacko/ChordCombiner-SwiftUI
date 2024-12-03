//
// DualChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordDetailNavigationLinkView: View {
  let chordCombinerViewModel: ChordCombinerViewModel
  let showCaption: Bool
  
  // FIXME: this will only show lowerChord
  var chord: Chord? {
    if let lowerChord = chordCombinerViewModel.lowerChord {
      return lowerChord
    } else if let upperChord = chordCombinerViewModel.upperChord {
      return upperChord
    } else {
      return nil
    }
  }
  
  // FIXME: this will only return lowerChordHighlight color
  var color: Color { chordCombinerViewModel.lowerChord != nil ? .lowerChordHighlight : .upperChordHighlight }
  
  @ViewBuilder
  var body: some View {
    if chordCombinerViewModel.resultChord != nil {
      NavigationLink(destination: DualChordDetailView(chordCombinerViewModel: chordCombinerViewModel, showCaption: showCaption)) { InfoLinkImageView() }
    } else {
      // FIXME: this should be a DualChordDetailView or DualChordDetailSplitView (create this)
      // TODO: create DualChordDetailSplitView
      SingleChordDetailNavigationLinkView(chord: chord, color: color)
    }
  }
}

#Preview {
  DualChordDetailNavigationLinkView(
    chordCombinerViewModel: ChordCombinerViewModel(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    ),
    showCaption: true
  )
}

