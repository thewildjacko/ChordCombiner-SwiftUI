//
//  LettersView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

/**
 A view to let users select the ``Letter`` of the displayed `Chords.`
 - Parameter selectedLetter: binding var to choose the ``Letter``
 - Note: This does not affect the accidental (i.e. ``RootAccidental``); accidental selection is handled by a separate ``AccidentalsView``. Only one ``Letter`` can be selected at a time.
 - SeeAlso: ``Letter``
 
 */
struct LettersView: View {
  @Binding var selectedLetter: Letter
  
  var body: some View {
    HStack {
      ForEach(Letter.allCases, id: \.self) { letter in
        Text(letter.rawValue)
          .tagView(condition: selectedLetter == letter)
          .onTapGesture {
            selectedLetter = letter
          }
      }
      .font(.caption)
    }
  }
}

#Preview {
  LettersView(selectedLetter: Binding.constant(.c))
}
