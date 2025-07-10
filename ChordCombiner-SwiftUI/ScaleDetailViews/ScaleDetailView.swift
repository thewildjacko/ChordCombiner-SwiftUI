//
//  ScaleDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/21/25.
//

import SwiftUI

struct ScaleDetailView: View {
  let scale: Scale
  var keyboardWidth: CGFloat = .zero
  @State var keyboard: Keyboard = Keyboard.initialSingleChordKeyboard

  var body: some View {
    VStack(spacing: 20) {
      TitleView(
        text: scale.details.name,
        font: .title,
        weight: .heavy
      )
      .padding(.bottom, 10)

      keyboard
        .onAppear(perform: {
          keyboard = Keyboard(
            width: keyboardWidth,
            initialKeyType: .c,
            startingOctave: 4,
            octaves: 2,
            letterPadding: true)
          keyboard.setNotesStacked(
            pitchesByNote: scale.scalePitchCalculator.stackedPitchesByNote)
          keyboard.highlightKeys_LettersOn(
            pitches: scale.scalePitchCalculator.stackedPitches,
            color: .lowerChordHighlight)
        })

      ScaleDetailForm(scale: scale)

      Spacer()
    }
    .padding(.vertical)
    .background(.primaryBackground)
  }
}

#Preview {
    ScaleDetailView(
      scale: Scale(.c, .diminished),
      keyboardWidth: 351,
      keyboard: Keyboard.initialSingleChordKeyboard
    )
}
