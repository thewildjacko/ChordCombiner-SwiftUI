//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
  
  //  MARK: @State and instance variables
  @Bindable var multiChord: MultiChord = MultiChord(
    lowerChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    upperChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    lowerKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    upperKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    combinedKeyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  )
    
  var body: some View {
    VStack {
      Spacer()
      
      CustomChordMenuSelectedView(
        multiChord: multiChord,
        keyboard: $multiChord.lowerKeyboard,
        combinedKeyboard: $multiChord.combinedKeyboard,
        chordProperties: $multiChord.lowerChordProperties
      )
      
      Spacer()
      
      TitleView(text: "+", font: .largeTitle, weight: .heavy)
        .zIndex(1.0)
      
      Spacer()
      
      CustomChordMenuSelectedView(
        multiChord: multiChord,
        keyboard: $multiChord.upperKeyboard,
        combinedKeyboard: $multiChord.combinedKeyboard,
        chordProperties: $multiChord.upperChordProperties
      )
      
      Spacer()
      
      TitleView(text: "=", font: .largeTitle, weight: .heavy)
      
      Spacer()
      
      DualChordKeyboardView(
        multiChord: multiChord,
        keyboard: $multiChord.combinedKeyboard
      )
      
      Spacer()
    }
    .padding()
  }
}

#Preview {
  MultiChordKeyboardView()
}
