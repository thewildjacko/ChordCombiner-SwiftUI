//
//  Key.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

struct Key: View, KeyProtocol, Identifiable {
  var id: UUID = UUID()
  var pitch: Int = 0
  var keyType: KeyType
  var geoWidth: CGFloat
  var widthMod: CGFloat
  var initialKey: Bool = false
  var finalKey: Bool = false
  var keyPosition: CGFloat = 0
  var lineWidth: CGFloat = 1
  var stroke: Color = .black
  var fill: any ShapeStyle
  
  var keyShape: any KeyShapeProtocol {
    KeyShape(
      finalKey: finalKey,
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      keyShapePath: keyType.keyShapePath
    )
  }
  
  var keyRect: CGRect {
    CGRect(x: 0, y: 0, width: width, height: height)
  }
  
  mutating func toggleHighlight<T: ShapeStyle>(color: T) {
    fill = fill is Color && fill as! Color == keyType.defaultFillColor ? color : keyType.defaultFillColor
  }
  
  mutating func highlight<T: ShapeStyle>(color: T) {
    fill = fill is Color && fill as! Color == keyType.defaultFillColor ? color : fill
  }
  
  mutating func clearHighlight() {
    fill = keyType.defaultFillColor
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat, fill: any ShapeStyle, stroke: Color = .black, lineWidth: CGFloat = 1) {
    self.pitch = pitch
    self.keyType = keyType
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat) {
    self.pitch = pitch
    self.keyType = keyType
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = keyType.defaultFillColor
    self.stroke = .black
    self.lineWidth = 1
  }
  
  var body: some View {
    KeyShapeGroup(
      finalKey: finalKey,
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      position: position,
      fill: fill,
      stroke: stroke,
      lineWidth: lineWidth,
      z_Index: z_Index,
      keyShapePath: keyType.keyShapePath
    )
  }
}

extension Key {
  
}

#Preview {
  GeometryReader { geometry in
    Key(keyType: .C, geoWidth: geometry.size.width, widthMod: 23, fill: .white)
  }
  .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)
  
  .border(.black)
}
