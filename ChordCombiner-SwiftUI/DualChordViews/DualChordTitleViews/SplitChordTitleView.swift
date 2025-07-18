//
//  SplitChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//
import SwiftUI

struct SplitChordTitleView: View {
  var keyboardWidth: CGFloat = 351
  var lowerChord: Chord
  var upperChord: Chord
  let titleFont: Font

  var body: some View {
    HStack(spacing: 5) {
      SingleChordDetailNavigationTitleView(
        keyboardWidth: keyboardWidth,
        titleText: upperChord.details.preciseName,
        titleFont: titleFont,
        infoFont: .caption,
        chord: upperChord,
        color: .upperChordHighlight)

      TitleView(text: "/", font: .largeTitle, weight: .heavy)

      SingleChordDetailNavigationTitleView(
        keyboardWidth: keyboardWidth,
        titleText: lowerChord.details.preciseName,
        titleFont: titleFont,
        infoFont: .caption,
        chord: lowerChord)
    }
  }
}
