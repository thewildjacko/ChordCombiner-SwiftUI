//
//  ChordDetailForm.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/21/24.
//

import SwiftUI

struct ChordDetailForm: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()

  var notesText: String
  var degreesText: String
  var chord: Chord?
  var isDualChordDetailView: Bool = true

  @Binding var chordGrapher: ChordGrapher?
  @Binding var chordGrapherNavigationView: ChordGrapherNavigationView

  var body: some View {
    Form {
      NotesAndDegreesSectionView(
        notesText: notesText,
        degreesText: degreesText,
        chordGrapherNavigationView: $chordGrapherNavigationView)

      ComponentChordsView(isDualChordDetailView: isDualChordDetailView)

      BaseChordSectionView(
        keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
        chord: chord)
      ExtendedNotesSectionView(chord: chord)

      EquivalentChordsSectionView(
        keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
        chord: chord)
    }
    .scrollContentBackground(.hidden)
    .background(.primaryBackground)
  }
}
