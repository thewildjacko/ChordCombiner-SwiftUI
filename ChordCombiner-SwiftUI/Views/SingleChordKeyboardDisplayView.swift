//
//  SingleChordKeyboardDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/21/24.
//

import SwiftUI

struct SingleChordKeyboardDisplayView: View {
  @State var chord: Chord = Chord(.c, .ma, startingOctave: 3)
  @State var oldChord: Chord = Chord(.c, .ma, startingOctave: 3)
  @State var keyboard: Keyboard = Keyboard(geoWidth: 300, initialKey: .C,  startingOctave: 4, octaves: 3)
  @State var isInitial: Bool = true
  var color: Color = .yellow

  //  MARK: instance methods
  func setAndHighlightChord() {
    let stackedPitches = chord.voicingCalculator.stackedPitches
    
    if isInitial {
      keyboard.toggleHighlightKeysSingle(degs: stackedPitches, color: color)
            
      isInitial = false
    } else {
      let oldStackedPitches = oldChord.voicingCalculator.stackedPitches
      
      keyboard.toggleHighlightKeysSingle(degs: oldStackedPitches, color: color)
      keyboard.toggleHighlightKeysSingle(degs: stackedPitches, color: color)
    }
    
    oldChord = chord

  }

  var body: some View {
    VStack(spacing: 20) {
      ChordMenu(
        text: "Select Chord",
        chord: $chord,
        keyboard: $keyboard)
    }
    .onAppear(perform: {
      setAndHighlightChord()
    })
    .onChange(of: chord) {
      setAndHighlightChord()
    }
  }
}

#Preview {
    SingleChordKeyboardDisplayView(
    chord: Chord(.c, .ma),
    keyboard: Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 3),
    color: .yellow)
}
