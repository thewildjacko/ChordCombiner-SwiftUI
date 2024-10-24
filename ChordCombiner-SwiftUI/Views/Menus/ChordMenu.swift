//
//  BaseChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordMenu: View {
//  @EnvironmentObject var multiChord: MultiChord
  var text: String
  @Binding var chord: Chord
  @Binding var keyboard: Keyboard
  //  var chordStore: ChordStore
  
  var body: some View {
    VStack {
      TitleView(text: text, font: .headline, weight: .heavy)
      
      Menu(content: {
        LetterPicker(letter: $chord.letter)
        AccidentalPicker(accidental: $chord.accidental)
        ChordTypePicker(chord: $chord, chordType: $chord.chordType)
      }, label: {
        VStack {
          TitleView(
            text: chord.chordType == .ma ? chord.root.noteName : chord.preciseName,
            font: .headline,
            weight: .heavy,
            isMenuTitle: true
          )
          
          keyboard
        }
      })
      //        .onChange(of: chord) {
      //          chordStore.chordData.chord = chord
      ////          print("lower chord is: \(chord)")
      //        }
      //        .onAppear(perform: {
      //          chord = chordStore.loadChordsJSON().chord
      ////          print("lower chord is: \(chord)")
      //        })
    }
  }
}

#Preview {
  ChordMenu(
    text: "Lower Chord",
    chord: Binding.constant(Chord(.c, .ma13_sh11)),
    keyboard: Binding.constant(
      Keyboard(
        geoWidth: 187,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 2))
    /*, chordStore: ChordStore()*/)
//  .environmentObject(
//    MultiChord(
//      lowerChord: Chord(.c, .ma7, startingOctave: 4),
//      upperChord: Chord(.d, .ma, startingOctave: 4)
//    ))
}
