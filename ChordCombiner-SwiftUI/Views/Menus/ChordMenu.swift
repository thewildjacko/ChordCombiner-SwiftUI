//
//  BaseChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordMenu: View {
  @EnvironmentObject var multiChord: MultiChord
  var text: String
  @Binding var chord: Chord
  @Binding var keyboard: Keyboard
//  var chordStore: ChordStore
  
  var body: some View {
      VStack {
        Text(text)
          .font(.headline)
//          .font(.title)
          .fontWeight(.heavy)
          .fixedSize()
          .foregroundStyle(Color("titleColor"))
        
        Menu(content: {
          LetterPicker(letter: $chord.letter)
          AccidentalPicker(accidental: $chord.accidental)
          ChordTypePicker(chord: $chord, type: $chord.type)
        }, label: {
          VStack {
            Text("\(chord.name)")
              .font(.headline)
//              .font(.title)
              .fontWeight(.heavy)
              .fixedSize(horizontal: true, vertical: true)
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
        initialKey: .C,
        startingOctave: 4,
        octaves: 2))
    /*, chordStore: ChordStore()*/)
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    ))
}
