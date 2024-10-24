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
  var keyPosition: CGFloat = 0
  var fill: any ShapeStyle
  var stroke: Color = .black
  var lineWidth: CGFloat = 1

  var initialKey: Bool = false
  var finalKey: Bool = false
  var lettersOn: Bool = false
  
  var letterFontSizeMultiplier: CGFloat {
    keyType.defaultFillColor == .white ? 0.175 : 0.085
  }
  
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
  
  init(pitch: Int = 0, keyType: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat, fill: any ShapeStyle, stroke: Color = .black, lineWidth: CGFloat = 1, lettersOn: Bool = false) {
    self.pitch = pitch
    self.keyType = keyType
    self.geoWidth = geoWidth
    self.widthMod = widthMod
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
    self.lettersOn = lettersOn
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat, lettersOn: Bool = false) {
    self.init(
      pitch: pitch,
      keyType: keyType,
      geoWidth: geoWidth,
      widthMod: widthMod,
      fill: keyType.defaultFillColor,
      lettersOn: lettersOn
    )
  }
  
  var body: some View {
    GeometryReader { keyGeo in
      ZStack {
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
        
        if lettersOn {
          TitleView(
            text: "B♯",
            font: .system(size: keyGeo.size.height > keyGeo.size.width ? keyGeo.size.width * letterFontSizeMultiplier : keyGeo.size.height * letterFontSizeMultiplier),
            color: fill as! Color == keyType.defaultFillColor ? keyType.defaultFillColor == .white ? .black : .white : .black
          )
          .position(x: position, y: height * 3/4)
          .zIndex(2)
        }
//          .opacity(lettersOn ? 1.0 : 0)
      }
    }
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
