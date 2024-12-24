//
//  GraphImagePlacerPyramidView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/24/24.
//

import SwiftUI

struct GraphImagePlacerPyramidView: View {
  let pianoKeysImage = Image(systemName: "pianokeys")
  let musicNoteImage = Image(systemName: "music.note")
  @Binding var progress: Double

  @ViewBuilder
  var body: some View {
    VStack {
      Spacer()

      VStack(spacing: 10) {
        pianoKeysImage
        GraphImagePlacerView(image: pianoKeysImage, columns: 3)
        GraphImagePlacerView(image: pianoKeysImage, columns: 5)
        GraphImagePlacerView(image: musicNoteImage, columns: 7, spacing: 20)
        Spacer()
        ProgressView(value: progress)

      }
      .frame(maxHeight: 80)
      .padding()

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.primaryBackground)
  }
}
