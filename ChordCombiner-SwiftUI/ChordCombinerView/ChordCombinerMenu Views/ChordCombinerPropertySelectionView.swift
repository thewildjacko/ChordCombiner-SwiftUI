//
//  ChordCombinerPropertySelectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/11/24.
//

import SwiftUI

struct ChordCombinerPropertySelectionView: View {
  @Binding var chordProperties: ChordProperties
  @Binding var matchingLetters: Set<Letter>
  @Binding var matchingAccidentals: Set<RootAccidental>
  @Binding var matchingChordTypes: Set<ChordType>

  let chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel

  var rootKeyNote: RootKeyNote? {
    guard let letter = chordProperties.letter,
          let accidental = chordProperties.accidental else {
      return nil
    }

    return RootKeyNote(letter, accidental)
  }

  var chordCombinerKeyboardScrollView: ChordCombinerKeyboardScrollView {
    ChordCombinerKeyboardScrollView(
      selectedChordType: $chordProperties.chordType,
      matchingChordTypes: $matchingChordTypes,
      chordTypes: ChordType.allSimpleChordTypes,
      rootKeyNote: rootKeyNote,
      color: chordCombinerSelectedChordTitleModel.selectedChordColor
    )
  }

  var body: some View {
    VStack {
      TitleView(
        text: chordCombinerSelectedChordTitleModel.showingMatchesText,
        font: .caption,
        weight: .semibold,
        color: .glowText
      )

      HStack(alignment: .bottom) {
        ChordCombinerTagsView(
          selectedProperty: $chordProperties.letter,
          matchingProperties: $matchingLetters,
          tagProperties: Letter.allCases,
          isHorizontal: true,
          font: .headline,
          horizontalPadding: 10,
          verticalPadding: 1.5,
          cornerRadius: 5,
          spacing: 8,
          highlightColor: .tagBackgroundHighlighted
        )

        Divider()
          .frame(height: 30)
          .titleColorOverlay()

        ChordCombinerTagsView(
          selectedProperty: $chordProperties.accidental,
          matchingProperties: $matchingAccidentals,
          tagProperties: RootAccidental.allCases,
          isHorizontal: true,
          font: .headline,
          horizontalPadding: 5,
          verticalPadding: 1.5,
          cornerRadius: 5,
          spacing: 8,
          highlightColor: .tagBackgroundHighlighted
        )
      }
    }

    TitleColorDivider()

    chordCombinerKeyboardScrollView
//    ChordCombinerKeyboardScrollView(
//      selectedChordType: $chordProperties.chordType,
//      matchingChordTypes: $matchingChordTypes,
//      chordTypes: ChordType.allSimpleChordTypes,
//      rootKeyNote: rootKeyNote,
//      color: chordCombinerSelectedChordTitleModel.selectedChordColor
//    )

    TitleColorDivider()
  }
}
