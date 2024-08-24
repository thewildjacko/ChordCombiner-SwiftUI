//
//  SingleChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/23/24.
//

import SwiftUI

struct SingleChordKeyboardView: View {
  var text: String
  @Binding var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  var color: Color
  var isLower: Bool
    
  var body: some View {
    VStack(spacing: 20) {
      ChordMenu(
        text: text,
        chord: isLower ? $multiChord.lowerChord : $multiChord.upperChord,
        keyboard: $keyboard
      )
//      keyboard
    }
    
  }
}

#Preview {
  SingleChordKeyboardView(
    text: "Select Chord:",
    multiChord: Binding.constant(
      MultiChord(
        lowerChord: Chord(.c, .ma7, startingOctave: 4),
        upperChord: Chord(.d, .ma, startingOctave: 4)
      )
    ),
    keyboard: Binding.constant(Keyboard(geoWidth: 187, initialKey: .C,  startingOctave: 4, octaves: 2)),
    color: .yellow,
    isLower: true
  )
}
