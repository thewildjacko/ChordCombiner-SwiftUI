//
//  SingleChordTitleNavigationStackView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/11/24.
//

import SwiftUI
import AudioKit
import AudioKitEX
import AudioKitUI
import AVFoundation
import Keyboard
import SoundpipeAudioKit
import Tonic

struct SingleChordTitleNavigationStackView: View {
  @EnvironmentObject var conductor: InstrumentEXSConductor
  @EnvironmentObject var seqConductor: SFZSequencerConductor
  @State private var isPlaying: Bool = false

  var keyboardWidth: CGFloat = 351
  var selectedKeyboard: Keyboard

  let chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel

  var body: some View {
    VStack {
      SingleChordDetailNavigationTitleView(
        keyboardWidth: keyboardWidth,
        titleText: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
        titleFont: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
        chord: chordCombinerSelectedChordTitleModel.selectedChord ?? Chord.initial,
        color: chordCombinerSelectedChordTitleModel.selectedChordColor)

      selectedKeyboard
    }
  }
}
