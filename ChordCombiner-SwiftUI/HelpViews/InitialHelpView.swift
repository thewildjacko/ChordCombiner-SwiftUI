//
//  InitialHelpView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/8/25.
//

import SwiftUI

struct InitialHelpView: View {
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
      // swiftlint:disable:next line_length
      Text("ChordCombiner is a chord calculator that combines the notes of two 3- or 4-note chords and returns one of 3 results:")

      VStack(alignment: .leading, spacing: 10) {
        Text("1. A unified chord (single chord symbol, no alternate bass), e.g. Cma13(♯11)")
        Text("2. A slash chord (single chord symbol over an alternate bass), e.g Fma7(♯11/C)")
        Text("3. A polychord (two chord symbols, one over the other), e.g Ema/Cma7")
      }
      .padding(.leading, 20)
      .padding(.trailing, 10)

      Text("To get started, tap the lower or upper keyboards or their titles to open the Chord Selection Menu.")

      HStack(alignment: .top, spacing: 0) {
        Text("Tap \(Image(systemName: "info.circle")) next to a chord symbol for more information")
      }

      Spacer()
    }
    .foregroundStyle(.title)
    .padding()
  }
}
