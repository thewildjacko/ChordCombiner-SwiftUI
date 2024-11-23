//
//  KeyShapePathType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/7/24.
//


import SwiftUI

enum KeyShapePathType {
  case CShape, DShape, EShape, FShape, GShape, AShape, BShape, BlackandEdgeWhiteKeyShape
  
  func path(width: CGFloat, height: CGFloat, radius: CGFloat, widthMultiplier: CGFloat) -> Path {
    switch self {
    case .CShape, .EShape, .FShape, .BShape:
      return Path { path in
        let x0 = 0.0
        let x1 = KeyWidth.blackKey.rawValue * widthMultiplier
        let x2 = width
        let x3 = radius
        
        let y0 = 0.0
        let y1 = x1 * KeyConstants.blackKeyHeightToWidthRatio
        let y2 = height - radius
        let y3 = height
                
        path.addLines(
          [
            CGPoint(x: x0, y: y0), // start at top left
            CGPoint(x: x1, y: y0), // over to top right edge adjacent to D♭
            CGPoint(x: x1, y: y1), // down to black key base
            CGPoint(x: x2, y: y1), // over to lower right edge adjacent to D
            CGPoint(x: x2, y: y2) // down to lower right corner at white key base
          ]
        )
        
        // lower right corner radius
        path.addArc(
          tangent1End: CGPoint(x: x2, y: y3),
          tangent2End: CGPoint(x: x2 - radius, y: y3),
          radius: radius
        )
        
        // over to lower left corner
        path.addLine(to: CGPoint(x: x3, y: y3))
        
        // lower right corner radius
        path.addArc(
          tangent1End: CGPoint(x: x0, y: y3),
          tangent2End: CGPoint(x: x0, y: y2),
          radius: radius
        )
                
        path.closeSubpath() // back to top left
      }
    case .DShape, .GShape, .AShape:
      return Path { path in
        let blackKeyWidth = KeyWidth.blackKey.rawValue * widthMultiplier // 14
        let keyAddendMod = (self == .GShape || self == .AShape) ? KeyAddendMod.Gb.rawValue : KeyAddendMod.Db.rawValue
        
        let x0 = keyAddendMod * widthMultiplier
        
        let x1PositionMod = (self == .GShape || self == .AShape) ? x0/2 : x0 * 2
        let x1 = x1PositionMod + blackKeyWidth // 16
        
        let x2 = width // 23
        let x3 = radius
        let x4 = 0.0
        
        let y0 = 0.0
        let y1 = blackKeyWidth * KeyConstants.blackKeyHeightToWidthRatio
        let y2 = height - radius
        let y3 = height
                        
        path.addLines(
          [
            CGPoint(x: x0, y: y0), // start at top left corner adjacent to G♭
            CGPoint(x: x1, y: y0), // over to top right corner adjacent to A♭
            CGPoint(x: x1, y: y1), // down to black key base
            CGPoint(x: x2, y: y1), // over to outer middle right corner adjacent to A
            CGPoint(x: x2, y: y2) // down to lower right corner at white key base
          ])
        
        // lower right corner radius
        path.addArc(
          tangent1End: CGPoint(x: x2, y: y3),
          tangent2End: CGPoint(x: x2 - radius, y: y3),
          radius: radius
        )
        
        // over to lower left corner
        path.addLine(to: CGPoint(x: x3, y: y3))

        // lower right corner radius
        path.addArc(
          tangent1End: CGPoint(x: x4, y: y3),
          tangent2End: CGPoint(x: x4, y: y3 - radius),
          radius: radius
        )
                
        path.addLine(to: CGPoint(x: x4, y: y1)) // up to outer middle left corner adjacent to F
        path.addLine(to: CGPoint(x: x0, y: y1)) // over to inner middle left corner adjacent to G♭
        
        // back to top left corner
        path.closeSubpath()
      }
    case .BlackandEdgeWhiteKeyShape:
      return Path { path in
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        path.addRoundedRect(in: rect, cornerRadii: RectangleCornerRadii(topLeading: 0, bottomLeading: radius, bottomTrailing: radius, topTrailing: 0))
      }
    }
  }
}
