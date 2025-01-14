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

  @Binding var chordProperties: ChordProperties
  let isLowerChordMenu: Bool
  var chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel.initial

  init(
    chordProperties: Binding<ChordProperties>,
    islowerChordMenu: Bool) {
      self._chordProperties = chordProperties
      self.isLowerChordMenu = islowerChordMenu
      setChordCombinerSelectedChordTitleModel()
    }

  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(isLowerChordMenu: isLowerChordMenu)
  }

  @ViewBuilder
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

          isLowerChordMenu ? chordCombinerViewModel.lowerKeyboard : chordCombinerViewModel.upperKeyboard
        }
      }
      .buttonStyle(.plain)
      .tint(.primaryBackground)
      .background(.primaryBackground)
    }
  }
}

#Preview {
  ChordCombinerMenuCoverView(chordProperties: .constant(ChordProperties.initial), islowerChordMenu: true)
}
