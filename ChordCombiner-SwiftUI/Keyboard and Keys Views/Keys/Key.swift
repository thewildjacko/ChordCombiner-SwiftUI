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
  var note: Note? { didSet { setKeyLetterView() } }

  var baseWidth: CGFloat { didSet { setWidthMultiplier() } }
  var widthDivisor: CGFloat
  var widthMultiplier: CGFloat = CGFloat()

  var keyPosition: CGFloat = 0 { didSet { setPosition() } }
  var position: CGFloat = CGFloat()

  var fill: Color { didSet { setKeyShapeGroup() } }
  var stroke: Color = .blackKey
  var lineWidth: CGFloat = 0.5

  var initialKey: Bool = false
  var finalKey: Bool = false

  var highlighted: Bool = false
  var lettersOn: Bool = false { didSet { setKeyLetterView() } }
  let letterTextColor: Color = .title
  private let letterSizeMultiplier: CGFloat = 0.7
  private var circleSizeMultiplier: CGFloat { keyType.defaultFillColor == .blackKey ? 0.9 : 0.8 }

  var circlesOn: Bool = false { didSet { setKeyCirclesView() } }
  var circleType: KeyCircleType { didSet { setKeyCirclesView() } }

  private var circleLineWidth: CGFloat { keyType.defaultFillColor == .blackKey ? 1 : 0.5 }

  private var letterWidth: CGFloat {
    (KeyWidth.whiteKeyCEGA.rawValue + KeyWidth.whiteKeyDFB.rawValue)/2 * widthMultiplier
  }

  // KeyShapeViews
  private var keyLetterView = KeyLetterView.initial

  private var keyCirclesView = KeyCirclesView.initial

  private var keyShapeGroup = KeyShapeGroup.initial

  init(pitch: Int = 0,
       keyType: KeyType = .c,
       note: Note? = nil,
       baseWidth: CGFloat,
       widthDivisor: CGFloat,
       keyPosition: CGFloat = 0,
       fill: Color = .whiteKey,
       stroke: Color = .blackKey,
       lineWidth: CGFloat = 0.5,
       initialKey: Bool = false,
       finalKey: Bool = false,
       lettersOn: Bool = false,
       circlesOn: Bool = false,
       circleType: KeyCircleType = .common) {
    self.pitch = pitch
    self.keyType = keyType
    self.note = note
    self.baseWidth = baseWidth
    self.widthDivisor = widthDivisor
    self.keyPosition = keyPosition
    self.fill = fill
    self.stroke = stroke
    self.lineWidth = lineWidth
    self.initialKey = initialKey
    self.finalKey = finalKey
    self.lettersOn = lettersOn
    self.circlesOn = circlesOn
    self.circleType = circleType

    setKeyShapeProperties()
  }

  init(pitch: Int = 0,
       keyType: KeyType = .c,
       note: Note? = nil,
       baseWidth: CGFloat,
       widthDivisor: CGFloat,
       keyPosition: CGFloat = 0,
       initialKey: Bool = false,
       finalKey: Bool = false,
       lettersOn: Bool = false,
       circlesOn: Bool = false,
       circleType: KeyCircleType = .common) {
    self.init(
      pitch: pitch,
      keyType: keyType,
      note: note,
      baseWidth: baseWidth,
      widthDivisor: widthDivisor,
      keyPosition: keyPosition,
      fill: keyType.defaultFillColor,
      initialKey: initialKey,
      finalKey: finalKey,
      lettersOn: lettersOn,
      circlesOn: circlesOn,
      circleType: circleType
    )
  }

  // MARK: Initializer helper methods
  mutating func setKeyLetterView() {
    keyLetterView = KeyLetterView(
      width: letterWidth,
      sizeMultiplier: letterSizeMultiplier,
      textColor: letterTextColor,
      note: note,
      lettersOn: lettersOn)
  }

  mutating func setKeyCirclesView() {
    keyCirclesView = KeyCirclesView(
      width: width(),
      sizeMultiplier: circleSizeMultiplier,
      circlesOn: circlesOn,
      circleType: circleType,
      lineWidth: circleLineWidth)
  }

  mutating func setWidthMultiplier() { widthMultiplier = baseWidth / widthDivisor }

  mutating func setPosition() {
    position = baseWidth.getKeyPosition(keyType: keyType, position: keyPosition, widthDivisor: widthDivisor)
  }

  mutating func setKeyShapeGroup() {
    setWidthMultiplier()
    setPosition()

    keyShapeGroup = KeyShapeGroup(
      finalKey: finalKey,
      width: width(),
      height: height(),
      radius: radius(),
      widthMultiplier: widthMultiplier,
      position: position,
      fill: fill,
      stroke: stroke,
      lineWidth: lineWidth,
      zIndex: keyType.zIndex,
      keyShapePath: keyType.keyShapePath
    )
  }

  mutating func setKeyShapeProperties() {
    setKeyLetterView()
    setKeyCirclesView()
    setKeyShapeGroup()
  }

  // MARK: instance methods
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

  func radius() -> CGFloat { keyType.baseRadius * widthMultiplier }
  func width() -> CGFloat {
    return keyType.baseWidth * widthMultiplier
  }
  func height() -> CGFloat { keyType.baseHeight * widthMultiplier }

  var body: some View {
    //    print("key \(pitch) computed!")
    return ZStack {
      keyShapeGroup

      keyLetterView
        .position(x: position, y: -10)
        .zIndex(2)

      keyCirclesView
        .position(x: position, y: height() * 5/6)
        .zIndex(2)
    }
  }
}

extension Key: Equatable {
  static func == (lhs: Key, rhs: Key) -> Bool {
    lhs.pitch == rhs.pitch &&
    lhs.note == rhs.note &&
    lhs.lettersOn == rhs.lettersOn &&
    lhs.fill == rhs.fill &&
    lhs.circlesOn == rhs.circlesOn &&
    lhs.circleType == rhs.circleType &&
    lhs.highlighted == rhs.highlighted
  }
}

#Preview {
  GeometryReader { geometry in
    Key(keyType: .g, baseWidth: geometry.size.width, widthDivisor: 23, fill: .whiteKey)
  }
  .position(x: 92, y: 192)
  .frame(width: 23 * 4, height: 96 * 4)

  .border(.blackKey)
}
