//
//  KeyboardDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayView: View {
  var chord: Chord
  var keyboard: Keyboard
  
  var baseWidth: CGFloat = 150
  var initialKeyType: KeyType = .C
  var startingOctave: Int = 4
  var octaves: Int = 2
  var color: Color
  var glowColor: Color = .lowerChordHighlight
  var glowRadius: CGFloat = 5
    
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
        octaves: 3),
    color: .lowerChordHighlight)
}
