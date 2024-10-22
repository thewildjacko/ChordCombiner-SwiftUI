//
//  Keyboard.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import SwiftUI

struct Keyboard: View, Identifiable, OctaveAndPitch {
  var id: UUID = UUID()
  //  MARK: @State properties
  var height: CGFloat = 0
  @State var geoWidth: CGFloat
  var highlightedPitches: Set<Int> = []
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
  var glowColor: Color = .clear
  var glowRadius: CGFloat = 0
  
  //  MARK: initializers
  init(geoWidth: CGFloat, keyCount: Int? = nil, initialKey: KeyType = .C, startingOctave: Int = 4, octaves: Int? = nil, glowColor: Color = .clear, glowRadius: CGFloat = 0) {
    self.keyCount = keyCount
    self.geoWidth = geoWidth
    self.startingOctave = startingOctave
    self.initialKeyType = initialKey
    self.keyTypes.append(initialKey)
    self.octaves = octaves
    self.glowColor = glowColor
    self.glowRadius = glowRadius
    
    keyTypesByCount()
    setWidthAndHeight()
    addKeys()
  }
  
  init(geoWidth: CGFloat, keyCount: Int? = nil, initialKey: KeyType = .C, startingOctave: Int = 4, octaves: Int? = nil, glowColor: Color = .clear, glowRadius: CGFloat = 0, chord: Chord, color: Color) {
    self.keyCount = keyCount
    self.geoWidth = geoWidth
    self.startingOctave = startingOctave
    self.initialKeyType = initialKey
    self.keyTypes.append(initialKey)
    self.octaves = octaves
    self.glowColor = glowColor
    self.glowRadius = glowRadius
    
    keyTypesByCount()
    setWidthAndHeight()
    addKeys()
    
    highlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
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
    for (index, keyType) in keyTypes.enumerated() {
      switch keyType {
      case .C, .E, .G, .A:
        widthMod += index == 0 ? Width.whiteKeyCEGA.rawValue : Width.getAddend(keyType)
      case .D, .F, .B:
        widthMod += index == 0 ? Width.whiteKeyDFB.rawValue : Width.getAddend(keyType)
      case .Db, .Eb, .Gb, .Ab, .Bb:
        widthMod += index == 0 ? Width.blackKey.rawValue : Width.getAddend(keyType)
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
  
  mutating func setDefaultFill(keyType: KeyType) -> Color {
    keyType.defaultFillColor
  }
  
  mutating func addKeys() {
    var pitch = 0
    for (index, keyType) in keyTypes.enumerated() {
      if index == 0 {
        pitch = startingPitch
        keys.append(
          Key(
            pitch: pitch,
            keyType,
            geoWidth: geoWidth,
            widthMod: widthMod,
            initialKey: true,
            keyPosition: keyType.initialKeyPosition))
        keyPosition += keyType.initialKeyPosition + keyType.nextKeyPosition
        pitch += 1
      } else if index < keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType,
            geoWidth: geoWidth,
            widthMod: widthMod,
            keyPosition: keyPosition))
        keyPosition += keyType.nextKeyPosition
        pitch += 1
      } else if index == keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType,
            geoWidth: geoWidth,
            widthMod: widthMod,
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
  
  mutating func clearHighlightedKeys() {
    if !highlightedPitches.isEmpty {
      for pitch in highlightedPitches {
        if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
          keys[index].clearHighlight()
        }
      }
      
      highlightedPitches.removeAll()
    }
  }
  
  mutating func highlightKeysAfterClearing<T: ShapeStyle>(pitches: [Int], color: T) {
    clearHighlightedKeys()
        
    for pitch in pitches {
      highlightedPitches.insert(pitch)
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].highlight(color: color)
      }
    }
  }
  
  mutating func highlightKeysWithoutClearing<T: ShapeStyle>(pitches: [Int], color: T) {
    for pitch in pitches {
      highlightedPitches.insert(pitch)
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].highlight(color: color)
      }
    }
  }
  
  mutating func highlightCombinedKeysWithoutClearing() {}
  
  mutating func highlightKeysSingle<T: ShapeStyle>(degs: [Int], color: T) {
    degs.highlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func toggleHighlightKeysSingle<T: ShapeStyle>(degs: [Int], color: T) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func toggleHighlightKeysSplit<T: ShapeStyle>(degs: [Int], secondDegs: [Int], color: T, secondColor: T) {
        degs.toggleHighlightIfSelected(keys: &keys, color: color)
        secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
  }
  
  mutating func toggleHighlightKeysSplit_SameColor<T: ShapeStyle>(degs: [Int], secondDegs: [Int], color: T) {
    degs.toggleHighlightIfSelected(keys: &keys, color: color)
    secondDegs.toggleHighlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func toggleHighlightKeysCombined(degs: [Int], secondDegs: [Int], commonToneDegs: [Int], color: Color, secondColor: Color) {
        degs.toggleHighlightIfSelected(keys: &keys, color: color)
        secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
        commonToneDegs.toggleHighlightIfSelected(keys: &keys, color: LinearGradient.commonTone(secondColor, color))
  }
  
  mutating func toggleHighlightStackedCombinedOrSplit(onlyInLower: [Int], onlyInUpper: [Int], commonTones: [Int], lowerStackedPitches: [Int], upperStackedPitches: [Int], resultChordExists: Bool, isSlashChord: Bool, color: Color, secondColor: Color) {
        if resultChordExists && !isSlashChord {
//                print("combining!")
          toggleHighlightKeysCombined(
            degs: onlyInLower,
            secondDegs: onlyInUpper,
            commonToneDegs: commonTones,
            color: color,
            secondColor: secondColor)
        } else {
//                print("splitting!")
          toggleHighlightKeysSplit(
            degs: lowerStackedPitches,
            secondDegs: upperStackedPitches,
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
        .background(
          RoundedRectangle(cornerRadius: Radius.whiteKey.rawValue * widthMultiplier)
            .frame(width: geoWidth, height: height)          
            .glow(color: glowColor, radius: glowRadius)
        )
        .frame(width: geoWidth, height: height)
      }
    }
  }
}

#Preview {
  VStack {
    Keyboard(geoWidth: 351, initialKey: .C, startingOctave: 4, octaves: 3, glowColor: .lowerChordHighlight, glowRadius: 5)
      .position(x: 220, y: 600)
  }
}


