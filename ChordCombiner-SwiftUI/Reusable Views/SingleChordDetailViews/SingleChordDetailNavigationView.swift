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

  var chord: Chord?
  var color: Color
  var infoFont: Font? = .title3
  var detailTitle: String?
  var labelType: LabelType = .icon

  @ViewBuilder
  var body: some View {
    if let chord = chord {
      NavigationLink(
        destination:
          SingleChordDetailView(
            chord: chord,
            keyboard:
              Keyboard(
                baseWidth: 351,
                initialKeyType: .c,
                startingOctave: 4,
                octaves: 3,
                chord: chord,
                color: color,
                lettersOn: true
              )
          )
      ) {
        switch labelType {
        case .icon:
          if let infoFont = infoFont {
            InfoLinkImageView(font: infoFont)
          }
        case .title:
          TitleView(text: chord.preciseName, font: .headline)
        case .detailRow:
          if let detailTitle = detailTitle {
            DetailRow(title: detailTitle, text: chord.preciseName)
          }
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
