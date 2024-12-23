//
//  ChordCombinerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI
import SwiftData

struct ChordCombinerView: View {
  @State var size = CGSize()
  @State var initial: Bool = true

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
    GeometryReader { proxy in
      NavigationStack {
        VStack {
          Spacer()

          HStack {
            Spacer()
            ChordCombinerMenuCoverView(
              keyboard: $chordCombinerViewModel.lowerKeyboard,
              combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
              chordProperties: $chordCombinerViewModel.chordPropertyData.lowerChordProperties,
              islowerChordMenu: true
            )
            Spacer()
          }
          .frame(width: proxy.size.width)

          Spacer()

          TitleView(text: "+", font: .largeTitle, weight: .heavy)
            .zIndex(1.0)

          Spacer()

          HStack {
            Spacer()
            ChordCombinerMenuCoverView(
              keyboard: $chordCombinerViewModel.upperKeyboard,
              combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
              chordProperties: $chordCombinerViewModel.chordPropertyData.upperChordProperties,
              islowerChordMenu: false
            )
            Spacer()
          }
          .frame(width: proxy.size.width)

          Spacer()

          TitleView(text: "=", font: .largeTitle, weight: .heavy)

          Spacer()

          HStack {
            Spacer()
            DualChordKeyboardView(keyboard: $chordCombinerViewModel.combinedKeyboard)
            Spacer()
          }
          .frame(width: proxy.size.width)

          Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("Chord Combiner")
        .onAppear {
          if initial {
            size = proxy.size
            chordCombinerViewModel.lowerKeyboard = Keyboard(
              width: size.width * 0.9,
              initialKeyType: .c,
              startingOctave: 4,
              octaves: 2,
              letterPadding: true)

            chordCombinerViewModel.upperKeyboard = Keyboard(
              width: size.width * 0.9,
              initialKeyType: .c,
              startingOctave: 4,
              octaves: 2,
              letterPadding: true)

            chordCombinerViewModel.combinedKeyboard = Keyboard(
              width: size.width * 0.9,
              initialKeyType: .c,
              startingOctave: 4,
              octaves: 3,
              letterPadding: true)
          }

          initial = false
          
          highlightKeyboards()
          chordCombinerViewModel.initial = false

          print(FileManager.documentsDirectoryURL)
        }
        .background(.primaryBackground)
      }
    }
  }
}

#Preview {
  ChordCombinerView()
}
