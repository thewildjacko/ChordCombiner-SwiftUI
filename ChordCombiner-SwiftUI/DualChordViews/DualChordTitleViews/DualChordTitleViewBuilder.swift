//
//  DualChordTitleViewBuilder.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct DualChordTitleViewBuilder: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()

  var dualChordKeyboardChordTitleModel: DualChordKeyboardChordTitleModel {
    DualChordKeyboardChordTitleModel()
  }

  var titleFont: Font {
    if chordCombinerViewModel.resultChord != nil {
      return .title
    } else {
      switch chordCombinerViewModel.chordSelectionStatus {
      case .lowerChordIsSelected, .upperChordIsSelected:
        return .title
      default:
        return .headline
      }
    }
  }

  @ViewBuilder
  var body: some View {
    Group {
      if chordCombinerViewModel.resultChord != nil ||
          (chordCombinerViewModel.lowerChord == nil ||
           chordCombinerViewModel.upperChord == nil) {
        CombinedOrSingleChordTitleView(
          titleText: dualChordKeyboardChordTitleModel.chordSymbolText,
          titleFont: titleFont)
      } else {
        if let lowerChord = chordCombinerViewModel.lowerChord,
           let upperChord = chordCombinerViewModel.upperChord {
          SplitChordTitleView(
            keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
            lowerChord: lowerChord,
            upperChord: upperChord,
            titleFont: titleFont)
        }
      }
    }
  }
}
