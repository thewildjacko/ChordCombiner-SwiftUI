//
//  BaseChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct BaseChordMenu: View {
  @Binding var lowerChord: FourNoteChord
  
  var body: some View {
      VStack {
        Text("Base Chord")
        Menu(lowerChord.name) {
          Picker(selection: $lowerChord.letter, label: Text("")) {
            ForEach(Letter.allCases) { letter in
              Text(letter.rawValue).tag(letter)
            }
          }
          .pickerStyle(.segmented)
          
          Picker(selection: $lowerChord.accidental, label: Text("")) {
            ForEach(Accidental.RootAcc.allCases) { accidental in
              Text(accidental.rawValue).tag(accidental)
            }
          }
          .pickerStyle(.segmented)
          
          Picker(selection: $lowerChord.type, label: Text("")) {
            ForEach(FNCType.allCases) { type in
              Text(type.rawValue).tag(type)
            }
          }
        }
        .pickerStyle(.segmented)
      }
    }
}

#Preview {
  BaseChordMenu(lowerChord: Binding.constant(FourNoteChord()))
}
