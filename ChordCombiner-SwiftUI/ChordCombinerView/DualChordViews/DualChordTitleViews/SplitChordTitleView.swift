//
//  SplitChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//
import SwiftUI

struct SplitChordTitleView: View {
  var lowerChord: Chord
  var upperChord: Chord
  let titleFont: Font

  var body: some View {
    HStack(spacing: 5) {
      TitleView(
        text: lowerChord.displayDetails(detailType: .commonName),
        font: titleFont,
        weight: .heavy
      )
      SingleChordDetailNavigationView(
        chord: lowerChord,
        color: .lowerChordHighlight,
        infoFont: .caption)

      TitleView(text: "/", font: .largeTitle, weight: .heavy)

      TitleView(
        text: upperChord.displayDetails(detailType: .commonName),
        font: titleFont,
        weight: .heavy
      )
      SingleChordDetailNavigationView(
        chord: upperChord,
        color: .upperChordHighlight,
        infoFont: .caption)
    }
  }
}
