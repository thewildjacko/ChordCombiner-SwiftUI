//
//  AccidentalPicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct AccidentalPicker: View {
  @Binding var accidental: RootAcc
  
  var body: some View {
    Picker(selection: $accidental, label: Text("Accidental")) {
      ForEach(Accidental.RootAcc.allCases) { accidental in
        Text(accidental.rawValue).tag(accidental)
      }
    }
  }
}

#Preview {
    AccidentalPicker(accidental: Binding.constant(.natural))
}
