//
//  SingleChordKeyboardMenuView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/21/24.
//

import SwiftUI

struct SingleChordKeyboardMenuView: View {
  @State var chord: Chord = Chord(.c, .ma, startingOctave: 3)
  @State var oldChord: Chord = Chord(.c, .ma, startingOctave: 3)
  @State var keyboard: Keyboard = Keyboard(geoWidth: 300, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  @State var isInitial: Bool = true
  var color: Color = .lowerChordHighlight

  //  MARK: instance methods
  func setAndHighlightChord() {
    let stackedPitches = chord.voicingCalculator.stackedPitches
    
    if isInitial {
      keyboard.toggleHighlightKeysSingle(degreeNumbers: stackedPitches, color: color)
            
      isInitial = false
    } else {
      let oldStackedPitches = oldChord.voicingCalculator.stackedPitches
      
      keyboard.toggleHighlightKeysSingle(degreeNumbers: oldStackedPitches, color: color)
      keyboard.toggleHighlightKeysSingle(degreeNumbers: stackedPitches, color: color)
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
    SingleChordKeyboardMenuView(
    chord: Chord(.c, .ma),
    keyboard: Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3),
    color: .lowerChordHighlight)
}

