//
//  ChordCombinerMenuCoverView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI
import AudioKit
import AudioKitEX
import AudioKitUI
import AVFoundation
import SoundpipeAudioKit
import Tonic

struct ChordCombinerMenuCoverView: View {
  @EnvironmentObject var conductor: InstrumentEXSConductor
  @EnvironmentObject var seqConductor: SFZSequencerConductor
  @State private var isPlaying: Bool = false

  var chordCombinerViewModel = ChordCombinerViewModel.singleton() {
    didSet { setChordCombinerSelectedChordTitleModel() }
  }

  @Binding var chordProperties: ChordProperties
  let isLowerChordMenu: Bool
  var chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel.initial

  var playButton: PlayButton {
    return PlayButton(
      isPlaying: $isPlaying,
      pitches: chordCombinerSelectedChordTitleModel.selectedChord?.voicingCalculator.stackedPitches ?? []
      )
  }

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

      VStack(spacing: 25) {
        HStack {
          NavigationLink(
            destination:
              ChordCombinerChordSelectionMenu(
                chordProperties: $chordProperties,
                islowerChordMenu: isLowerChordMenu
              )
              .navigationTitle(chordCombinerSelectedChordTitleModel.promptText)
              .navigationBarTitleDisplayMode(.inline)
          ) {
            TitleView(
              text: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
              weight: .heavy,
              color: .button
            )
          }
          .simultaneousGesture(TapGesture().onEnded {
            if isPlaying {
              if let selectedChord = chordCombinerSelectedChordTitleModel.selectedChord {
                conductor.notesOff(pitchNumbers: selectedChord.voicingCalculator.stackedPitches)
                isPlaying.toggle()
              }
            }
          })

          if chordCombinerSelectedChordTitleModel.selectedChord != nil {
            playButton
          }
        }

        NavigationLink(
          destination:
            ChordCombinerChordSelectionMenu(
              chordProperties: $chordProperties,
              islowerChordMenu: isLowerChordMenu
            )
            .navigationTitle(chordCombinerSelectedChordTitleModel.promptText)
            .navigationBarTitleDisplayMode(.inline)
        ) {
          isLowerChordMenu ? chordCombinerViewModel.lowerKeyboard : chordCombinerViewModel.upperKeyboard
        }
        .simultaneousGesture(TapGesture().onEnded {
          if isPlaying {
            if let selectedChord = chordCombinerSelectedChordTitleModel.selectedChord {
              conductor.notesOff(pitchNumbers: selectedChord.voicingCalculator.stackedPitches)
              isPlaying.toggle()
            }
          }
        })
      }
      .buttonStyle(.plain)
      .tint(.primaryBackground)
      .background(.primaryBackground)
    }
  }
}

#Preview {
  ChordCombinerMenuCoverView(chordProperties: .constant(ChordProperties.initial), islowerChordMenu: true)
    .environmentObject(SFZSequencerConductor())
}
