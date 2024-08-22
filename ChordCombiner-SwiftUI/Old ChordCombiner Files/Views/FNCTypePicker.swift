//
//  FNCTypePicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct FNCTypePicker: View {
  @Binding var type: FNCType
  
  var body: some View {
    Picker(selection: $type, label: Text("Type")) {
      ForEach(FNCType.allCases) { type in
        Text(type.rawValue).tag(type)
      }
    }
  }
}

#Preview {
  FNCTypePicker(type: Binding.constant(.dom7))
}
