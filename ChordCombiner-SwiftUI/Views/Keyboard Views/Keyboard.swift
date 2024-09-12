//
//  Keyboard.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import SwiftUI

struct Keyboard: View, Identifiable {
  var id: UUID = UUID()
  //  MARK: @State properties
  var height: CGFloat = 0
  @State var geoWidth: CGFloat
//  var title: String
  
  //  MARK: instance properties
  
  var keyCount: Int?
  var initialKeyType: KeyType = .C
  var startingOctave: Int = 4
  var startingPitch: Int {
    initialKeyType.toPitch(startingOctave: startingOctave)
  }
  
  var keyTypes: [KeyType] = []
  var octaves: Int?
  var keys: [Key] = []
  var widthMod: CGFloat = 0
  var keyPosition: CGFloat = 0
  var widthMultiplier: CGFloat = 0
  
  //  MARK: initializers
  init(/*title: String, */geoWidth: CGFloat, keyCount: Int? = nil, initialKey: KeyType = .C, startingOctave: Int = 4, octaves: Int? = nil) {
//    self.title = title
    self.keyCount = keyCount
    self.geoWidth = geoWidth
    self.startingOctave = startingOctave
    self.initialKeyType = initialKey
    self.keyTypes.append(initialKey)
    self.octaves = octaves
    
    keyTypesByCount()
    setWidthAndHeight()
    addKeys()
  }
  
  //  MARK: initializer methods
  mutating func keyTypesByCount() {
    var nextKey = initialKeyType.nextKey
    
    if let count = keyCount {
      self.keyCount = count
      if count != 0 {
        if count == 1 {
          ()
        } else {
          addKeyTypes(count: count - 1, nextKey: &nextKey)
        }
      } else {
        addKeyTypes(count: 12, nextKey: &nextKey)
      }
    } else {
      if let octaveCount = octaves {
        if octaveCount != 0 {
          addKeyTypes(count: octaveCount * 12, nextKey: &nextKey)
        } else {
          addKeyTypes(count: 12, nextKey: &nextKey)
        }
      } else {
        addKeyTypes(count: 11, nextKey: &nextKey)
      }
    }
  }
  
  mutating func setWidthAndHeight() {
    for (index, type) in keyTypes.enumerated() {
      switch type {
      case .C, .E, .G, .A:
        widthMod += index == 0 ? Width.whiteKeyCEGA.rawValue : Width.getAddend(type)
      case .D, .F, .B:
        widthMod += index == 0 ? Width.whiteKeyDFB.rawValue : Width.getAddend(type)
      case .Db, .Eb, .Gb, .Ab, .Bb:
        widthMod += index == 0 ? Width.blackKey.rawValue : Width.getAddend(type)
      }
    }
    
    self.widthMultiplier = geoWidth/widthMod
    self.height = Height.whiteKey.rawValue * widthMultiplier
  }
  
  mutating func addKeyTypes(count: Int, nextKey: inout KeyType) {
    for _ in 1...count {
      keyTypes.append(nextKey)
      nextKey = nextKey.nextKey
    }
  }
  
  mutating func setFill(type: KeyType) -> Color {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B:

      return .white
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return .black
    }
  }
  
  mutating func addKeys() {
    var pitch = 0
    for (index, type) in keyTypes.enumerated() {
      if index == 0 {
        pitch = startingPitch
        keys.append(
          Key(
            pitch: pitch,
            type,
            octaves: CGFloat(octaves ?? 1),
            geoWidth: geoWidth,
            widthMod: widthMod,
            fill: setFill(type: type),
            stroke: .black,
            initialKey: true,
            keyPosition: type.initialKeyPosition))
        keyPosition += type.initialKeyPosition + type.nextKeyPosition
        pitch += 1
      } else if index < keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            type,
            octaves: CGFloat(octaves ?? 1),
            geoWidth: geoWidth,
            widthMod: widthMod,
            fill: setFill(type: type),
            stroke: .black,
            keyPosition: keyPosition))
        keyPosition += type.nextKeyPosition
        pitch += 1
      } else if index == keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            type,
            octaves: CGFloat(octaves ?? 1),
            geoWidth: geoWidth,
            widthMod: widthMod,
            fill: setFill(type: type),
            stroke: .black,
            finalKey: true,
            keyPosition: keyPosition))
      }
    }
  }
  
  //  MARK: instance methods
  func stats() {
    let key = keys[0]
    print("height: \(key.height)")
  }
  
  mutating func resize(geoWidth: CGFloat) -> Keyboard {
    return Keyboard(
      geoWidth: geoWidth,
      keyCount: keyCount,
      initialKey: initialKeyType,
      startingOctave: startingOctave,
      octaves: octaves)
  }
  
  mutating func highlightKeysSingle<T: ShapeStyle>(degs: [Int], color: T) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func highlightKeysSplit<T: ShapeStyle>(degs: [Int], secondDegs: [Int], color: T, secondColor: T) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
    secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
  }
  
  mutating func highlightKeysSplit_SameColor<T: ShapeStyle>(degs: [Int], secondDegs: [Int], color: T) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
    secondDegs.toggleHighlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func highlightKeysCombined(degs: [Int], secondDegs: [Int], commonToneDegs: [Int], color: Color, secondColor: Color) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
    secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
    commonToneDegs.toggleHighlightIfSelected(keys: &keys, color: LinearGradient.commonTone(secondColor, color))
  }
  
  mutating func highlightStackedCombinedOrSplit(onlyInLower: [Int], onlyInUpper: [Int], commonTones: [Int], lowerStackedPitches: [Int], upperStackedPitches: [Int], resultChordExists: Bool, color: Color, secondColor: Color) {
    if resultChordExists {
      highlightKeysCombined(
        degs: onlyInLower,
        secondDegs: onlyInUpper,
        commonToneDegs: commonTones,
        color: color,
        secondColor: secondColor)
    } else {
      let (lowerPitches, upperPitches) = MultiChordVoicingCalculator.stackedSplit(lowerPitches: lowerStackedPitches, upperPitches: upperStackedPitches)
      highlightKeysSplit(
        degs: lowerPitches,
        secondDegs: upperPitches,
        color: color,
        secondColor: secondColor)
    }
  }

  
  //  MARK: body
  var body: some View {
    ZStack(alignment: .topLeading) {
      VStack(alignment: .center) {
        ZStack {
          ForEach(keys) { key in
            key
          }
        }
        .frame(width: geoWidth, height: height)
//        .position(x: geoWidth/2)
      }
    }
  }
}

#Preview {
  VStack {
    Keyboard(geoWidth: 351, initialKey: .C, startingOctave: 3, octaves: 3)
      .position(x: 220, y: 600)
  }
}


