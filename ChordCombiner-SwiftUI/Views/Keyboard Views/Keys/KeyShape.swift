//
//  KeyShape.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/8/24.
//

import SwiftUI


struct KeyShape: KeyShapeProtocol, Shape {
  var finalKey: Bool
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  var keyShapePathType: KeyShapePathType
  
  var keyShapePath: KeyShapePath {
    KeyShapePath(finalKey: finalKey, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, keyShapePathType: keyShapePathType)
  }
  
  func path(in rect: CGRect) -> Path { return keyShapePath.path }
}

#Preview {
  KeyShape(finalKey: false, width: 23 * 6, height: 96 * 6, radius: 2.5, widthMultiplier: 6, keyShapePathType: .DShape)
    .stroke(lineWidth: 3)
    .position(x: 350, y: 500)
    .foregroundStyle(.black)
  
}
