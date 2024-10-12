//
//  ViewModifiers.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/7/24.
//

import SwiftUI

struct RoundRectTagViewModifier: ViewModifier {
  var font: Font = .title3
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .background(.tagBackground)
      .foregroundStyle(.title)
      .fontWeight(.bold)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
  }
}

struct HighlightableTagViewModifier: ViewModifier {
  var highlightCondition: Bool
  var font: Font = .title3
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  var stroke: Color = .clear
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .padding(.horizontal, horizontalPadding)
      .padding(.vertical, verticalPadding)
      .background(highlightCondition ? .tagBackgroundHighlighted : .tagBackground)
      .foregroundStyle(highlightCondition ? .tagTextHighlighted : .tagText)
      .fontWeight(.bold)
      .clipShape(
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
      )
      .overlay(
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
          .fill(.clear)
          .stroke(stroke, lineWidth: 3)
      )
  }
}

struct TitleFormatViewModifier: ViewModifier {
  var font: Font = .largeTitle
  var weight: Font.Weight = .regular
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .fontWeight(weight)
      .foregroundStyle(.title)
      .fixedSize()
      .fontWeight(.heavy)
  }
}

struct MenuTitleFormatViewModifier: ViewModifier {
  var font: Font = .largeTitle
  var weight: Font.Weight = .regular
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .fontWeight(weight)
      .fixedSize()
      .fontWeight(.heavy)
  }
}

struct TitleColorOverlay: ViewModifier {
  func body(content: Content) -> some View {
    content
      .overlay(.title)
  }
}

extension View {
  func roundRectTagView(font: Font = .title3, horizontalPadding: CGFloat = 9, verticalPadding: CGFloat = 5, cornerRadius: CGFloat = 8) -> some View {
    modifier(
      RoundRectTagViewModifier(
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius
      )
    )
  }
  
  func highlightableTagView(highlightCondition: Bool, font: Font = .title3, horizontalPadding: CGFloat = 9, verticalPadding: CGFloat = 5, cornerRadius: CGFloat = 8, stroke: Color = .clear) -> some View {
    modifier(
      HighlightableTagViewModifier(
        highlightCondition: highlightCondition,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        stroke: stroke
      )
    )
  }
  
  func titleFormat(font: Font = .largeTitle, weight: Font.Weight = .regular) -> some View {
    modifier(TitleFormatViewModifier(font: font, weight: weight))
  }
  
  func menuTitleFormat(font: Font = .largeTitle, weight: Font.Weight = .regular) -> some View {
    modifier(MenuTitleFormatViewModifier(font: font, weight: weight))
  }
  
  func titleColorOverlay() -> some View {
    modifier(TitleColorOverlay())
  }
}
