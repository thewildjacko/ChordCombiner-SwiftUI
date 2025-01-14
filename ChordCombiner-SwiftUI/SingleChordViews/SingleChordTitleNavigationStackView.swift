//
//  SingleChordTitleNavigationStackView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/11/24.
//

import SwiftUI

struct SingleChordTitleNavigationStackView: View {
  var keyboardWidth: CGFloat = 351
  var selectedKeyboard: Keyboard

  let chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel

  var body: some View {
    VStack {
      SingleChordDetailNavigationTitleView(
        keyboardWidth: keyboardWidth,
        titleText: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
        titleFont: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
        chord: chordCombinerSelectedChordTitleModel.selectedChord,
        color: chordCombinerSelectedChordTitleModel.selectedChordColor)

      selectedKeyboard
    }
  }
}
