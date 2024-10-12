//
//  AccidentalTagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct AccidentalTagsView: View {
  var chord = Chord(.c, .ma7)
  @Binding var selectedAccidental: RootAccidental
  
  var body: some View {
    HStack {
      ForEach(RootAccidental.allCases, id: \.self) { accidental in
        HighlightableTagView(
          text: accidental.rawValue,
          highlightCondition: selectedAccidental == accidental,
          stroke: chord.combinesWith(chordFrom: accidental) ? .title : .clear
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
