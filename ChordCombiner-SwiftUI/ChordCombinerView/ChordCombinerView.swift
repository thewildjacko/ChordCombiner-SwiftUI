//
//  ChordCombinerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct ChordCombinerView: View {
  
  //  MARK: @State and instance variables
  @Bindable var chordCombinerViewModel: ChordCombinerViewModel = ChordCombinerViewModel(
    lowerChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    upperChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    lowerKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    upperKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    combinedKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  )
    
  var body: some View {
    VStack {
      Spacer()
      
      ChordCombinerMenuCoverView(
        chordCombinerViewModel: chordCombinerViewModel,
        keyboard: $chordCombinerViewModel.lowerKeyboard,
        combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
        chordProperties: $chordCombinerViewModel.lowerChordProperties
      )
      
      Spacer()
      
      TitleView(text: "+", font: .largeTitle, weight: .heavy)
        .zIndex(1.0)
      
      Spacer()
      
      ChordCombinerMenuCoverView(
        chordCombinerViewModel: chordCombinerViewModel,
        keyboard: $chordCombinerViewModel.upperKeyboard,
        combinedKeyboard: $chordCombinerViewModel.combinedKeyboard,
        chordProperties: $chordCombinerViewModel.upperChordProperties
      )
      
      Spacer()
      
      TitleView(text: "=", font: .largeTitle, weight: .heavy)
      
      Spacer()
      
      DualChordKeyboardView(
        chordCombinerViewModel: chordCombinerViewModel,
        keyboard: $chordCombinerViewModel.combinedKeyboard
      )
      
      Spacer()
    }
    .padding()
  }
}

#Preview {
  ChordCombinerView()
}
