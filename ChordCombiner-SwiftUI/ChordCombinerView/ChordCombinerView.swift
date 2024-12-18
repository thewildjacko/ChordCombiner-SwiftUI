//
//  ChordCombinerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct ChordCombinerView: View {

  // MARK: @State and instance variables
  @Bindable var chordCombinerViewModel: ChordCombinerViewModel = ChordCombinerViewModel(
    lowerChordProperties: ChordProperties.initial,
    upperChordProperties: ChordProperties.initial,
    lowerKeyboard: Keyboard(baseWidth: 351, initialKeyType: .c, startingOctave: 4, octaves: 2),
    upperKeyboard: Keyboard(baseWidth: 351, initialKeyType: .c, startingOctave: 4, octaves: 2),
    combinedKeyboard: Keyboard(baseWidth: 351, initialKeyType: .c, startingOctave: 4, octaves: 3)
  )

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()

        ChordCombinerMenuCoverView(
          chordCombinerViewModel: chordCombinerViewModel,
          keyboard: $chordCombinerViewModel.lowerKeyboard,
          combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
          chordProperties: $chordCombinerViewModel.lowerChordProperties
        )

        Spacer()

        TitleView(text: "+", font: .largeTitle, weight: .heavy)
          .zIndex(1.0)

        Spacer()

        ChordCombinerMenuCoverView(
          chordCombinerViewModel: chordCombinerViewModel,
          keyboard: $chordCombinerViewModel.upperKeyboard,
          combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
          chordProperties: $chordCombinerViewModel.upperChordProperties
        )

        Spacer()

        TitleView(text: "=", font: .largeTitle, weight: .heavy)

        Spacer()

        DualChordKeyboardView(
          chordCombinerViewModel: chordCombinerViewModel,
          keyboard: $chordCombinerViewModel.combinedKeyboard
        )

        Spacer()
      }
      .frame(maxWidth: .infinity)
      .padding()
      .navigationTitle("Chord Combiner")
    }
  }
}

#Preview {
  ChordCombinerView()
}
