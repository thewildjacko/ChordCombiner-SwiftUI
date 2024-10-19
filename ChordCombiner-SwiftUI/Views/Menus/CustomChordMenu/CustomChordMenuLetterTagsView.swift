//
//  CustomChordMenuLetterTagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

/**
 A view to let users select the ``Letter`` of the displayed `Chords.`
 - Parameter selectedLetter: binding var to choose the ``Letter``
 - Note: This does not affect the accidental (i.e. ``RootAccidental``); accidental selection is handled by a separate ``AccidentalsView``. Only one ``Letter`` can be selected at a time.
 - SeeAlso: ``Letter``
 
 */
struct CustomChordMenuLetterTagsView: View {
  @EnvironmentObject var multiChord: MultiChord
  @Binding var selectedLetter: Letter?
  @Binding var matchingLetters: Set<Letter>
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var spacing: CGFloat = 10
  
  var body: some View {
    HStack(spacing: spacing) {
      ForEach(Letter.allCases, id: \.self) { letter in
        LetterTagView(
          letter: letter,
          highlightCondition: selectedLetter == letter,
          font: font,
          horizontalPadding: horizontalPadding,
          verticalPadding: verticalPadding,
          cornerRadius: cornerRadius,
          glowColor: matchingLetters.contains(letter) ? .glow : .clear,
          glowRadius: matchingLetters.contains(letter) ? 3 : 0
        )
        .onTapGesture { selectedLetter = letter }
      }
    }
    .environmentObject(multiChord)
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  CustomChordMenuLetterTagsView(
    selectedLetter: .constant(.c),
    matchingLetters: .constant([.c, .e, .f])
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil),
      upperChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil)
    )
  )
}
