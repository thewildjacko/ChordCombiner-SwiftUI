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
  var fill: Color
  var stroke: Color = .black
  var lineWidth: CGFloat = 1
  
  var initialKey: Bool = false
  var finalKey: Bool = false
  var lettersOn: Bool = false
  var highlighted: Bool = false
  
  var circlesOn: Bool = false
  var circleType: KeyCirclesView.CircleType
  
  let letterTextColor: Color = .title

  private let letterSizeMultiplier: CGFloat = 0.7
  private var circleSizeMultiplier: CGFloat { keyType.defaultFillColor == .black ? 0.9 : 0.8 }
  private var circleLineWidth: CGFloat { keyType.defaultFillColor == .black ? 1 : 0.5 }
  
  private var letterWidth: CGFloat {
    (KeyWidth.whiteKeyCEGA.rawValue + KeyWidth.whiteKeyDFB.rawValue)/2 * widthMultiplier
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
  
  var keyLetterView: KeyLetterView {
    KeyLetterView(width: letterWidth, sizeMultiplier: letterSizeMultiplier, textColor: letterTextColor, note: note, lettersOn: lettersOn)
  }
  
  var keyCirclesView: KeyCirclesView {
    KeyCirclesView(
      width: width,
      sizeMultiplier: circleSizeMultiplier,
      circlesOn: circlesOn,
      circleType: circleType,
      lineWidth: circleLineWidth
    )
  }
  
  private var keyShapeGroup: KeyShapeGroup {
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
  
  mutating func toggleHighlight(color: Color) {
    fill = fill == keyType.defaultFillColor ? color : keyType.defaultFillColor
    highlighted.toggle()
  }
  
  mutating func highlight(color: Color) {
//    print("highlighting key \(pitch)!")
    fill = fill == keyType.defaultFillColor ? color : fill
    highlighted = true
  }
  
  mutating func clearHighlight() {
//    print("clearing key \(pitch)!")
    highlighted = false
    fill = keyType.defaultFillColor
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat, fill: Color, stroke: Color = .black, lineWidth: CGFloat = 1, lettersOn: Bool = false, circlesOn: Bool = false,  circleType: KeyCirclesView.CircleType = .common) {
    self.pitch = pitch
    self.keyType = keyType
    self.note = note
    self.baseWidth = baseWidth
    self.widthDivisor = widthDivisor
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
    self.lettersOn = lettersOn
    self.circlesOn = circlesOn
    self.circleType = circleType
  }
  
  init(pitch: Int = 0, keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat, lettersOn: Bool = false, circlesOn: Bool = false,  circleType: KeyCirclesView.CircleType = .common) {
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
//    print("key \(pitch) computed!")
    return ZStack {
      keyShapeGroup
      
      keyLetterView
        .position(x: position, y: -15)
        .zIndex(2)
      
      keyCirclesView
        .position(x: position, y: height * 5/6)
        .zIndex(2)
    }
  }
}

extension Key: Equatable {
  static func == (lhs: Key, rhs: Key) -> Bool {
    lhs.pitch == rhs.pitch && lhs.note == rhs.note && lhs.lettersOn == rhs.lettersOn && lhs.fill == rhs.fill && lhs.circlesOn == rhs.circlesOn && lhs.circleType == rhs.circleType && lhs.highlighted == rhs.highlighted
  }
}

#Preview {
  GeometryReader { geometry in
    Key(keyType: .G, baseWidth: geometry.size.width, widthDivisor: 23, fill: .white)
  }
  .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)
  
  .border(.black)
}
