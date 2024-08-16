//
//  BlackKeyShapeGroup.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/7/24.
//

import SwiftUI

struct BlackKeyShapeGroup: View, KeyShapeGroup {
  typealias NoteShape = BlackKeyShape
  var keyShape: NoteShape { BlackKeyShape(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier)
  }
  
  var width: CGFloat
  var height: CGFloat
  var radius: CGFloat
  var widthMultiplier: CGFloat
  var position: CGFloat
  var fill: Color
  var stroke: Color
  var lineWidth: CGFloat
  var z_Index: Double
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      keyShape.path(
        in: keyRect)
      .fill(fill)
      
      keyShape.path(
        in: keyRect)
      .stroke(stroke, lineWidth: lineWidth)
    }
    .frame(width: width, height: height)
    .position(x: position, y: height/2)
    .zIndex(z_Index)
  }
}

#Preview {
  BlackKeyShapeGroup(width: 14, height: 52, radius: 1.2, widthMultiplier: 1, position: 200, fill: .black, stroke: .black, lineWidth: 1, z_Index: 1)
}
