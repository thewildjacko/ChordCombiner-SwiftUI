//
//  SingleChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/23/24.
//

import SwiftUI

struct SingleChordKeyboardView: View {
  var text: String
  @Binding var chord: Chord
  @Binding var keyboard: Keyboard
  var color: Color
  
    
  var body: some View {
    VStack(spacing: 20) {
      ChordMenu(
        text: text,
        chord: $chord,
        keyboard: $keyboard)
    }
  }
}

#Preview {
  SingleChordKeyboardView(
    text: "Select Chord:",
    chord: Binding.constant(Chord(.c, .ma)),
    keyboard: Binding.constant(Keyboard(geoWidth: 187, initialKey: .C,  startingOctave: 4, octaves: 2)),
    color: .upperChordHighlight)
  
}
