//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var chordCombinerViewModel = ChordCombinerViewModel.singleton()
  @Binding var keyboard: Keyboard

  var body: some View {
    VStack(spacing: 20) {
      DualChordTitleViewBuilder()

      keyboard
    }
  }
}

#Preview() {
  DualChordKeyboardView(keyboard: .constant(Keyboard.initialDualChordKeyboard))
}
