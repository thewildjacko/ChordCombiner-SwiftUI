//
//  KeyboardDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayView: View {
  var chord: Chord
  @State var keyboard: Keyboard
  var color: Color
  
  var body: some View {
    VStack(alignment: .leading) {
      TitleView(text: chord.preciseName, font: .title2, weight: .heavy)
      
      keyboard
    }
    .onAppear {
      keyboard.highlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
    }
    .onChange(of: chord) { oldValue, newValue in
      keyboard.toggleHighlightKeysSingle(degs: oldValue.voicingCalculator.stackedPitches, color: color)
      keyboard.toggleHighlightKeysSingle(degs: newValue.voicingCalculator.stackedPitches, color: color)
    }
  }
}

#Preview {
  KeyboardDisplayView(
    chord: Chord(.c, .ma),
    keyboard:
      Keyboard(
      geoWidth: 250,
      initialKey: .C,
      startingOctave: 4,
      octaves: 3),
    color: .yellow)
}
