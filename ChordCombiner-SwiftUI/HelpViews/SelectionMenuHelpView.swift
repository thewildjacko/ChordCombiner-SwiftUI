//
//  HelpView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/7/25.
//

import SwiftUI

struct SelectionMenuHelpView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var chordPropertyTab: ChordPropertyType = .letter

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Spacer()
        Button {
          dismiss()
        } label: {
          Text("Done")
        }
      }

      Text("Choosing A Chord")
        .font(.title)

      // swiftlint:disable:next line_length
        Text("To select a chord, tap to choose an option from each chord property picker.\n\nOnce both Lower & Upper chords are selected, the chord property options will highlight based on whether changing that property to the highlighted value for the current chord (i.e. the Lower Chord in the Lower Chord Menu) would cause that chord to match the other chord (i.e the Upper Chord in the Lower Chord Menu.")
        .font(.footnote)

      TabView(selection: $chordPropertyTab) {
        Group {
          SelectionMenuHelpTabContentView(chordPropertyType: .letter)
            .tabItem { Text("Letter Picker") }
            .tag("letter")

          SelectionMenuHelpTabContentView(chordPropertyType: .accidental)
            .tabItem { Text("Accidental Picker") }
            .tag("accidental")

          SelectionMenuHelpTabContentView(chordPropertyType: .chordType)
            .tabItem { Text("Chord Type Picker") }
            .tag("chordType")
        }
        .background(.primaryBackground)
      }
    }
    .foregroundStyle(.title)
    .padding(10)
    .background(.primaryBackground)
  }
}

#Preview(body: {
  SelectionMenuHelpView()
})
