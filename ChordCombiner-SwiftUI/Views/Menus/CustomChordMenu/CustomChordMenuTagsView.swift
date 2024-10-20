//
//  CustomChordMenuTagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/20/24.
//

import SwiftUI

struct CustomChordMenuTagsView<T: ChordAndScaleProperty>: View {
  @Binding var selectedProperty: T?
  @Binding var matchingProperties: Set<T>
  
  var tagProperties: [T]
  var isHorizontal: Bool = true
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var spacing: CGFloat = 10
  
  var body: some View {
    if isHorizontal {
      HStack(spacing: spacing) {
        ChordPropertyTagView(
          selectedProperty: $selectedProperty,
          matchingProperties: $matchingProperties,
          tagProperties: tagProperties,
          font: font,
          horizontalPadding: horizontalPadding,
          verticalPadding: verticalPadding,
          cornerRadius: cornerRadius
        )
      }
    } else {
      VStack(spacing: spacing) {
        ChordPropertyTagView(
          selectedProperty: $selectedProperty,
          matchingProperties: $matchingProperties,
          tagProperties: tagProperties,
          font: font,
          horizontalPadding: horizontalPadding,
          verticalPadding: verticalPadding,
          cornerRadius: cornerRadius
        )
      }
    }
  }
}
