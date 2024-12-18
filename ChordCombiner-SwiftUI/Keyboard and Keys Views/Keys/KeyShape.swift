//
//  KeyShape.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/8/24.
//

import SwiftUI

struct KeyShape: KeyShapeProtocol, Shape {
  let finalKey: Bool
  let width: CGFloat
  let height: CGFloat
  let radius: CGFloat
  let widthMultiplier: CGFloat
  let keyShapePathType: KeyShapePathType

  private var keyShapePath: KeyShapePath

  init(finalKey: Bool,
       width: CGFloat,
       height: CGFloat,
       radius: CGFloat,
       widthMultiplier: CGFloat,
       keyShapePathType: KeyShapePathType) {
    self.finalKey = finalKey
    self.width = width
    self.height = height
    self.radius = radius
    self.widthMultiplier = widthMultiplier
    self.keyShapePathType = keyShapePathType

    keyShapePath = KeyShapePath(
      finalKey: finalKey,
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      keyShapePathType: keyShapePathType)
  }

  func path(in rect: CGRect) -> Path { return keyShapePath.path }
}

#Preview {
  KeyShape(
    finalKey: false,
    width: 23 * 6,
    height: 96 * 6,
    radius: 2.5,
    widthMultiplier: 6,
    keyShapePathType: .DShape)
  .stroke(lineWidth: 3)
  .position(x: 350, y: 500)
  .foregroundStyle(.black)

}
