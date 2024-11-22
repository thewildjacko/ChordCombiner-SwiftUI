//
//  UpperChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct UpperChordKeyboardView: View {
  var text: String
  @Binding var multiChord: MultiChord
  @Binding var oldMultiChord: MultiChord
  
  @State var keyboard: Keyboard
  var color: Color
    
  var body: some View {
    VStack(spacing: 20) {
      ChordMenu(
        text: text,
        chord: $multiChord.upperChord
      )
      keyboard
    }
    .onAppear(perform: {
      ChordHighlighter.highlightStacked(
        chord: &multiChord.upperChord,
        oldChord: &oldMultiChord.upperChord,
        keyboard: &keyboard,
        initial: true,
        color: color
      )
    })
    .onChange(of: multiChord.upperChord) {
      ChordHighlighter.highlightStacked(
        chord: &multiChord.upperChord,
        oldChord: &oldMultiChord.upperChord,
        keyboard: &keyboard,
        initial: false,
        color: color
      )
    }
    
  }
}

#Preview {
  UpperChordKeyboardView(
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
