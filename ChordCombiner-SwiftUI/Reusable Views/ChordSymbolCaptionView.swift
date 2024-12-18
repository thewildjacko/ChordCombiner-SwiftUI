//
// ChordSymbolCaptionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct ChordSymbolCaptionView: View {
  var chord: Chord? { didSet { setCaptionText() } }
  var showCaption: Bool = true
  var captionText: String = ""

  init(chord: Chord?, showCaption: Bool = true) {
    self.chord = chord
    self.showCaption = showCaption

    setCaptionText()
  }

  mutating func setCaptionText() { captionText = chord?.preciseName ?? "" }

  @ViewBuilder
  var body: some View {
    if showCaption {
      if let chord = chord {
        if chord.commonName != chord.preciseName && chord.chordType != .ma {
          TitleView(
            text: captionText,
            font: .caption
          )
        }
      }
    }
  }
}

#Preview {
  ChordSymbolCaptionView(chord: Chord(.c, .ma13omit9))
}
