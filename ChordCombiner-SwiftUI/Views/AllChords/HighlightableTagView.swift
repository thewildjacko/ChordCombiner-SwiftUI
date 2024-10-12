//
//  HighlightableTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/11/24.
//

import SwiftUI

struct HighlightableTagView: View {
  let text: String
  var highlightCondition: Bool
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var stroke: Color = .clear
  
  var body: some View {
    Text(text)
      .highlightableTagView(
        highlightCondition: highlightCondition,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        stroke: stroke
      )
  }
}

#Preview {
  HighlightableTagView(text: "Cma7", highlightCondition: true)
}
