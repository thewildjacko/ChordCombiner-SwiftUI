//
//  ChordTypePicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordTypePicker: View {
  @Binding var chord: Chord
  @Binding var type: ChordType
  
  var body: some View {
    Picker(selection: $type, label: Text("Chord Type")) {
      ForEach(ChordType.allCases.sorted()) { type in
        Text("\(chord.root.noteName)\(type.name)").tag(type)
      }
    }
    .pickerStyle(.menu)
  }
}

#Preview {
  ChordTypePicker(chord: Binding.constant(Chord(type: .ma)), type: Binding.constant(.ma))
}
