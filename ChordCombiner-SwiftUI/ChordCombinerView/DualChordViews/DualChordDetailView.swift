//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
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

  var chordCombinerViewModel = ChordCombinerViewModel.singleton()

  var dualChordKeyboardChordTitleModel: DualChordKeyboardChordTitleModel {
    DualChordKeyboardChordTitleModel()
  }

  var titleText: String {
    DualChordKeyboardChordTitleModel().chordSymbolText
  }

  var titleFont: Font {
    chordCombinerViewModel.resultChord != nil ? .largeTitle : .title
  }

  var showCaption: Bool

  var body: some View {
    VStack(spacing: 20) {
      DualChordTitleView(
        titleText: titleText,
        titleFont: titleFont,
        showCaption: showCaption,
        showTitle: true)

      chordCombinerViewModel.combinedKeyboard

      Form {
        List {
          DetailRow(
            title: "Notes",
            text: chordCombinerViewModel.displayDetails(
              detailType: .noteNames))
          DetailRow(
            title: "Degrees",
            text: chordCombinerViewModel.displayDetails(
              detailType: .degreeNames))
          chordGrapherNavigationView
        }
        .onAppear {
          Task {
            await chordGrapher = ChordGrapher.getChordGrapher(
              chord: chordCombinerViewModel.resultChord)
          }
        }

        ComponentChordsView()

        BaseChordSectionView(chord: chordCombinerViewModel.resultChord)

        EquivalentChordsSectionView(chord: chordCombinerViewModel.resultChord)
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview("Both chords selected") {
  DualChordDetailView(showCaption: true)
}
