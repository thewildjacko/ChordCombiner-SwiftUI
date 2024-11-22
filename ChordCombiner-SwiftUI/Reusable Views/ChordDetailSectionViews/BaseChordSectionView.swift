//
//  BaseChordSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct BaseChordSectionView: View {
  var chord: Chord
  var baseChord: Chord { chord.getBaseChord() }

  @ViewBuilder
    var body: some View {
      if chord != baseChord {
        Section(header: Text("Base Chord")) {
          DetailRow(title: "Name", text: baseChord.displayDetails(detailType: .commonName))
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
