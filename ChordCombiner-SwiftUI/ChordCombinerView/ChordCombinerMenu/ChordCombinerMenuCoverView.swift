//
//  ChordCombinerMenuCoverView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct ChordCombinerMenuCoverView: View {
  var chordCombinerViewModel: ChordCombinerViewModel
  
  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  
  var chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel {
    ChordCombinerSelectedChordTitleModel(chordCombinerViewModel: chordCombinerViewModel, chordProperties: chordProperties)
  }
  
  var body: some View {
    VStack {
      TitleView(text: chordCombinerSelectedChordTitleModel.promptText, font: .headline, weight: .heavy, isMenuTitle: false)
      
      NavigationLink(
        destination:
          ChordCombinerChordSelectionMenu(
            chordCombinerViewModel: chordCombinerViewModel,
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties
          )
          .navigationTitle(chordCombinerSelectedChordTitleModel.promptText)
          .navigationBarTitleDisplayMode(.inline)
      ) {
        VStack(spacing: 15) {
            TitleView(
              text: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
              weight: .heavy,
              color: .button
            )
          
          keyboard
        }
      }
    }
  }
}

#Preview {
  ChordCombinerMenuCoverView(
    chordCombinerViewModel: ChordCombinerViewModel(),
    keyboard:
        .constant(
          Keyboard(
            baseWidth: 330,
            initialKeyType: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 5
      )
    ),
    chordProperties: .constant(ChordProperties(letter: nil, accidental: nil, chordType: nil))
  )
}
