//
//  KeyboardDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayView: View {
  let chord: Chord
  let keyboard: Keyboard
    
  var body: some View {
    VStack(alignment: .leading) {
      TitleView(text: chord.preciseName, font: .title2, weight: .heavy)
      keyboard
    }
  }
}

#Preview {
  KeyboardDisplayView(
    chord: Chord(.c, .ma),
    keyboard:
      Keyboard(
        baseWidth: 250,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 3
      )
  )
}
