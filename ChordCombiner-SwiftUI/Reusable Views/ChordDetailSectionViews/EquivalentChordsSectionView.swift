//
//  EquivalentChordsSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/17/24.
//

import SwiftUI

struct EquivalentChordsSectionView: View {
  let chord: Chord?

  @ViewBuilder
    var body: some View {
      if let chord = chord {
        if !chord.getEquivalentChords().isEmpty {
          Section(header: Text("Equivalent Chords")) {
            List {
              ForEach(chord.getEquivalentChords()) { chord in
                TitleView(text: chord.preciseName, font: .headline)
              }
            }
          }
        }
      }
    }
}

#Preview {
  EquivalentChordsSectionView(chord: Chord(.c, .ma13sh11))
}
