//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
  @State var shouldPresentDualKeyboardHelpView = false
  @State var chordGrapher: ChordGrapher? {
    didSet {
      grapherLoaded = false
      chordGrapherNavigationView =
      ChordGrapherNavigationView(
        chordGrapher: $chordGrapher,
        grapherLoaded: $grapherLoaded)
    }
  }

  @State var grapherLoaded: Bool = true

  @State var chordGrapherNavigationView: ChordGrapherNavigationView =
  ChordGrapherNavigationView(
    chordGrapher: .constant(nil),
    grapherLoaded: .constant(true))

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
      ZStack {
        DualChordTitleHelpViewBuilder(
          shouldPresentDualKeyboardHelpView: $shouldPresentDualKeyboardHelpView,
          keyboard: chordCombinerViewModel.combinedKeyboard)

      DualChordTitleView(
        titleText: titleText,
        titleFont: titleFont,
        showCaption: showCaption,
        showTitle: true)
      }

      chordCombinerViewModel.combinedKeyboard

      ChordDetailForm(
        notesText: chordCombinerViewModel.resultChordNotesAndDegrees.notes,
        degreesText: chordCombinerViewModel.resultChordNotesAndDegrees.degrees,
        chord: chordCombinerViewModel.resultChord ?? Chord.initial,
        chordGrapher: $chordGrapher,
        chordGrapherNavigationView: $chordGrapherNavigationView)
      .onAppear {
        Task {
          await chordGrapher = ChordGrapher.getChordGrapher(
            chord: chordCombinerViewModel.resultChord)
        }
      }

      Spacer()
    }
    .padding(.vertical)
    .background(.primaryBackground)
  }
}

#Preview("Both chords selected") {
  DualChordDetailView(showCaption: true)
}
