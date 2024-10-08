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
  var type: KeyType
  var octaves: CGFloat
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
      keyShapePath: type.keyShapePath
    )
  }
  
  var keyRect: CGRect {
    CGRect(x: 0, y: 0, width: width, height: height)
  }
  
  mutating func toggleHighlight<T: ShapeStyle>(color: T) {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B:
      fill = fill is Color && fill as! Color == .white ? color : .white
    case .Db, .Eb, .Gb, .Ab, .Bb:
      fill = fill is Color && fill as! Color == .black ? color : .black
    }
  }
  
  mutating func highlight<T: ShapeStyle>(color: T) {
    fill = fill is Color && (fill as! Color == .white || fill as! Color == .black) ? color : fill
  }
  
  init(pitch: Int = 0, type: KeyType = .C, octaves: CGFloat = 1, geoWidth: CGFloat, widthMod: CGFloat, fill: any ShapeStyle, stroke: Color = .black, lineWidth: CGFloat = 1) {
    self.pitch = pitch
    self.type = type
    self.octaves = octaves
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
  }
  
  var body: some View {
    KeyShapeGroup(
      finalKey: finalKey,
      octaves: octaves,
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      position: position,
      fill: fill,
      stroke: stroke,
      lineWidth: lineWidth,
      z_Index: z_Index,
      keyShapePath: type.keyShapePath
    )
  }
}

#Preview {
  GeometryReader { geometry in
    Key(type: .C, octaves: 1, geoWidth: geometry.size.width, widthMod: 23, fill: .white)
  }
  .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)
  
  .border(.black)
}
