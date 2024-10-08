//
//  FandBShape.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

struct FandBShape: Shape, KeyShapeProtocol {
  var finalKey: Bool
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  
  func path(in rect: CGRect) -> Path {
    KeyShapePaths.CEFBKeyShapePath(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier)
//    Path { path in
//      let x0 = 0.0
//      let x1 = Width.blackKey.rawValue * widthMultiplier
//      let x2 = width
//      let x3 = radius
//      
//      let y0 = 0.0
//      let y1 = x1 * Constants.blackKeyHeightMultiplier
//      let y2 = height - radius * 2
//      let y3 = height
//      
//      let arcCenter1 = CGPoint(x: width - radius, y: height - radius)
//      let arcCenter2 = CGPoint(x: radius, y: height - radius)
//      
//      path.addLines(
//        [
//          CGPoint(x: x0, y: y0),
//          CGPoint(x: x1, y: y0),
//          CGPoint(x: x1, y: y1),
//          CGPoint(x: x2, y: y1),
//          CGPoint(x: x2, y: y2)
//        ])
//      
//      path.addRelativeArc(
//        center: arcCenter1,
//        radius: radius,
//        startAngle: ArcAngle.one.angle,
//        delta: ArcAngle.two.angle)
//      
//      path.addLine(to: CGPoint(x: x3, y: y3))
//      
//      path.addRelativeArc(
//        center: arcCenter2,
//        radius: radius,
//        startAngle: ArcAngle.two.angle,
//        delta: ArcAngle.two.angle)
//      
//      path.closeSubpath()
//    }
  }
}
