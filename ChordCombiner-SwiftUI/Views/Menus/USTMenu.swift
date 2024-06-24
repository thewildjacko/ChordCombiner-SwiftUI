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
        chordStore.chordData.triad = upperStructureTriad
        print("triad is: \(upperStructureTriad)")
      }
      .onAppear(perform: {
        upperStructureTriad = chordStore.loadChordsJSON().triad
        print("triad is: \(upperStructureTriad)")
      })
    }
    .padding()
  }
}

#Preview {
  USTMenu(upperStructureTriad: Binding.constant(Triad()), chordStore: ChordStore())
}
