//
//  LetterPicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct LetterPicker: View {
  @Binding var letter: Letter
  
  var body: some View {
    Picker(selection: $letter, label: Text("")) {
      ForEach(Letter.allCases) { letter in
        Text(letter.rawValue).tag(letter)
      }
    }
    .pickerStyle(.segmented)
  }
}

#Preview {
  LetterPicker(letter: Binding.constant(.c))
}
