//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordTitleHelpViewBuilder: View {
  @Binding var shouldPresentDualKeyboardHelpView: Bool
  var keyboard: Keyboard

  var body: some View {
    HStack {
      Spacer()
      Button {
        shouldPresentDualKeyboardHelpView.toggle()
      } label: {
        Image(systemName: "questionmark.circle")
          .padding(.trailing, 10)
      }
      .sheet(isPresented: $shouldPresentDualKeyboardHelpView) {
        CombinedKeyboardHelpView(keyboard: keyboard)
          .presentationDetents([.fraction(0.25)])
          .presentationBackground(.thinMaterial)
      }
    }
  }
}

struct DualChordKeyboardView: View {
  @State var shouldPresentDualKeyboardHelpView = false
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()
  var chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel?

  @ViewBuilder
  var body: some View {
    VStack(spacing: 20) {
      ZStack {
        if chordCombinerViewModel.lowerChord != nil && chordCombinerViewModel.upperChord != nil {
          DualChordTitleHelpViewBuilder(
            shouldPresentDualKeyboardHelpView: $shouldPresentDualKeyboardHelpView,
            keyboard: chordCombinerViewModel.combinedKeyboard)
        }

        DualChordTitleViewBuilder()
      }

      chordCombinerViewModel.combinedKeyboard
    }
  }
}

#Preview() {
  DualChordKeyboardView()
}
