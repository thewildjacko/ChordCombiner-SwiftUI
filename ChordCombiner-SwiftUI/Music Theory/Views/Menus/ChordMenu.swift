//
//  BaseChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordMenu: View {
  var text: String
  @Binding var chord: Chord
//  var chordStore: ChordStore
  
  var body: some View {
      VStack {
        Text(text)
        
        Menu(content: {
          LetterPicker(letter: $chord.letter)
          AccidentalPicker(accidental: $chord.accidental)
          ChordTypePicker(chord: $chord, type: $chord.type)
        }, label: {
          Text("\(chord.name)")
            .fixedSize(horizontal: true, vertical: true)
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
  ChordMenu(text: "Lower Chord", chord: Binding.constant(Chord(.c, .ma13_sh11))/*, chordStore: ChordStore()*/)
}
