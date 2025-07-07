//
//  ChordCombinerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI
import SwiftData
import OSLog

struct ChordCombinerView: View {
  // MARK: @State and instance variables
  @EnvironmentObject var conductor: InstrumentEXSConductor
  @EnvironmentObject var seqConductor: SFZSequencerConductor
  @Binding var size: CGSize
  @State var initial: Bool = true
  @State var shouldPresentInitialHelpView = false

  let keyboardHighlighter = KeyboardHighlighter()

  @Bindable var chordCombinerViewModel: ChordCombinerViewModel = ChordCombinerViewModel.singleton()

  // MARK: Instance methods
  func highlightKeyboards() {
    if initial {
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

  func loadInstrument() async {
    let task = Task {
      do {
        if let fileURL = Bundle.main.url(forResource: "Sounds/YDP-GrandPiano-20160804", withExtension: "sf2") {
          try conductor.instrument.loadMelodicSoundFont(url: fileURL, preset: 0)
        } else {
          //          Log("Could not find file")
        }
      } catch {
        //        Log("Could not load instrument")
      }

      conductor.start()
    }

    return await task.value
  }

  // MARK: BODY
  var body: some View {
    GeometryReader { proxy in
      NavigationStack {
        VStack {
          Spacer()

          HStack {
            Spacer()
            ChordCombinerMenuCoverView(
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
            DualChordKeyboardView()
            Spacer()
          }
          .frame(width: proxy.size.width)

          Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("Chord Combiner")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button {
              shouldPresentInitialHelpView.toggle()
            } label: {
              Image(systemName: "questionmark.circle")
            }
            .sheet(isPresented: $shouldPresentInitialHelpView) {
              InitialHelpView()
                .presentationDetents([.fraction(0.8)])
                .presentationBackground(.thinMaterial)
            }
          }
        }
        .onAppear {
          Task {
            await loadInstrument()
          }
          seqConductor.start()

          if chordCombinerViewModel.chordPropertyData.initial {
            size = proxy.size

            chordCombinerViewModel.chordPropertyData.width = size.width

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

          chordCombinerViewModel.chordPropertyData.initial = false

          highlightKeyboards()
          initial = false

          Logger.main.info("\(FileManager.documentsDirectoryURL)")
        }
        .background(.primaryBackground)
      }
    }
  }
}

#Preview {
  ChordCombinerView(size: .constant(CGSize()))
}
