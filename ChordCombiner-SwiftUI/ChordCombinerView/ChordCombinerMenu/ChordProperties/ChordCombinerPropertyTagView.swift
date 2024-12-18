//
//  ChordCombinerPropertyTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/20/24.
//

import SwiftUI

struct ChordCombinerPropertyTagView<T: ChordAndScaleProperty>: View {
  @Binding var selectedProperty: T?
  @Binding var matchingProperties: Set<T>

  var tagProperties: [T]
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var highlightColor: Color = .tagBackgroundHighlighted

  var body: some View {
    ForEach(tagProperties, id: \.rawValue) { property in
      HighlightableTagView(
        text: property.rawValue,
        highlightCondition: selectedProperty == property,
        highlightColor: highlightColor,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        glowColor: matchingProperties.contains(property) ? .glow : .clear,
        glowRadius: matchingProperties.contains(property) ? 3 : 0
      )
      .onTapGesture { selectedProperty = property }
    }
  }
}
