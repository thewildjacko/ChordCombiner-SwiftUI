//
//  CustomChordMenuSelectedView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct CustomChordMenuSelectedView: View {
  var multiChord: MultiChord
  @State var chord: Chord? = nil
  
  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  
  var text: String {
    isLowerChordMenu ? "Select Lower Chord" : "Select Upper Chord"
  }
  
  var chordSymbolTitleFont: Font {
    isLowerChordMenu ?
    multiChord.lowerChord != nil ?
      .largeTitle : .headline :
    multiChord.upperChord != nil ?
      .largeTitle : .headline
  }
  
  var isLowerChordMenu: Bool {
    get { chordProperties == multiChord.lowerChordProperties ? true : false }
  }
  
  var body: some View {
    VStack {
      TitleView(text: text, font: .headline, weight: .heavy, isMenuTitle: false)
      
      NavigationLink(
        destination:
          CustomChordMenu(
            multiChord: multiChord,
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties
          )
          .navigationTitle(text)
          .navigationBarTitleDisplayMode(.inline)
      ) {
        VStack(spacing: 15) {
            TitleView(
              text: multiChord.singleChordTitle(forLowerChord: isLowerChordMenu),
              font: chordSymbolTitleFont,
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
            geoWidth: 330,
            initialKeyType: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 5
      )
    ),
    chordProperties: .constant(ChordProperties(letter: nil, accidental: nil, chordType: nil))
  )
}
