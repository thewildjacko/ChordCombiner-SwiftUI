//
//  USTMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct USTMenu: View {
  @Binding var upperStructureTriad: Triad
  
  var body: some View {
    VStack {
      Text("Upper Structure Triad")
      
      Menu(upperStructureTriad.name) {
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
      }
      .pickerStyle(.segmented)
    }
    .padding()
  }
}

#Preview {
  USTMenu(upperStructureTriad: Binding.constant(Triad()))
}
