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
        DualKeyboardHelpView(keyboard: keyboard)
          .presentationDetents([.fraction(0.25)])
          .presentationBackground(.thinMaterial)
      }
    }
  }
}

struct DualChordKeyboardView: View {
  @State var shouldPresentDualKeyboardHelpView = false
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()
  @Binding var keyboard: Keyboard
  var chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel?

  @ViewBuilder
  var body: some View {
    VStack(spacing: 20) {
      ZStack {
        DualChordTitleHelpViewBuilder(
          shouldPresentDualKeyboardHelpView: $shouldPresentDualKeyboardHelpView,
          keyboard: keyboard)

        DualChordTitleViewBuilder()
      }

      keyboard
    }
  }
}

#Preview() {
  DualChordKeyboardView(
    keyboard: .constant(Keyboard.initialDualChordKeyboard))
}
