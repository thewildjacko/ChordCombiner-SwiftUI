//
//  SingleChordDetailNavigationTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/24/24.
//

import SwiftUI

struct SingleChordDetailNavigationTitleView: View {
  var keyboardWidth: CGFloat = 351
  let titleText: String
  let titleFont: Font
  var infoFont: Font = .title3
  let chord: Chord?
  var color: Color = .lowerChordHighlight
  @State private var isPlaying: Bool = false

  var body: some View {
    HStack {
      TitleView(
        text: titleText,
        font: titleFont,
        weight: .heavy,
        isMenuTitle: false
      )
      SingleChordDetailNavigationView(
        keyboardWidth: keyboardWidth,
        chord: chord,
        color: color,
        infoFont: infoFont)

      PlayButton(
        isPlaying: $isPlaying,
        pitches: chord?.voicingCalculator.stackedPitches ?? [])
    }
  }
}
