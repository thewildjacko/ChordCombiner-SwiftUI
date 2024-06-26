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
          chordStore.chordData.lowerChord = lowerChord
//          print("lower chord is: \(lowerChord)")
        }
        .onAppear(perform: {
          lowerChord = chordStore.loadChordsJSON().lowerChord
//          print("lower chord is: \(lowerChord)")
        })
        
      }
    }
}

#Preview {
  LowerChordMenu(lowerChord: Binding.constant(FourNoteChord()), chordStore: ChordStore())
}
