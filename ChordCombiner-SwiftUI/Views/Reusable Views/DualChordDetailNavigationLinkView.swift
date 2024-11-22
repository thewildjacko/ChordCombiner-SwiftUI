//
// DualChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordDetailNavigationLinkView: View {
  let multiChord: MultiChord
  
  // FIXME: this will only show lowerChord
  var chord: Chord? {
    if let lowerChord = multiChord.lowerChord {
      return lowerChord
    } else if let upperChord = multiChord.upperChord {
      return upperChord
    } else {
      return nil
    }
  }
  
  // FIXME: this will only return lowerChordHighlight color
  var color: Color { multiChord.lowerChord != nil ? .lowerChordHighlight : .upperChordHighlight }
  
  @ViewBuilder
  var body: some View {
    if multiChord.resultChord != nil {
      NavigationLink(destination: DualChordDetailView(multiChord: multiChord)) { InfoLinkImageView() }
    } else {
      // FIXME: this should be a DualChordDetailView or DualChordDetailSplitView (create this)
      // TODO: create DualChordDetailSplitView
      SingleChordDetailNavigationLinkView(chord: chord, color: color)
    }
  }
}

#Preview {
  DualChordDetailNavigationLinkView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    )
  )
}

