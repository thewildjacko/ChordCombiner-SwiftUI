//
//  ScaleDetailForm.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/21/25.
//

import SwiftUI

struct ScaleDetailForm: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()
  var scale: Scale
  @State var modes: [Scale] = []

  @ViewBuilder
  var body: some View {
    Form {
      NotesDegreesAndModesDetailView(
        scale: scale,
        keyboardWidth: chordCombinerViewModel.lowerKeyboard.width,
        modes: $modes)
      .onAppear {
        Task {
          await modes = scale.getModes()
        }
      }
    }
    .scrollContentBackground(.hidden)
    .background(.primaryBackground)
  }
}
