//
//  CustomChordMenuKeyboardDisplayRow.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/20/24.
//

import SwiftUI

struct CustomChordMenuKeyboardDisplayRow: View {
  @Binding var selectedChordType: ChordType?
  @Binding var matchingChordTypes: Set<ChordType>

  var chordType: ChordType
  var titleText: String
  var titleColor: Color
  var glowColor: Color
  var glowRadius: CGFloat
  var chord: Chord?
  var keyboardColor: Color?

  var keyboard: Keyboard {
    if let chord = chord, let keyboardColor = keyboardColor {
      Keyboard(
        width: 150,
        initialKeyType: .c,
        startingOctave: 4,
        octaves: 2,
        glowColor: glowColor,
        glowRadius: glowRadius,
        chord: chord,
        color: keyboardColor
      )
    } else {
      Keyboard(
        width: 150,
        initialKeyType: .c,
        startingOctave: 4,
        octaves: 2
      )
    }
  }

  var body: some View {
//    print("keyboard \(chordType.preciseName) computed!")

    return HStack(alignment: .firstTextBaseline) {
      VStack(alignment: .leading, spacing: 10) {
        TitleView(
          text: titleText,
          font: .title3, weight: .heavy,
          color: titleColor
        )

        keyboard
      }
      .onTapGesture { selectedChordType = chordType }

      Spacer()

      if matchingChordTypes.contains(chordType) {
        TitleView(text: "match found!", font: .caption, weight: .bold, color: .glowText)
      }
    }
  }
}

extension CustomChordMenuKeyboardDisplayRow: Equatable {
  static func == (lhs: CustomChordMenuKeyboardDisplayRow, rhs: CustomChordMenuKeyboardDisplayRow) -> Bool {
    lhs.selectedChordType == rhs.selectedChordType &&
    lhs.matchingChordTypes == rhs.matchingChordTypes &&
    lhs.chord == rhs.chord &&
    lhs.chordType == rhs.chordType &&
    lhs.titleText == rhs.titleText &&
    lhs.titleColor == rhs.titleColor &&
    lhs.glowColor == rhs.glowColor &&
    lhs.glowRadius == rhs.glowRadius &&
    lhs.keyboard == rhs.keyboard &&
    lhs.keyboardColor == rhs.keyboardColor
  }
}

#Preview {
  CustomChordMenuKeyboardDisplayRow(
    selectedChordType: .constant(.ma7),
    matchingChordTypes: .constant([.ma, .mi, .aug, .ma7]),
    chordType: .ma7,
    titleText: "Cma7",
    titleColor: .glow,
    glowColor: .glow,
    glowRadius: 5,
    chord: Chord(.c, .ma7),
    keyboardColor: .lowerChordHighlight)
}
