//
//  NotesAndDegreesSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/21/24.
//

import SwiftUI

struct NotesAndDegreesSectionView: View {
  let notesText: String
  let degreesText: String
  @Binding var chordGrapherNavigationView: ChordGrapherNavigationView

  var body: some View {
    List {
      DetailRow(title: "Notes", text: notesText)
      DetailRow(title: "Degrees", text: degreesText)
      chordGrapherNavigationView
    }
  }
}

struct ScaleNotesAndDegreesSectionView: View {
  let notesText: String
  let degreesText: String

  var body: some View {
    List {
      DetailRow(title: "Notes", text: notesText)
      DetailRow(title: "Degrees", text: degreesText)
    }
  }
}
