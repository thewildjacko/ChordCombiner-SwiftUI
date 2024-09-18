//
//  DetailRow.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/17/24.
//

import SwiftUI

struct DetailRow: View {
  var title: String
  var text: String
  
  var body: some View {
    HStack {
      Text(title)
        .fontWeight(.bold)
      Spacer()
      Text(text)
    }
  }
}

#Preview {
  DetailRow(title: "Notes", text: "C, E, G")
}
