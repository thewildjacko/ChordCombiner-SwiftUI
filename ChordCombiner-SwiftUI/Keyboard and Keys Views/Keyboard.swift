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
    
    self.keyCount = keys.count
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
    
    highlightKeys(pitches: chord.voicingCalculator.stackedPitches, color: color)
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
  
  mutating func setNotesStacked(pitchesByNote: [Note: Int]) {
    for (note, pitch) in pitchesByNote {
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].note = note
      }
    }
  }
  
  mutating func clearHighlightedKeys() {
    if !highlightedPitches.isEmpty {
      for pitch in highlightedPitches {
        if let index = pitch.indexFromKeys(keys: &keys) {
          keys[index].clearHighlight()
          if keys[index].lettersOn == true {
            keys[index].lettersOn = false
          }
          if keys[index].circlesOn == true {
            keys[index].circlesOn = false
          }
        }
      }
      
      highlightedPitches.removeAll()
    }
  }
  
  mutating func highlightKeys(pitches: [Int], color: Color) {
    pitches.highlightIfSelected(keys: &keys, highlightedPitches: &highlightedPitches, color: color)
  }
  
  mutating func turnLettersOn(pitches: [Int]) {
    pitches.lettersOnIfSelected(keys: &keys)
  }
  
  mutating func turnCirclesOn(pitches: [Int], circleType: KeyCirclesView.CircleType) {
    pitches.circlesOnIfSelected(keys: &keys, circleType: circleType)
  }
  
  mutating func clearAndHighlightKeys(pitches: [Int], color: Color) {
    clearHighlightedKeys()
    highlightKeys(pitches: pitches, color: color)
  }
  
  mutating func highlightKeys_LettersOn(pitches: [Int], color: Color) {
    highlightKeys(pitches: pitches, color: color)
    turnLettersOn(pitches: pitches)
  }
  
  mutating func highlightKeys_LettersAndCirclesOn(pitches: [Int], color: Color, circleType: KeyCirclesView.CircleType) {
    highlightKeys(pitches: pitches, color: color)
    turnLettersOn(pitches: pitches)
    turnCirclesOn(pitches: pitches, circleType: circleType)
  }
          
  //  MARK: body
  var body: some View {
//    print("keyboard \(id) computed!")
    
    return ZStack(alignment: .topLeading) {
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

extension Keyboard: Equatable {
  static func == (lhs: Keyboard, rhs: Keyboard) -> Bool {
    lhs.initialKeyType == rhs.initialKeyType && lhs.keys == rhs.keys && lhs.width == rhs.width
  }
}

#Preview {
  VStack {
    Keyboard(baseWidth: 950, keyCount: 13, initialKeyType: .C, startingOctave: 4, octaves: 3, glowColor: .lowerChordHighlight, glowRadius: 5)
      .position(x: 550, y: 600)
  }
}
