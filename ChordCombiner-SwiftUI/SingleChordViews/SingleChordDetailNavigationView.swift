//
//  SingleChordDetailNavigationView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct SingleChordDetailNavigationView: View {
  enum LabelType {
    case icon, title, detailRow
  }

  var keyboardWidth: CGFloat = 351

  var chord: Chord
  var color: Color
  var infoFont: Font? = .title3
  var detailTitle: String?
  var labelType: LabelType = .icon

  @ViewBuilder
  var body: some View {
    NavigationLink(
      destination:
        SingleChordDetailView(
          chord: chord,
          keyboard:
            Keyboard(
              width: keyboardWidth,
              initialKeyType: .c,
              startingOctave: 4,
              octaves: 3,
              chord: chord,
              color: color,
              lettersOn: true,
              letterPadding: true
            )
        )
    ) {
      switch labelType {
      case .icon:
        if let infoFont = infoFont {
          InfoLinkImageView(font: infoFont)
        }
      case .title:
        TitleView(text: chord.details.preciseName, font: .headline)
      case .detailRow:
        if let detailTitle = detailTitle {
          DetailRow(title: detailTitle, text: chord.details.preciseName)
        }
      }
    }
  }
}

#Preview {
  SingleChordDetailNavigationView(
    chord: Chord(.c, .ma7),
    color: .lowerChordHighlight
  )
}
