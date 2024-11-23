//
//  BlackKeyShape.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

struct BlackKeyShape: Shape, KeyShapeProtocol {
  var finalKey: Bool
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  
  func path(in rect: CGRect) -> Path {
    KeyShapePaths.RoundedRectangleKeyShapePath(width: width, height: height, radius: radius)
//    Path { path in
//      let rect = CGRect(x: 0, y: 0, width: width, height: height)
//      
//      path.addRoundedRect(in: rect, cornerRadii: RectangleCornerRadii(topLeading: 0, bottomLeading: radius, bottomTrailing: radius, topTrailing: 0))
//    }
  }
}
