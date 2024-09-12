//
//  AShapeGroup.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/7/24.
//

import SwiftUI

struct AShapeGroup: View, KeyShapeGroup {
  var finalKey: Bool
  typealias NoteShape = GandAShape
  var keyShape: NoteShape { GandAShape(finalKey: finalKey, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier)
  }
  
  var octaves: CGFloat
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  var position: CGFloat
  var fill: any ShapeStyle
  var stroke: Color
  var lineWidth: CGFloat
  var z_Index: Double
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      if fill is Color {
        keyShape.path(
          in: keyRect)
        .fill(fill as! Color)
      } else {
        keyShape.path(
          in: keyRect)
        .fill(fill as! LinearGradient)
      }
      
      keyShape.path(
        in: keyRect)
      .stroke(stroke, lineWidth: lineWidth)
    }
    .rotation3DEffect(
      .degrees(180),
      axis: (x: 0.0, y: 1.0, z: 0.0))
    .frame(width: width, height: height)
    .zIndex(z_Index)
    .position(x: position, y: height/2)
    
  }
}

#Preview {
  AShapeGroup(finalKey: false, octaves: 1, width: 23, height: 96, radius: 2.5, widthMultiplier: 1, position: 200, fill: .white, stroke: .black, lineWidth: 1, z_Index: 0)
}
