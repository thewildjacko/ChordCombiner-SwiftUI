//
//  CustomChordMenuSelectedView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct CustomChordMenuSelectedView: View {
  var multiChord: MultiChord
  
  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  
  var customChordMenuSelectedChordTitleModel: CustomChordMenuSelectedChordTitleModel {
    CustomChordMenuSelectedChordTitleModel(multiChord: multiChord, chordProperties: chordProperties)
  }
  
  var body: some View {
    VStack {
      TitleView(text: customChordMenuSelectedChordTitleModel.promptText, font: .headline, weight: .heavy, isMenuTitle: false)
      
      NavigationLink(
        destination:
          CustomChordMenu(
            multiChord: multiChord,
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties
          )
          .navigationTitle(customChordMenuSelectedChordTitleModel.promptText)
          .navigationBarTitleDisplayMode(.inline)
      ) {
        VStack(spacing: 15) {
            TitleView(
              text: customChordMenuSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: customChordMenuSelectedChordTitleModel.chordSymbolTitleFont,
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
  CustomChordMenuSelectedView(
    multiChord: MultiChord(),
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
