//
//  BaseChordSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct BaseChordSectionView: View {
  var keyboardWidth: CGFloat = 351
  var chord: Chord?
  var baseChord: Chord { chord?.getBaseChord() ?? .initial }

  @ViewBuilder
    var body: some View {
      if chord != baseChord {
        Section(header: Text("Base Chord")) {
          SingleChordDetailNavigationView(
            keyboardWidth: keyboardWidth,
            chord: baseChord,
            color: .lowerChordHighlight,
            labelType: .title)
          if baseChord.preciseName != baseChord.commonName {
            DetailRow(title: "Precise Name", text: baseChord.displayDetails(detailType: .preciseName))
          }
          DetailRow(title: "Notes", text: baseChord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: baseChord.displayDetails(detailType: .degreeNames))
        }
      }
    }
}

#Preview {
  BaseChordSectionView(chord: Chord(.c, .ma9))
}
