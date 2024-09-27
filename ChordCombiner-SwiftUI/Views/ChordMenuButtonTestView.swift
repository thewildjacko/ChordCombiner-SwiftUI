//
//  ChordMenuButtonTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/15/24.
//

import SwiftUI

struct ChordMenuButtonTestView: View {
  @Binding var chord: Chord
  @State var keyboard: Keyboard = Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)
  var chordType: ChordType
  var color: Color
  
  
  var body: some View {
    VStack(spacing: 20) {
      //      ForEach(ChordType.triadTypes) { type in
      HStack {
        VStack {
          Spacer()
          Button("\(chord.root.noteName)\(chordType.rawValue)") { chord.type = chordType }
          Spacer()
        }
        keyboard
      }
      //      }
    }
    .onAppear(perform: {
      keyboard.toggleHighlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
    })
  }
}

#Preview {
  ChordMenuButtonTestView(
    chord: Binding.constant(Chord(.c, .ma)),
    chordType: .ma,
    color: .yellow)
}
