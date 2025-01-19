//
//  SingleChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/16/24.
//

import SwiftUI

struct SingleChordDetailView: View {
  let chord: Chord
  @State var keyboard: Keyboard

  @State var chordGrapher: ChordGrapher? {
    didSet {
      grapherLoaded = false
      chordGrapherNavigationView =
      ChordGrapherNavigationView(
        chordGrapher: $chordGrapher,
        grapherLoaded: $grapherLoaded)
    }
  }

  @State var grapherLoaded: Bool = true

  @State var chordGrapherNavigationView: ChordGrapherNavigationView =
  ChordGrapherNavigationView(
    chordGrapher: .constant(nil),
    grapherLoaded: .constant(true))

  var baseChord: Chord { chord.getBaseChord() }

  var body: some View {
    VStack(spacing: 20) {
      TitleView(
        text: chord.details.commonName,
        font: .largeTitle,
        weight: .heavy
      )

      ChordSymbolCaptionView(chord: chord)

      keyboard
        .onAppear(perform: {
          keyboard.setNotesStacked(pitchesByNote: chord.voicingCalculator.stackedPitchesByNote)
        })

      ChordDetailForm(
        notesText: chord.details.noteNames,
        degreesText: chord.details.degreeNames,
        chord: chord,
        isDualChordDetailView: false,
        chordGrapher: $chordGrapher,
        chordGrapherNavigationView: $chordGrapherNavigationView
      )
        .onAppear {
          Task {
            await chordGrapher = ChordGrapher.getChordGrapher(
              chord: chord)
          }
        }

      Spacer()
    }
    .padding(.vertical)
    .background(.primaryBackground)
  }
}

#Preview {
  SingleChordDetailView(
    chord: Chord(.c, .ma13sh11),
    keyboard: Keyboard.initialDualChordKeyboard
  )
}
