//
//  AccidentalTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct AccidentalTagView: Identifiable, View {
  var accidental: RootAccidental
  var highlightCondition: Bool
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var glowColor: Color = .title
  var glowRadius: CGFloat = 2
  
  var id: String {
    return accidental.rawValue
  }
  
  var body: some View {
    HighlightableTagView(
      text: accidental.rawValue,
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

extension AccidentalTagView: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(accidental)
  }
}
