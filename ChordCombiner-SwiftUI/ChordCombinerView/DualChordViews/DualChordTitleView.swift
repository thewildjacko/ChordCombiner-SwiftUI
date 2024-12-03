//
//  DualChordTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordTitleView: View {
  let chordCombinerViewModel: ChordCombinerViewModel
  let titleText: String
  let titleFont: Font
  var showCaption: Bool = true
  
  var body: some View {    
    VStack(spacing: 5) {
      TitleView(
        text: titleText,
        font: titleFont,
        weight: .heavy
      )
      
      ChordSymbolCaptionView(chord: chordCombinerViewModel.resultChord, showCaption: showCaption)
    }
  }
}
