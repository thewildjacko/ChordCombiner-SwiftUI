//
//  AccidentalPicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct AccidentalPicker: View {
  @Binding var accidental: RootAccidental
  
  var body: some View {
    Picker(selection: $accidental, label: Text("")) {
      ForEach(Accidental.RootAccidental.allCases) { accidental in
        Text(accidental.rawValue).tag(accidental)
      }
    }
    .pickerStyle(.segmented)
  }
}

#Preview {
    AccidentalPicker(accidental: Binding.constant(.natural))
}
