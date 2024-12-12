//
//  AccidentalTagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct AccidentalTagsView: View {
  @Binding var selectedAccidental: RootAccidental
  
  var body: some View {
    HStack {
      ForEach(RootAccidental.allCases, id: \.self) { accidental in
        HighlightableTagView(
          text: accidental.rawValue,
          highlightCondition: selectedAccidental == accidental
        )
        .onTapGesture {
          selectedAccidental = accidental
        }
      }
    }
  }
}


#Preview {
  AccidentalTagsView(selectedAccidental: Binding.constant(.natural))
}
