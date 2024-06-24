//
//  USTMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct USTMenu: View {
  @Binding var upperStructureTriad: Triad
  var chordStore: ChordStore
  
  var body: some View {
    VStack {
      Text("Upper Structure Triad")
      
      Menu(content: {
        Picker(selection: $upperStructureTriad.letter, label: Text("")) {
          ForEach(Letter.allCases) { letter in
            Text(letter.rawValue).tag(letter)
          }
        }
        
        Picker(selection: $upperStructureTriad.accidental, label: Text("")) {
          ForEach(Accidental.RootAcc.allCases) { accidental in
            Text(accidental.rawValue).tag(accidental)
          }
        }
        
        Picker(selection: $upperStructureTriad.type, label: Text("")) {
          ForEach(TriadType.allCases) { type in
            Text(type.rawValue).tag(type)
          }
        }
      }, label: {
        Text("\(upperStructureTriad.name)")
          .fixedSize(horizontal: true, vertical: true)
      })
      .pickerStyle(.segmented)
      .onChange(of: upperStructureTriad) {
        chordStore.chordData.ustData.letter = upperStructureTriad.letter
        chordStore.chordData.ustData.accidental = upperStructureTriad.accidental
        chordStore.chordData.ustData.type = upperStructureTriad.type
        chordStore.chordData.ustData.inversion = upperStructureTriad.chordInversion
      }
      .onAppear(perform: {
        let ustData = chordStore.loadChordsJSON().ustData
        upperStructureTriad = Triad(
          RootGen(
            ustData.letter,
            ustData.accidental
          ),
          ustData.type,
          inversion: ustData.inversion
        )
      })
    }
    .padding()
  }
}

#Preview {
  USTMenu(upperStructureTriad: Binding.constant(Triad()), chordStore: ChordStore())
}
