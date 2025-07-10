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
  var color: Color = .title

  var body: some View {
    HStack {
      TitleView(
        text: title,
        font: .body,
        weight: .bold,
        color: color)

      Spacer()

      TitleView(
        text: text,
        font: .body,
        weight: .regular,
        color: color)
    }
  }
}

#Preview {
  DetailRow(title: "Notes", text: "C, E, G")
}
