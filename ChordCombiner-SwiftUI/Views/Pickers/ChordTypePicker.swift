//
//  ChordTypePicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordTypePicker: View {
  @Binding var chord: Chord
  @Binding var chordType: ChordType
  
  var body: some View {
    Picker(selection: $chordType, label: Text("Chord Type")) {
      ForEach(ChordType.allChordTypesMinusOmitsSorted) { chordType in
        Text("\(chord.root.noteName)\(chordType.rawValue)")
          .tag(chordType)
      }
//      ForEach(ChordType.allSimpleChordTypesMinusOmits, id: \.self) { chordTypeArray in
//        ForEach(chordTypeArray) { chordType in
//          Text("\(chord.root.noteName)\(chordType.rawValue)").tag(chordType)
//        }
//        Divider()
//      }
    }
    .pickerStyle(.menu)
  }
}

#Preview {
  ChordTypePicker(chord: Binding.constant(Chord(chordType: .ma)), chordType: Binding.constant(.ma))
}
