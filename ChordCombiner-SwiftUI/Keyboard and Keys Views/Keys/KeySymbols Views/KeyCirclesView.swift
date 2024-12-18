//
//  KeySymbolsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/20/24.
//

import SwiftUI

struct KeyCirclesView: View {
  static let initial = KeyCirclesView(
    width: 0,
    sizeMultiplier: 0,
    circlesOn: false,
    circleType: .common,
    lineWidth: 1)

  let width: CGFloat
  let sizeMultiplier: CGFloat

  var circlesOn: Bool
  var circleType: KeyCircleType
  var lineWidth: CGFloat

  private var diameter: CGFloat { width * sizeMultiplier * 0.85 }

  init(
    width: CGFloat,
    sizeMultiplier: CGFloat,
    circlesOn: Bool,
    circleType: KeyCircleType,
    lineWidth: CGFloat) {
    self.width = width
    self.sizeMultiplier = sizeMultiplier
    self.circlesOn = circlesOn
    self.circleType = circleType
    self.lineWidth = lineWidth
  }

  @ViewBuilder
  var body: some View {
    if circlesOn {
      KeyCircle(
        width: diameter,
        startAngle: circleType.startAngle,
        endAngle: circleType.endAngle,
        clockwise: true)
        .foregroundStyle(circleType.color)
        .frame(width: diameter, height: diameter)
        .overlay {
          Circle()
            .strokeBorder(circleType.strokeColor, lineWidth: lineWidth)
            .foregroundStyle(.clear)
        }
    }
  }
}

#Preview {
  VStack {
    KeyCirclesView.initial
    KeyCirclesView.initial
    KeyCirclesView.initial
  }
}
