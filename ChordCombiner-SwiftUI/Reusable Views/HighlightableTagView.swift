//
//  HighlightableTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/11/24.
//

import SwiftUI

struct HighlightableTagView: View, Equatable {
  let text: String
  var highlightCondition: Bool
  var highlightColor: Color = .tagBackgroundHighlighted
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var glowColor: Color = .clear
  var glowRadius: CGFloat = 0

  init(
    text: String,
    highlightCondition: Bool,
    highlightColor: Color = .tagBackgroundHighlighted,
    font: Font = .caption,
    horizontalPadding: CGFloat = 9,
    verticalPadding: CGFloat = 5,
    cornerRadius: CGFloat = 8,
    glowColor: Color = .clear,
    glowRadius: CGFloat = 0) {
    self.text = text
    self.highlightCondition = highlightCondition
    self.highlightColor = highlightColor
    self.font = font
    self.horizontalPadding = horizontalPadding
    self.verticalPadding = verticalPadding
    self.cornerRadius = cornerRadius
    self.glowColor = glowColor
    self.glowRadius = glowRadius
  }

  var body: some View {
//    print("tagView \(text) computed!")

    return Text(text)
      .highlightableTagView(
        highlightCondition: highlightCondition,
        highlightColor: highlightColor,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        glowColor: glowColor,
        glowRadius: glowRadius
      )
  }
}

#Preview {
  HighlightableTagView(
    text: "Cma7",
    highlightCondition: true,
    font: .headline,
    horizontalPadding: 10,
    verticalPadding: 5,
    cornerRadius: 8,
    glowColor: .pink,
    glowRadius: 8
  )
}
