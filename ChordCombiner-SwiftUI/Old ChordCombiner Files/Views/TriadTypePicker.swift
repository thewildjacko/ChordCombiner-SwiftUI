//
//  TriadTypePicker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct TriadTypePicker: View {
  @Binding var type: TriadType
  
  var body: some View {
    Picker(selection: $type, label: Text("Type")) {
      ForEach(TriadType.allCases) { type in
        Text(type.rawValue).tag(type)
      }
    }
  }
}

#Preview {
  TriadTypePicker(type: Binding.constant(.ma))
}
