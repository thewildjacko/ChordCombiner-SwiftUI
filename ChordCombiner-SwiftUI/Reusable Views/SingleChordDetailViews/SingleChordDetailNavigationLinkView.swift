//
//  SingleChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct SingleChordDetailNavigationLinkView: View {
  var chord: Chord?
  var color: Color
  
  @ViewBuilder
  var body: some View {
    if let chord = chord {
      NavigationLink(
        destination:
          SingleChordDetailView(
            chord: chord, keyboard:
              Keyboard(
                baseWidth: 351,
                initialKeyType: .C,
                startingOctave: 4,
                octaves: 2,
                chord: chord,
                color: color
              )
          )
      ) {
        InfoLinkImageView()
      }
    }
  }
}

#Preview {
  SingleChordDetailNavigationLinkView(
    chord: Chord(.c, .ma7),
    color: .lowerChordHighlight
  )
}

