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
  var note: Note?
  
  var baseWidth: CGFloat
  var widthDivisor: CGFloat
  var keyPosition: CGFloat = 0
  var fill: any ShapeStyle
  var stroke: Color = .black
  var lineWidth: CGFloat = 1
  
  var initialKey: Bool = false
  var finalKey: Bool = false
  var lettersOn: Bool = false
  var highlighted = false
  
  var letterFontSizeMultiplier: CGFloat {
    keyType.defaultFillColor == .white ? 0.7 : 0.6
  }
  
  var letterTextColor: Color {
    highlighted ? .black : keyType.defaultFillColor == .white ? .black : .white
  }
  
  var keyShape: any KeyShapeProtocol {
    KeyShape(
      finalKey: finalKey,
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      keyShapePathType: keyType.keyShapePath
    )
  }
  
  var keyRect: CGRect {
    CGRect(x: 0, y: 0, width: width, height: height)
  }
  
  mutating func toggleHighlight<T: ShapeStyle>(color: T) {
    fill = fill is Color && fill as! Color == keyType.defaultFillColor ? color : keyType.defaultFillColor
    highlighted.toggle()
  }
  
  mutating func highlight<T: ShapeStyle>(color: T) {
    fill = fill is Color && fill as! Color == keyType.defaultFillColor ? color : fill
    highlighted = true
  }
  
  mutating func clearHighlight() {
    fill = keyType.defaultFillColor
    highlighted = false
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat, fill: any ShapeStyle, stroke: Color = .black, lineWidth: CGFloat = 1, lettersOn: Bool = false) {
    self.pitch = pitch
    self.keyType = keyType
    self.note = note
    self.baseWidth = baseWidth
    self.widthDivisor = widthDivisor
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
    self.lettersOn = lettersOn
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat, lettersOn: Bool = false) {
    self.init(
      pitch: pitch,
      keyType: keyType,
      note: note,
      baseWidth: baseWidth,
      widthDivisor: widthDivisor,
      fill: keyType.defaultFillColor,
      lettersOn: lettersOn
    )
  }
  
  var body: some View {
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
        if let note = note {
          TitleView(
            text: note.noteName,
            font: .system(size: width * letterFontSizeMultiplier),
            color: letterTextColor
          )
          .position(x: position, y: height * 3/4)
          .zIndex(2)
        }
      }
    }
  }
}

extension Key {
  
}

#Preview {
  GeometryReader { geometry in
    Key(keyType: .G, baseWidth: geometry.size.width, widthDivisor: 23, fill: .white)
  }
  .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)
  
  .border(.black)
}
