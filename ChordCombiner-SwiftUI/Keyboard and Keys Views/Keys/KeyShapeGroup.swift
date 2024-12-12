//
//  KeyShapeGroup.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/8/24.
//

import SwiftUI

struct KeyShapeGroup: View, KeyShapeGroupProtocol {
  var finalKey: Bool
  
  var width: CGFloat
  var height: CGFloat { didSet { setKeyRect() } }
  var radius: CGFloat
  var widthMultiplier: CGFloat
  var position: CGFloat
  var fill: Color
  var stroke: Color
  var lineWidth: CGFloat
  var z_Index: Double
  var keyShapePath: KeyShapePathType
    
  typealias NoteShape = KeyShape
  var keyShape: NoteShape
  
  var keyRect: CGRect = CGRect()

  init(finalKey: Bool, width: CGFloat, height: CGFloat, radius: CGFloat, widthMultiplier: CGFloat, position: CGFloat, fill: Color, stroke: Color, lineWidth: CGFloat, z_Index: Double, keyShapePath: KeyShapePathType) {
    self.finalKey = finalKey
    self.width = width
    self.height = height
    self.radius = radius
    self.widthMultiplier = widthMultiplier
    self.position = position
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
    self.z_Index = z_Index
    self.keyShapePath = keyShapePath
    
    keyShape = KeyShape(finalKey: finalKey, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, keyShapePathType: keyShapePath)
    setKeyRect()
  }
  
  mutating func setKeyRect() { keyRect = CGRect(x: 0, y: 0, width: width, height: height) }
  
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
    .zIndex(z_Index)
    .position(x: position, y: height/2)
  }
}

#Preview {
  KeyShapeGroup(finalKey: false, width: 23, height: 96, radius: 2.5, widthMultiplier: 1, position: 200, fill: .white, stroke: .black, lineWidth: 1, z_Index: 0, keyShapePath: .CShape)
}
