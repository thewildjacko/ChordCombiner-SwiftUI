//
// ChordSymbolCaptionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//


import SwiftUI

struct ChordSymbolCaptionView: View {
  let chord: Chord?
  
  var captionText: String {
    if let chord = chord {
      return "(\(chord.preciseName))"
    } else { return "" }
  }
  
  @ViewBuilder
  var body: some View {
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

#Preview {
  ChordSymbolCaptionView(chord: Chord(.c, .ma13_omit9))
}
