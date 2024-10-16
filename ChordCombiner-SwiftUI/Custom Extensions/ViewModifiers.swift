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
  var glowColor: Color = .clear
  var glowRadius: CGFloat = 6
  
  init(highlightCondition: Bool, font: Font, horizontalPadding: CGFloat, verticalPadding: CGFloat, cornerRadius: CGFloat, glowColor: Color, glowRadius: CGFloat) {
    self.highlightCondition = highlightCondition
    self.font = font
    self.horizontalPadding = horizontalPadding
    self.verticalPadding = verticalPadding
    self.cornerRadius = cornerRadius
    self.glowColor = glowColor
    self.glowRadius = glowRadius
  }
  
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
    
//      .overlay(
//        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
//          .fill(.clear)
//      )
      .glow(color: glowColor, radius:glowRadius)
  }
}

struct TitleFormatViewModifier: ViewModifier {
  var font: Font = .largeTitle
  var weight: Font.Weight = .regular
  var color: Color = .title
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .fontWeight(weight)
      .foregroundStyle(color)
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

struct Glow: ViewModifier {
  @State private var pulse = false
  
  var color: Color = .title
  var radius: CGFloat = 10
  
  var pulseRadius: CGFloat {
    pulse ? radius * 1.25 : radius
  }
  
  init(pulse: Bool = false, color: Color, radius: CGFloat) {
    self.pulse = pulse
    self.color = color
    self.radius = radius
  }
  
  func body(content: Content) -> some View {
    content
      .shadow(color: color, radius: pulseRadius)
      .shadow(color: color, radius: pulseRadius)
//      .shadow(color: color, radius: pulseRadius)
//      .animation(
//        .easeOut(duration: 2.0).repeatForever(),
//        value: pulse
//      )
//      .onAppear { pulse.toggle() }
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
  
  func highlightableTagView(
    highlightCondition: Bool,
    font: Font = .title3,
    horizontalPadding: CGFloat = 9,
    verticalPadding: CGFloat = 5,
    cornerRadius: CGFloat = 8,
    glowColor: Color = .clear,
    glowRadius: CGFloat = 6
  ) -> some View {
    modifier(
      HighlightableTagViewModifier(
        highlightCondition: highlightCondition,
        font: font,
        horizontalPadding: horizontalPadding,
        verticalPadding: verticalPadding,
        cornerRadius: cornerRadius,
        glowColor: glowColor,
        glowRadius: glowRadius
      )
    )
  }
  
  func titleFormat(font: Font = .largeTitle, weight: Font.Weight = .regular, color: Color = .title) -> some View {
    modifier(TitleFormatViewModifier(font: font, weight: weight, color: color))
  }
  
  func menuTitleFormat(font: Font = .largeTitle, weight: Font.Weight = .regular) -> some View {
    modifier(MenuTitleFormatViewModifier(font: font, weight: weight))
  }
  
  func titleColorOverlay() -> some View {
    modifier(TitleColorOverlay())
  }
  
  func glow(color: Color = .title, radius: CGFloat = 20) -> some View {
    modifier(Glow(color: color, radius: radius))
  }
}

