//
//  GraphHelpView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/9/25.
//

import SwiftUI

struct GraphHelpView: View {
  @Environment(\.dismiss) private var dismiss

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

      Text("The Chord Graph shows a map of chords contained within the selected parent.")
      Text("From the top, the possible levels are as follows:")

      BulletList(
        bulletPoints: [
          BulletPoint(
            text: "The parent chord",
            bulletStyle: .dash,
            indentation: 20),
          BulletPoint(
            text: "All simple 4-note chords contained within the parent chord",
            bulletStyle: .dash,
            indentation: 20),
          BulletPoint(
            text: "All triads contained within each 4-note simple chord",
            bulletStyle: .dash,
            indentation: 20),
          BulletPoint(
            text: "All notes contained within each triad",
            bulletStyle: .dash,
            indentation: 20)
          ])

      Text("If a level contains no elements, that level will be absent.")

      // swiftlint:disable:next line_length
      Text("If a chord contains no connections to chords in the level immediately below, it may look for connections in the next level down.")

      Spacer()
    }
    .foregroundStyle(.title)
    .padding()
    .edgesIgnoringSafeArea(.all)
  }
}
