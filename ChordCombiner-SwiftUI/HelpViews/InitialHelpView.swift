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

      Text("Tap the lower or upper keyboards or their titles to open the Chord Selection Menu.")

      HStack(alignment: .top, spacing: 0) {
        Text("Tap \(Image(systemName: "info.circle")) next to a chord symbol for more information")
      }

      Spacer()
    }
    .foregroundStyle(.title)
    .padding()
  }
}
