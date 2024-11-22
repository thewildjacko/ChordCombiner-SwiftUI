//
//  KeyboardEquatableTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/20/24.
//

import SwiftUI

struct KeyboardEquatableTestView: View {
  @State var keyboard: Keyboard = Keyboard(baseWidth: 351, octaves: 1)

  var body: some View {
    keyboard
//      .equatable()
    
    Button {
      keyboard.highlightKeys(pitches: [62], color: .lowerChordHighlight)
    } label: {
      Text("Highlight key")
    }

    Button {
      keyboard.clearAndHighlightKeys(pitches: [62], color: .red)
    } label: {
      Text("Highlight key")
    }
  }
}

#Preview {
    KeyboardEquatableTestView()
}
