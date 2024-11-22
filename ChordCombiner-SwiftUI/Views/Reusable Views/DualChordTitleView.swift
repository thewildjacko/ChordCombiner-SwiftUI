//
//  DualChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordTitleView: View {
  let chordCombinerViewModel: ChordCombinerViewModel
  var titleText: String
  var titleFont: Font
  
  var body: some View {    
    VStack(spacing: 5) {
      TitleView(
        text: titleText,
        font: titleFont,
        weight: .heavy
      )
      
      ChordSymbolCaptionView(chord: chordCombinerViewModel.resultChord)
    }
  }
}
