//
//  ChordCombinerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI
import SwiftData

struct ChordCombinerView: View {
  let keyboardHighlighter = KeyboardHighlighter()

  // MARK: @State and instance variables
  @Bindable var chordCombinerViewModel: ChordCombinerViewModel = ChordCombinerViewModel.singleton()

  func highlightKeyboards() {
    if chordCombinerViewModel.initial {
      if let lowerChord = chordCombinerViewModel.lowerChord {
        keyboardHighlighter.highlightSelectedChord(
          selectedChord: lowerChord,
          selectedKeyboard: &chordCombinerViewModel.lowerKeyboard,
          selectedChordColor: .lowerChordHighlight)
      }

      if let upperChord = chordCombinerViewModel.upperChord {
        keyboardHighlighter.highlightSelectedChord(
          selectedChord: upperChord,
          selectedKeyboard: &chordCombinerViewModel.upperKeyboard,
          selectedChordColor: .upperChordHighlight)
      }

      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerViewModel.lowerChord,
        chordToMatch: chordCombinerViewModel.upperChord,
        combinedKeyboard: &chordCombinerViewModel.combinedKeyboard
      )
    }
  }

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()

        ChordCombinerMenuCoverView(
          keyboard: $chordCombinerViewModel.lowerKeyboard,
          combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
          chordProperties: $chordCombinerViewModel.chordPropertyData.lowerChordProperties,
          islowerChordMenu: true
        )

        Spacer()

        TitleView(text: "+", font: .largeTitle, weight: .heavy)
          .zIndex(1.0)

        Spacer()

        ChordCombinerMenuCoverView(
          keyboard: $chordCombinerViewModel.upperKeyboard,
          combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
          chordProperties: $chordCombinerViewModel.chordPropertyData.upperChordProperties,
          islowerChordMenu: false
        )

        Spacer()

        TitleView(text: "=", font: .largeTitle, weight: .heavy)

        Spacer()

        DualChordKeyboardView(keyboard: $chordCombinerViewModel.combinedKeyboard)

        Spacer()
      }
      .frame(maxWidth: .infinity)
      .padding()
      .navigationTitle("Chord Combiner")
      .onAppear {
        highlightKeyboards()
        chordCombinerViewModel.initial = false

        print(FileManager.documentsDirectoryURL)
      }
      .background(.primaryBackground)
    }
  }
}

#Preview {
  ChordCombinerView()
}
