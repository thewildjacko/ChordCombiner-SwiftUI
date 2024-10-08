//
//  ViewModifiers.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/7/24.
//

import SwiftUI

struct TagViewModifier: ViewModifier {
  var condition: Bool
  var font: Font = .title3
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .background(condition ? .tagBackgroundHighlighted : .tagBackground)
      .foregroundStyle(condition ? .tagTextHighlighted : .tagText)
      .fontWeight(.bold)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
  }
}

extension View {
  func tagView(condition: Bool, font: Font = .title3, horizontalPadding: CGFloat = 9, verticalPadding: CGFloat = 5, cornerRadius: CGFloat = 8) -> some View {
    modifier(TagViewModifier(
      condition: condition,
      font: font,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      cornerRadius: cornerRadius)
    )
  }
}
