//
//  ChordCombinerMenuCoverView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct ChordCombinerMenuCoverView: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton() {
    didSet { setChordCombinerSelectedChordTitleModel() }
  }

  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  let isLowerChordMenu: Bool
  var chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel.initial

  init(
    keyboard: Binding<Keyboard>,
    combinedKeyboard: Binding<Keyboard>,
    chordProperties: Binding<ChordProperties>,
    islowerChordMenu: Bool) {
      self._keyboard = keyboard
      self._combinedKeyboard = combinedKeyboard
      self._chordProperties = chordProperties
      self.isLowerChordMenu = islowerChordMenu
      setChordCombinerSelectedChordTitleModel()
    }

  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(
      chordProperties: chordProperties,
      isLowerChordMenu: isLowerChordMenu
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
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties,
            islowerChordMenu: isLowerChordMenu
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
      .buttonStyle(.plain)
      .tint(.primaryBackground)
      .background(.primaryBackground)
    }
  }
}

#Preview {
  ChordCombinerMenuCoverView(
    keyboard: .constant(Keyboard.initialSingleChordKeyboard),
    combinedKeyboard: .constant(Keyboard.initialDualChordKeyboard),
    chordProperties: .constant(ChordProperties.initial),
    islowerChordMenu: true)
}
