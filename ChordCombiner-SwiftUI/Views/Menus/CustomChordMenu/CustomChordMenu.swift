//
//  CustomChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct CustomChordMenu: View {
  @EnvironmentObject var multiChord: MultiChord
  var text: String
  @Binding var chord: Chord
  @Binding var keyboard: Keyboard
  
  var body: some View {
    VStack {
      VStack(spacing: 15) {
        TitleView(text: text, font: .headline, weight: .heavy)
        
        TitleView(
          text: chord.type == .ma ? chord.root.noteName : chord.preciseName,
          font: .title3,
          weight: .heavy,
          isMenuTitle: true
        )
        
        keyboard
      }
      
      
      
      //      Menu(content: {
      //        LetterPicker(letter: $chord.letter)
      //        AccidentalPicker(accidental: $chord.accidental)
      //        ChordTypePicker(chord: $chord, type: $chord.type)
      //      }, label: {
      //        VStack {
      //          TitleView(
      //            text: chord.type == .ma ? chord.root.noteName : chord.preciseName,
      //            font: .headline,
      //            weight: .heavy,
      //            isMenuTitle: true
      //          )
      //
      //          keyboard
      //        }
      //      })
    }
  }
}

#Preview {
  CustomChordMenu(
    text: "Lower Chord",
    chord: Binding.constant(Chord(.c, .ma13_sh11)),
    keyboard: Binding.constant(
      Keyboard(
        geoWidth: 187,
        initialKey: .C,
        startingOctave: 4,
        octaves: 2
      )
    )
  )
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    )
  )
}
