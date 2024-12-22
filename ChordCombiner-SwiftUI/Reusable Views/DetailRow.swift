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
      TitleView(
        text: title,
        font: .body,
        weight: .bold)

      Spacer()

      TitleView(
        text: text,
        font: .body,
        weight: .regular)
    }
  }
}

#Preview {
  DetailRow(title: "Notes", text: "C, E, G")
}
