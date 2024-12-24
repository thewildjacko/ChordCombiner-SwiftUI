//
//  ChordDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/10/24.
//

import SwiftUI

struct ChordDisplayView: View {
  let chord: Chord
  let keyboardDisplay: Bool
  
  @ViewBuilder
  var body: some View {
    if keyboardDisplay {
      KeyboardDisplayView(
        chord: chord,
        keyboard:
          Keyboard(
            baseWidth: 250,
            initialKeyType: .C,
            startingOctave: 4,
            octaves: 3,
            glowColor: .clear,
            glowRadius: 0,
            chord: chord,
            color: .lowerChordHighlight
          )
      )
    } else {
      Text(chord.preciseName)
        .roundRectTagView(
          font: .title2,
          horizontalPadding: 8,
          verticalPadding: 5,
          cornerRadius: 12
        )
    }
  }
}

#Preview {
  ChordDisplayView(chord: Chord(.c, .ma), keyboardDisplay: true)
}
