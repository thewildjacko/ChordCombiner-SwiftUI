//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var chordCombinerViewModel: ChordCombinerViewModel
  @Binding var keyboard: Keyboard

  var dualChordKeyboardChordTitleModel: DualChordKeyboardChordTitleModel {
    DualChordKeyboardChordTitleModel(chordCombinerViewModel: chordCombinerViewModel)
  }

  var titleText: String { dualChordKeyboardChordTitleModel.chordSymbolText
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

  var body: some View {
    VStack(spacing: 20) {
      HStack {
        DualChordTitleView(
          chordCombinerViewModel: chordCombinerViewModel,
          titleText: dualChordKeyboardChordTitleModel.chordSymbolText,
          titleFont: titleFont,
          showCaption: false)
        DualChordDetailNavigationLinkView(chordCombinerViewModel: chordCombinerViewModel, showCaption: true)
      }

      keyboard
    }
  }
}

#Preview("Both chords selected") {
  DualChordKeyboardView(
    chordCombinerViewModel: ChordCombinerViewModel(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    ), keyboard: .constant(Keyboard.initialDualChordKeyboard))
}

#Preview("Lower chord selected") {
  DualChordKeyboardView(
    chordCombinerViewModel: ChordCombinerViewModel(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7)
    ), keyboard: .constant(Keyboard.initialDualChordKeyboard))
}

#Preview("Upper chord selected") {
  DualChordKeyboardView(
    chordCombinerViewModel: ChordCombinerViewModel(
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    ), keyboard: .constant(Keyboard.initialDualChordKeyboard))
}

#Preview("No chords selected") {
  DualChordKeyboardView(
    chordCombinerViewModel: ChordCombinerViewModel(),
    keyboard: .constant(Keyboard.initialDualChordKeyboard))
}
