//
//  LetterTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//
import SwiftUI

struct LetterTagView: View {
  var letter: Letter
  var highlightCondition: Bool
  var font: Font = .caption
  var horizontalPadding: CGFloat = 16
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var glowColor: Color = .title
  var glowRadius: CGFloat = 2.5
  
  var id: String {
    return letter.rawValue
  }
  
  var body: some View {
    HighlightableTagView(
      text: letter.rawValue,
      highlightCondition: highlightCondition,
      font: font,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      cornerRadius: cornerRadius,
      glowColor: glowColor,
      glowRadius: glowRadius
    )
  }
}

extension LetterTagView: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(letter)
  }
}
