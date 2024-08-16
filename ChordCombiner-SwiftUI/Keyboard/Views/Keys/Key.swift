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
  var geoWidth: CGFloat
  var widthMod: CGFloat
  var initialKey: Bool = false
  var keyPosition: CGFloat = 0
  var lineWidth: CGFloat = 1
  var stroke: Color = .black
  var fill: Color
  
  static func getInitialWidthPosition(initialKeyType: KeyType, widthMultiplier: CGFloat) -> CGFloat {
    switch initialKeyType {
    case .C, .E, .G, .A, .endingC, .endingE:
      return Width.whiteKeyCEGA.rawValue * widthMultiplier / 2
    case .D, .F, .B:
      return Width.whiteKeyDFB.rawValue * widthMultiplier  / 2
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return Width.blackKey.rawValue * widthMultiplier / 2
    }
  }
  
  var body: some View {
    switch type {
    case .C:
      CShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .D:
      DShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .E:
      EShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .F:
      FShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .G:
      GShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .A:
      AShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .B:
      BShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .Db, .Eb, .Gb, .Ab, .Bb:
      BlackKeyShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    case .endingC, .endingE:
      EndingCandEShapeGroup(width: width, height: height, radius: radius, widthMultiplier: widthMultiplier, position: position, fill: fill, stroke: stroke, lineWidth: lineWidth, z_Index: z_Index)
    }
  }
}

extension Key {
  init(pitch: Int, type: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat, fill: Color, stroke: Color, lineWidth: CGFloat) {
    self.pitch = pitch
    self.type = type
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
  }
}

#Preview {
  GeometryReader { geometry in
    Key(type: .C, geoWidth: geometry.size.width, widthMod: 23, fill: .white)
  }
    .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)

  .border(.black)
}
