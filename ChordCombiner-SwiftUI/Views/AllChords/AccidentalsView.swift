//
//  AccidentalsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct AccidentalsView: View {
  @Binding var selectedAccidental: RootAccidental
  
  var body: some View {
    HStack {
      ForEach(RootAccidental.allCases, id: \.self) { accidental in
        Text(accidental.rawValue)
          .tagView(condition: selectedAccidental == accidental)
          .onTapGesture {
            selectedAccidental = accidental
          }
      }
      .font(.caption)
    }
  }
}


#Preview {
  AccidentalsView(selectedAccidental: Binding.constant(.natural))
}
