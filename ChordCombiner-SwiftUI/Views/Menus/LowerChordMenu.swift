//
//  BaseChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct LowerChordMenu: View {
  @Binding var lowerChord: FourNoteChord
  var chordStore: ChordStore
  
  var body: some View {
      VStack {
        Text("Lower Chord")
        
        Menu(content: {
          Picker(selection: $lowerChord.letter, label: Text("")) {
            ForEach(Letter.allCases) { letter in
              Text(letter.rawValue).tag(letter)
            }
          }
          
          Picker(selection: $lowerChord.accidental, label: Text("")) {
            ForEach(Accidental.RootAcc.allCases) { accidental in
              Text(accidental.rawValue).tag(accidental)
            }
          }
          
          Picker(selection: $lowerChord.type, label: Text("")) {
            ForEach(FNCType.allCases) { type in
              Text(type.rawValue).tag(type)
            }
          }
        }, label: {
          Text("\(lowerChord.name)")
            .fixedSize(horizontal: true, vertical: true)
        })
        .pickerStyle(.segmented)
        .onChange(of: lowerChord) {
          chordStore.chordData.lowerChordData.letter = lowerChord.letter
          chordStore.chordData.lowerChordData.accidental = lowerChord.accidental
          chordStore.chordData.lowerChordData.type = lowerChord.type
          chordStore.chordData.lowerChordData.inversion = lowerChord.chordInversion
        }
        .onAppear(perform: {
          let lowerChordData = chordStore.loadChordsJSON().lowerChordData
          lowerChord = FourNoteChord(
            RootGen(
              lowerChordData.letter,
              lowerChordData.accidental
            ),
            lowerChordData.type,
            inversion: lowerChordData.inversion)
        })
      }
    }
}

#Preview {
  LowerChordMenu(lowerChord: Binding.constant(FourNoteChord()), chordStore: ChordStore())
}
