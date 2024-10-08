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
  
  mutating func toggleHighlight<T: ShapeStyle>(color: T) {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B:
      if fill is Color && fill as! Color == .white  {
        fill = color
      } else {
        fill = .white
      }
    case .Db, .Eb, .Gb, .Ab, .Bb:
      if fill is Color && fill as! Color == .black  {
        fill = color
      } else {
        fill = .black
      }
    }
  }
  
  mutating func highlight<T: ShapeStyle>(color: T) {
    if fill is Color && fill as! Color == .white || fill as! Color == .black {
      fill = color
    }
  }
  
  var body: some View {
    switch type {
    case .C:
      CShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .D:
      DShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .E:
      EShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .F:
      FShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .G:
      GShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .A:
      AShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .B:
      BShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .Db, .Eb, .Gb, .Ab, .Bb:
      BlackKeyShapeGroup(finalKey: finalKey, octaves: octaves, width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    }
  }
}

extension Key {
  init(pitch: Int, type: KeyType = .C, octaves: CGFloat = 1, geoWidth: CGFloat, widthMod: CGFloat, fill: any ShapeStyle, stroke: Color, lineWidth: CGFloat) {
    self.pitch = pitch
    self.type = type
    self.octaves = octaves
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
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
