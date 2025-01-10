//
//  KeyShapeGroup.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/8/24.
//

import SwiftUI

struct KeyShapeGroup: View, KeyShapeGroupProtocol {
  static let initial = KeyShapeGroup(
    finalKey: false,
    width: 0,
    height: 0,
    radius: 0,
    widthMultiplier: 0,
    position: 0,
    fill: .whiteKey,
    stroke: .blackKey,
    lineWidth: 0.5,
    zIndex: 0,
    keyShapePath: .CShape)

  var finalKey: Bool

  var width: CGFloat
  var height: CGFloat { didSet { setKeyRect() } }
  var radius: CGFloat
  var widthMultiplier: CGFloat
  var position: CGFloat
  var fill: Color
  var stroke: Color
  var lineWidth: CGFloat
  var zIndex: Double
  var keyShapePath: KeyShapePathType

  typealias NoteShape = KeyShape
  var keyShape: NoteShape

  var keyRect: CGRect = CGRect()

  init(
    finalKey: Bool,
    width: CGFloat,
    height: CGFloat,
    radius: CGFloat,
    widthMultiplier: CGFloat,
    position: CGFloat,
    fill: Color,
    stroke: Color,
    lineWidth: CGFloat,
    zIndex: Double,
    keyShapePath: KeyShapePathType) {
      self.finalKey = finalKey
      self.width = width
      self.height = height
      self.radius = radius
      self.widthMultiplier = widthMultiplier
      self.position = position
      self.fill = fill
      self.stroke = stroke
      self.lineWidth = lineWidth
      self.zIndex = zIndex
      self.keyShapePath = keyShapePath

      keyShape = KeyShape(
        finalKey: finalKey,
        width: width,
        height: height,
        radius: radius,
        widthMultiplier: widthMultiplier,
        keyShapePathType: keyShapePath)

      setKeyRect()
  }

  mutating func setKeyRect() {
    keyRect = CGRect(x: 0, y: 0, width: width, height: height)
  }

  var body: some View {
    ZStack(alignment: .topLeading) {
      keyShape.path(in: keyRect)
        .fill(fill)

      keyShape.path(in: keyRect)
      .fill(.clear)
      .stroke(stroke, lineWidth: lineWidth)
    }
    .rotation3DEffect(
      .degrees(keyShapePath == .EShape || keyShapePath == .AShape || keyShapePath == .BShape ? 180 : 0),
      axis: (x: 0.0, y: 1.0, z: 0.0))
    .frame(width: width, height: height)
    .zIndex(zIndex)
    .position(x: position, y: height/2)
  }
}

#Preview {
  KeyShapeGroup.initial
}
