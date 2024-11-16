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
  @State var width: CGFloat
  var highlightedPitches: Set<Int> = []
  
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
  var widthDivisor: CGFloat = 0
  var keyPosition: CGFloat = 0
  var widthMultiplier: CGFloat = 0
  var glowColor: Color = .clear
  var glowRadius: CGFloat = 0
  var lettersOn: Bool = false
  
  //  MARK: initializers
  init(baseWidth: CGFloat, keyCount: Int? = nil, initialKeyType: KeyType = .C, startingOctave: Int = 4, octaves: Int? = nil, glowColor: Color = .clear, glowRadius: CGFloat = 0, lettersOn: Bool = false) {
    self.width = baseWidth
    self.keyCount = keyCount
    self.startingOctave = startingOctave
    self.initialKeyType = initialKeyType
    self.keyTypes.append(initialKeyType)
    self.octaves = octaves
    self.glowColor = glowColor
    self.glowRadius = glowRadius
    self.lettersOn = lettersOn
    
    keyTypesByCount()
    setWidthAndHeight()
    addKeys()
  }
  
  init(baseWidth: CGFloat, keyCount: Int? = nil, initialKeyType: KeyType = .C, startingOctave: Int = 4, octaves: Int? = nil, glowColor: Color = .clear, glowRadius: CGFloat = 0, chord: Chord, color: Color, lettersOn: Bool = false) {
    self.init(
      baseWidth: baseWidth,
      keyCount: keyCount,
      initialKeyType: initialKeyType,
      startingOctave: startingOctave,
      octaves: octaves, 
      glowColor: glowColor,
      glowRadius: glowRadius,
      lettersOn: lettersOn
    )
    
    highlightKeysSingle(degreeNumbers: chord.voicingCalculator.stackedPitches, color: color)
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
        widthDivisor += index == 0 ? KeyWidth.whiteKeyCEGA.rawValue : KeyWidth.getAddend(keyType)
      case .D, .F, .B:
        widthDivisor += index == 0 ? KeyWidth.whiteKeyDFB.rawValue : KeyWidth.getAddend(keyType)
      case .Db, .Eb, .Gb, .Ab, .Bb:
        widthDivisor += index == 0 ? KeyWidth.blackKey.rawValue : KeyWidth.getAddend(keyType)
      }
    }
    
    self.widthMultiplier = width/widthDivisor
    self.height = KeyHeight.whiteKey.rawValue * widthMultiplier
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
            baseWidth: width,
            widthDivisor: widthDivisor,
            initialKey: true,
            keyPosition: keyType.initialKeyPosition,
            lettersOn: lettersOn
          )
        )
        keyPosition += keyType.initialKeyPosition + keyType.nextKeyPosition
        pitch += 1
      } else if index < keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType,
            baseWidth: width,
            widthDivisor: widthDivisor,
            keyPosition: keyPosition,
            lettersOn: lettersOn
          )
        )
        keyPosition += keyType.nextKeyPosition
        pitch += 1
      } else if index == keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType,
            baseWidth: width,
            widthDivisor: widthDivisor,
            finalKey: true,
            keyPosition: keyPosition,
            lettersOn: lettersOn
          )
        )
      }
    }
  }
  
  //  MARK: instance methods
  mutating func toggleLetters() {
    for index in keys.indices {
      keys[index].lettersOn.toggle()
    }
  }
  
  mutating func clearHighlightedKeys() {
    if !highlightedPitches.isEmpty {
      for pitch in highlightedPitches {
        if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
          keys[index].clearHighlight()
          keys[index].lettersOn.toggle()
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
        keys[index].lettersOn.toggle()
      }
    }
  }
  
  mutating func highlightKeysWithoutClearing<T: ShapeStyle>(pitches: [Int], color: T) {
    for pitch in pitches {
      highlightedPitches.insert(pitch)
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].highlight(color: color)
        keys[index].lettersOn.toggle()
      }
    }
  }
  
  mutating func highlightCombinedKeysWithoutClearing() {}
  
  mutating func setNotesStacked<T: ShapeStyle>(pitchesByNote: [Note: Int], color: T) {
    for (note, pitch) in pitchesByNote {
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].note = note
      }
    }
  }
  
  mutating func highlightKeysSingle<T: ShapeStyle>(degreeNumbers: [Int], color: T) {
    degreeNumbers.highlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func toggleHighlightKeysSingle<T: ShapeStyle>(degreeNumbers: [Int], color: T) {
    degreeNumbers.toggleHighlightIfSelected(keys: &keys, color: color)
  }
  
  mutating func toggleHighlightKeysSplit<T: ShapeStyle>(degreeNumbers: [Int], secondDegs: [Int], color: T, secondColor: T) {
        degreeNumbers.toggleHighlightIfSelected(keys: &keys, color: color)
        secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
  }

  mutating func toggleHighlightKeysCombined(degreeNumbers: [Int], secondDegs: [Int], commonToneDegs: [Int], color: Color, secondColor: Color) {
        degreeNumbers.toggleHighlightIfSelected(keys: &keys, color: color)
        secondDegs.toggleHighlightIfSelected(keys: &keys, color: secondColor)
        commonToneDegs.toggleHighlightIfSelected(keys: &keys, color: LinearGradient.commonTone(secondColor, color))
  }
  
  mutating func toggleHighlightStackedCombinedOrSplit(onlyInLower: [Int], onlyInUpper: [Int], commonTones: [Int], lowerStackedPitches: [Int], upperStackedPitches: [Int], resultChordExists: Bool, isSlashChord: Bool, color: Color, secondColor: Color) {
        if resultChordExists && !isSlashChord {
//                print("combining!")
          toggleHighlightKeysCombined(
            degreeNumbers: onlyInLower,
            secondDegs: onlyInUpper,
            commonToneDegs: commonTones,
            color: color,
            secondColor: secondColor)
        } else {
//                print("splitting!")
          toggleHighlightKeysSplit(
            degreeNumbers: lowerStackedPitches,
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
          RoundedRectangle(cornerRadius: KeyRadius.whiteKey.rawValue * widthMultiplier)
            .frame(width: width, height: height)          
            .glow(color: glowColor, radius: glowRadius)
        )
        .frame(width: width, height: height)
        .foregroundStyle(.clear)
      }
    }
  }
}

#Preview {
  VStack {
    Keyboard(baseWidth: 950, keyCount: 13, initialKeyType: .C, startingOctave: 4, octaves: 3, glowColor: .lowerChordHighlight, glowRadius: 5)
      .position(x: 550, y: 600)
  }
}


