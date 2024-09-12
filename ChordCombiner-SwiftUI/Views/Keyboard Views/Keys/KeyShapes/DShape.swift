//
//  DShape.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

struct DShape: Shape, KeyShape {
  var finalKey: Bool
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  
  func path(in rect: CGRect) -> Path {
    Path { path in

      let bWidth = Width.blackKey.rawValue * widthMultiplier
      
      let x0 = AddendMod.Db.rawValue * widthMultiplier
      let x1 = x0 + bWidth
      let x2 = x0 * 2 + bWidth
      let x3 = radius
      let x4 = 0.0
      
      let y0 = 0.0
      let y1 = bWidth * Height.blackKey.rawValue/Width.blackKey.rawValue
      let y2 = height - radius * 2
      let y3 = height
      
      let arcCenter1 = CGPoint(x: width - radius, y: height - radius)
      let arcCenter2 = CGPoint(x: radius, y: y3 - radius)      
      
      path.move(to: CGPoint(x: x0, y: y0))
      
      path.addLines(
        [
          CGPoint(x: x0, y: y0),
          CGPoint(x: x1, y: y0),
          CGPoint(x: x1, y: y1),
          CGPoint(x: x2, y: y1),
          CGPoint(x: x2, y: y2)
        ])

      path.addRelativeArc(
        center: arcCenter1,
        radius: radius,
        startAngle: ArcAngle.one.angle,
        delta: ArcAngle.two.angle)

      path.addLine(to: CGPoint(x: x3, y: y3))
      
      path.addRelativeArc(
        center: arcCenter2,
        radius: radius,
        startAngle: ArcAngle.two.angle,
        delta: ArcAngle.two.angle)
            
      path.addLine(to: CGPoint(x: x4, y: y1))
      path.addLine(to: CGPoint(x: x0, y: y1))
      
      path.closeSubpath()
    }
  }
}

