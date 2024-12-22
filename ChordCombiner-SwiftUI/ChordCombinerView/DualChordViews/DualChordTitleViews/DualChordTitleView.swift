//
//  DualChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct ChordTitleViewBuilder: View {
  let titleText: String
  let titleFont: Font
  var showTitle: Bool = true

  @ViewBuilder
  var body: some View {
    VStack(spacing: 5) {
      if showTitle {
        TitleView(
          text: titleText,
          font: titleFont,
          weight: .heavy
        )
      }
    }
  }
}

struct DualChordTitleView: View {
  let chordCombinerViewModel = ChordCombinerViewModel.singleton()
  let titleText: String
  let titleFont: Font
  var showCaption: Bool = true
  var showTitle: Bool = true

  var body: some View {
    VStack(spacing: 5) {
      ChordTitleViewBuilder(
        titleText: titleText,
        titleFont: titleFont,
        showTitle: showTitle
      )

      ChordSymbolCaptionView(chord: chordCombinerViewModel.resultChord, showCaption: showCaption)
    }
  }
}
