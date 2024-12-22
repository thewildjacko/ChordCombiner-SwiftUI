//
//  SingleChordTitleNavigationStackView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/11/24.
//

import SwiftUI

struct SingleChordTitleNavigationStackView: View {
  @Binding var selectedKeyboard: Keyboard

  let chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel

  var body: some View {
    VStack {
      HStack {
        TitleView(
          text: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
          font: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
          weight: .heavy,
          isMenuTitle: false
        )
        SingleChordDetailNavigationView(
          chord: chordCombinerSelectedChordTitleModel.selectedChord,
          color: chordCombinerSelectedChordTitleModel.selectedChordColor)
      }

      selectedKeyboard
    }
  }
}
