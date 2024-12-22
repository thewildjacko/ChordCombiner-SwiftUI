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
      disabled = false
      chordGrapherNavigationView =
      ChordGrapherNavigationView(
        chordGrapher: $chordGrapher,
        disabled: $disabled)
    }
  }

  @State var disabled: Bool = true

  @State var chordGrapherNavigationView: ChordGrapherNavigationView =
  ChordGrapherNavigationView(
    chordGrapher: .constant(nil),
    disabled: .constant(true))

  var baseChord: Chord { chord.getBaseChord() }

  var body: some View {
    VStack(spacing: 20) {
      TitleView(
        text: chord.displayDetails(detailType: .commonName),
        font: .largeTitle,
        weight: .heavy
      )

      ChordSymbolCaptionView(chord: chord)

      keyboard
        .onAppear(perform: {
          keyboard.setNotesStacked(pitchesByNote: chord.voicingCalculator.stackedPitchesByNote)
        })

      Form {
        List {
          DetailRow(title: "Notes", text: chord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: chord.displayDetails(detailType: .degreeNames))

          chordGrapherNavigationView
        }
        .onAppear {
          Task {
            await chordGrapher = ChordGrapher.getChordGrapher(
              chord: chord)
          }
        }

        BaseChordSectionView(chord: chord)

        EquivalentChordsSectionView(chord: chord)
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview {
  SingleChordDetailView(
    chord: Chord(.c, .ma13sh11),
    keyboard: Keyboard.initialDualChordKeyboard
  )
}
