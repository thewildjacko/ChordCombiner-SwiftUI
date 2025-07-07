//
//  ExtendedNotesSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/22/24.
//

import SwiftUI

struct ExtendedNotesSectionView: View {
  var chord: Chord
  var baseChord: Chord { chord.getBaseChord() }

  @ViewBuilder
    var body: some View {
      if chord != baseChord {
        Section(header: Text("Extensions")) {
          DetailRow(
            title: "Notes",
            text: chord.getExtensions().noteNames().joined(separator: ", "))
          DetailRow(
            title: "Degrees",
            text: chord.getExtensionDegreeNames().numeric.joined(separator: ", "))
        }
      }
    }
}
