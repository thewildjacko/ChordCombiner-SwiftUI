//
//  CustomChordMenuSelectedView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/15/24.
//

import SwiftUI

struct CustomChordMenuSelectedView: View {
  @EnvironmentObject var multiChord: MultiChord
  @State var chord: Chord? = nil
  
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

  
  @Binding var keyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: MultiChordProperties
  @Binding var oldChordProperties: MultiChordProperties
  
  var isLowerChordMenu: Bool {
    get { chordProperties == multiChord.lowerChordProperties ? true : false }
  }
  
  var body: some View {
    VStack {
      TitleView(text: text, font: .headline, weight: .heavy, isMenuTitle: false)
      
      NavigationLink(
        destination:
          CustomChordMenu(
            selectedKeyboard: $keyboard,
            combinedKeyboard: $combinedKeyboard,
            chordProperties: $chordProperties,
            oldChordProperties: $oldChordProperties
          )
          .navigationTitle(text)
          .navigationBarTitleDisplayMode(.inline)
          .environmentObject(multiChord)
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
    keyboard:
        .constant(
          Keyboard(
            geoWidth: 330,
            initialKey: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5
      )
    ),
    chordProperties: .constant(MultiChordProperties(letter: nil, accidental: nil, chordType: nil)),
    oldChordProperties: .constant(MultiChordProperties(letter: nil, accidental: nil, chordType: nil))
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: MultiChordProperties(letter: nil, accidental: nil, chordType: nil),
      upperChordProperties: MultiChordProperties(letter: nil, accidental: nil, chordType: nil)
    )
  )
}
