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
    lowerChordProperties: ChordProperties.initial,
    upperChordProperties: ChordProperties.initial,
    lowerKeyboard: Keyboard.initialSingleChordKeyboard,
    upperKeyboard: Keyboard.initialSingleChordKeyboard,
    combinedKeyboard: Keyboard.initialDualChordKeyboard
  )
    
  var body: some View {
    NavigationStack {
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
      .navigationTitle("Chord Combiner")
    }
  }
}

#Preview {
  ChordCombinerView()
}
