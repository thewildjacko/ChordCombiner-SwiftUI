//
// DualChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordDetailNavigationLinkView: View {
  @EnvironmentObject var conductor: InstrumentEXSConductor
  @EnvironmentObject var seqConductor: SFZSequencerConductor
  @State private var isPlaying: Bool = false
  let chordCombinerViewModel = ChordCombinerViewModel.singleton()
  let showCaption: Bool

  var chord: Chord {
    if let lowerChord = chordCombinerViewModel.lowerChord {
      return lowerChord
    } else if let upperChord = chordCombinerViewModel.upperChord {
      return upperChord
    } else {
      return Chord.initial
    }
  }

  var color: Color {
    chordCombinerViewModel.lowerChord != nil ?
      .lowerChordHighlight :
      .upperChordHighlight
  }

  var pitches: [Int] {
    if chordCombinerViewModel.resultChord != nil,
       let chordCombinerVoicingCalculator = chordCombinerViewModel.chordCombinerVoicingCalculator {
      return chordCombinerViewModel.getPitchesToHighlight(
        startingPitch: chordCombinerViewModel.combinedKeyboard.startingPitch,
        lowerTones: chordCombinerVoicingCalculator.lowerTonesToHighlight,
        upperTones: chordCombinerVoicingCalculator.upperTonesToHighlight,
        commonTones: chordCombinerVoicingCalculator.commonTonesToHighlight).combinedSorted
    } else {
      return chord.voicingCalculator.stackedPitches/* ?? []*/
    }
  }

  @ViewBuilder
  var body: some View {
    HStack {
      if chordCombinerViewModel.resultChord != nil {
        NavigationLink(
          destination: DualChordDetailView(showCaption: showCaption)) {
            InfoLinkImageView()
          }
          .simultaneousGesture(TapGesture().onEnded {
            if isPlaying {
              conductor.notesOff(pitchNumbers: pitches)
              isPlaying.toggle()
            }
          })
      } else {
        SingleChordDetailNavigationView(
          keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
          chord: chord/* ?? Chord.initial*/,
          color: color)
      }

      PlayButton(
        isPlaying: $isPlaying,
        pitches: pitches)
    }
  }
}

#Preview {
  DualChordDetailNavigationLinkView(showCaption: true)
}
