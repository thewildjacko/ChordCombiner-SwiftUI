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

  func propertyStatus(property: T) -> PropertyStatus {
    let selected = selectedProperty == property
    let matches = matchingProperties.contains(property)

    switch (selected, matches) {
    case (true, true):
      return .selectedAndMatches
    case (true, false):
      return .selected
    case (false, true):
      return .matches
    case (false, false):
      return .neither
    }
  }

  func glowColor(propertyStatus: PropertyStatus) -> Color {
    switch propertyStatus {
    case .selected:
        .tagHighlightedGlow
    case .matches:
        .glow
    case .selectedAndMatches:
        .glow
    case .neither:
        .clear
    }
  }

  func glowRadius(propertyStatus: PropertyStatus) -> CGFloat {
    switch propertyStatus {
    case .matches, .selectedAndMatches:
      3
    case .selected:
      1.5
    case .neither:
      0
    }

//    let glowStatus: [PropertyStatus] = [.selected, .matches, .selectedAndMatches]
//
//    return glowStatus.contains(propertyStatus) ? 3 : 0
  }

  var body: some View {
    ForEach(tagProperties, id: \.rawValue) { property in
      HighlightableTagView(
        text: property.rawValue,
        highlightCondition: selectedProperty == property,
        highlightColor: highlightColor,
        backgroundColor: matchingProperties.contains(property) ? .glowText : .tagBackground,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        glowColor: glowColor(
          propertyStatus: propertyStatus(property: property)),
        //        glowColor: matchingProperties.contains(property) ? .glow : .clear,
        glowRadius: glowRadius(
          propertyStatus: propertyStatus(property: property))
        //        glowRadius: matchingProperties.contains(property) ? 3 : 0
      )
      .onTapGesture {
        selectedProperty = property
      }
    }
  }
}
