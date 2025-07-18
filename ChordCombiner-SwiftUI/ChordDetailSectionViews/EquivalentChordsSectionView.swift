//
//  EquivalentChordsSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/17/24.
//

import SwiftUI

struct EquivalentChordsSectionView: View {
  var keyboardWidth: CGFloat = 351
  let chord: Chord

  @ViewBuilder
  var body: some View {
    if !chord.getEquivalentChords().isEmpty {
      Section(header: Text("Equivalent Chords")) {
        List {
          ForEach(chord.getEquivalentChords()) { chord in
            SingleChordDetailNavigationView(
              keyboardWidth: keyboardWidth,
              chord: chord,
              color: .lowerChordHighlight,
              labelType: .title)
          }
        }
      }
    }
  }
}

#Preview {
  EquivalentChordsSectionView(chord: Chord(.c, .ma13sh11))
}
