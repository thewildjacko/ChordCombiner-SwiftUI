//
//  ChordCombinerMenuCoverView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct ChordCombinerMenuCoverView: View {
  var chordCombinerViewModel: ChordCombinerViewModel {
    didSet { setChordCombinerSelectedChordTitleModel() }
  }

  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties

  var chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel.initial

  init(
    chordCombinerViewModel: ChordCombinerViewModel,
    keyboard: Binding<Keyboard>,
    combinedKeyboard: Binding<Keyboard>,
    chordProperties: Binding<ChordProperties>) {
    self.chordCombinerViewModel = chordCombinerViewModel
    self._keyboard = keyboard
    self._combinedKeyboard = combinedKeyboard
    self._chordProperties = chordProperties

    setChordCombinerSelectedChordTitleModel()
  }

  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(
      chordCombinerViewModel: chordCombinerViewModel,
      chordProperties: chordProperties
    )
  }

  var body: some View {
    VStack {
      TitleView(
        text: chordCombinerSelectedChordTitleModel.promptText,
        font: .headline,
        weight: .heavy,
        isMenuTitle: false)

      NavigationLink(
        destination:
          ChordCombinerChordSelectionMenu(
            chordCombinerViewModel: chordCombinerViewModel,
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties
          )
          .navigationTitle(chordCombinerSelectedChordTitleModel.promptText)
          .navigationBarTitleDisplayMode(.inline)
      ) {
        VStack(spacing: 15) {
            TitleView(
              text: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
              weight: .heavy,
              color: .button
            )

          keyboard
        }
      }
    }
  }
}

#Preview {
  ChordCombinerMenuCoverView(
    chordCombinerViewModel: ChordCombinerViewModel(),
    keyboard: .constant(Keyboard.initialSingleChordKeyboard),
    combinedKeyboard: .constant(Keyboard.initialDualChordKeyboard),
    chordProperties: .constant(ChordProperties.initial))
}
