//
//  LowerChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct LowerChordKeyboardView: View {
  var text: String
  @Binding var multiChord: MultiChord
  @Binding var oldMultiChord: MultiChord
  
  @State var keyboard: Keyboard
  var color: Color
    
  var body: some View {
    VStack(spacing: 20) {
      ChordMenu(
        text: text,
        chord: $multiChord.lowerChord
      )
      keyboard
    }
    .onAppear(perform: {
      ChordHighlighter.highlightStacked(
        chord: &multiChord.lowerChord,
        oldChord: &oldMultiChord.lowerChord,
        keyboard: &keyboard,
        initial: true,
        color: color
      )
    })
    .onChange(of: multiChord.lowerChord) {
      ChordHighlighter.highlightStacked(
        chord: &multiChord.lowerChord,
        oldChord: &oldMultiChord.lowerChord,
        keyboard: &keyboard,
        initial: false,
        color: color
      )
    }
    
  }
}

#Preview {
  LowerChordKeyboardView(
    text: "Select Chord:",
    multiChord: Binding.constant(
      MultiChord(
        lowerChord: Chord(.c, .ma7, startingOctave: 4),
        upperChord: Chord(.d, .ma, startingOctave: 4)
      )
    ),
      oldMultiChord: Binding.constant(
        MultiChord(
          lowerChord: Chord(.c, .ma7, startingOctave: 4),
          upperChord: Chord(.d, .ma, startingOctave: 4)
        )
      ),
    keyboard: Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5),
    color: .yellow
  )
}
