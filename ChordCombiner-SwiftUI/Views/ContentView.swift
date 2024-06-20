//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct ContentView: View {
  @State private var lowerChord = FourNoteChord()
  @State private var upperStructureTriad = Triad(.d, .ma, inversion: .root)
  @State private var resultChord = ResultChord(baseChord: FourNoteChord(), upStrctTriad: Triad(.d, .ma, inversion: .root))
  
  var result: ResultChord {
    ResultChord(baseChord: lowerChord, upStrctTriad: upperStructureTriad)
  }
  
  
  var body: some View {
    VStack {
      HStack {
        VStack {
          HStack {
            LetterPicker(letter: $lowerChord.letter)
//              .onChange(of: lowerChord) {
//                print(result.baseChord.name)
//              }
            AccidentalPicker(accidental: $lowerChord.accidental)
            FNCTypePicker(type: $lowerChord.type)
          }
          Text(lowerChord.name)
        }
        
        Spacer()
        
        VStack {
          HStack {
            LetterPicker(letter: $upperStructureTriad.letter)
            AccidentalPicker(accidental: $upperStructureTriad.accidental)
            TriadTypePicker(type: $upperStructureTriad.type)
          }
          Text(upperStructureTriad.name)
        }
        .padding()
      }
      .padding()
      
      Text(result.name)
    }
  }
}

#Preview {
  ContentView()
}
