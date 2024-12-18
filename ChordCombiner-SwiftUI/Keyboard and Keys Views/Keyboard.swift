//
//  Keyboard.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import SwiftUI

struct Keyboard: View, Identifiable, OctaveAndPitch {
  static let initialSingleChordKeyboard = Keyboard(baseWidth: 351, initialKeyType: .c, startingOctave: 4, octaves: 2)
  static let initialDualChordKeyboard = Keyboard(baseWidth: 351, initialKeyType: .c, startingOctave: 4, octaves: 3)

  var id: UUID = UUID()
  // MARK: @State properties
  @State var baseWidth: CGFloat

  // MARK: instance properties
  var height: CGFloat = 0
  var highlightedPitches: Set<Int> = []

  var keyCount: Int?
  var initialKeyType: KeyType = .c
  var startingOctave: Int = 4
  var startingPitch: Int

  var keyTypes: [KeyType] = []
  var octaves: Int?
  var keys: [Key] = []
  var widthDivisor: CGFloat = 0
  var keyPosition: CGFloat = 0
  var widthMultiplier: CGFloat = 0
  var glowColor: Color = .clear
  var glowRadius: CGFloat = 0
  var lettersOn: Bool = false

  // MARK: initializers
  init(baseWidth: CGFloat,
       keyCount: Int? = nil,
       initialKeyType: KeyType = .c,
       startingOctave: Int = 4,
       octaves: Int? = nil,
       glowColor: Color = .clear,
       glowRadius: CGFloat = 0,
       lettersOn: Bool = false) {
    self.baseWidth = baseWidth
    self.keyCount = keyCount
    self.startingOctave = startingOctave
    self.initialKeyType = initialKeyType
    startingPitch = initialKeyType.toPitch(startingOctave: startingOctave)

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

  init(baseWidth: CGFloat,
       keyCount: Int? = nil,
       initialKeyType: KeyType = .c,
       startingOctave: Int = 4,
       octaves: Int? = nil,
       glowColor: Color = .clear,
       glowRadius: CGFloat = 0,
       chord: Chord,
       color: Color,
       lettersOn: Bool = false) {
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

  // MARK: initializer methods
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
      case .c, .e, .g, .a:
        widthDivisor += index == 0 ? KeyWidth.whiteKeyCEGA.rawValue : KeyWidth.getAddend(keyType)
      case .d, .f, .b:
        widthDivisor += index == 0 ? KeyWidth.whiteKeyDFB.rawValue : KeyWidth.getAddend(keyType)
      case .dB, .eB, .gB, .aB, .bB:
        widthDivisor += index == 0 ? KeyWidth.blackKey.rawValue : KeyWidth.getAddend(keyType)
      }
    }

    self.widthMultiplier = baseWidth/widthDivisor
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
            keyType: keyType,
            baseWidth: baseWidth,
            widthDivisor: widthDivisor,
            keyPosition: keyType.initialKeyPosition,
            initialKey: true,
            lettersOn: lettersOn
          )
        )
        keyPosition += keyType.initialKeyPosition + keyType.nextKeyPosition
        pitch += 1
      } else if index < keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType: keyType,
            baseWidth: baseWidth,
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
            keyType: keyType,
            baseWidth: baseWidth,
            widthDivisor: widthDivisor,
            keyPosition: keyPosition,
            finalKey: true,
            lettersOn: lettersOn
          )
        )
      }
    }
  }

  // MARK: instance methods
  mutating func toggleLetters() {
    for index in keys.indices {
      keys[index].lettersOn.toggle()
    }
  }

  mutating func clearNotes() {
    for index in keys.indices where keys[index].note != nil {
      keys[index].note = nil
    }
  }

  mutating func setNotesStacked(pitchesByNote: PitchesByNote) {
    for (note, pitch) in pitchesByNote {
      if let index = keys.firstIndex(where: { $0.pitch == pitch }) {
        keys[index].note = note
      }
    }
  }

  mutating func setNotesSplit(notes: [Note], pitches: [Int]) {
    for notesIndex in (0..<notes.count) {
      if let index = keys.firstIndex(where: { $0.pitch == pitches[notesIndex] }) {
        keys[index].note = notes[notesIndex]
      }
    }
  }

  mutating func clearHighlightedKeys() {
    if !highlightedPitches.isEmpty {
      for pitch in highlightedPitches {
        if let index = pitch.indexFromKeys(keys: &keys) {
          keys[index].clearHighlight()
          keys[index].note = nil
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

  mutating func turnCirclesOn(pitches: [Int], circleType: KeyCircleType) {
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

  mutating func highlightKeys_LettersAndCirclesOn(pitches: [Int], color: Color, circleType: KeyCircleType) {
    highlightKeys(pitches: pitches, color: color)
    turnLettersOn(pitches: pitches)
    turnCirclesOn(pitches: pitches, circleType: circleType)
  }

  // MARK: body
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
            .frame(width: baseWidth, height: height)
            .glow(color: glowColor, radius: glowRadius))
        .frame(width: baseWidth, height: height)
        .foregroundStyle(.clear)
      }
    }
  }
}

extension Keyboard: Equatable {
  static func == (lhs: Keyboard, rhs: Keyboard) -> Bool {
    lhs.initialKeyType == rhs.initialKeyType && lhs.keys == rhs.keys && lhs.baseWidth == rhs.baseWidth
  }
}

#Preview {
  VStack {
    Keyboard.initialSingleChordKeyboard
      .position(x: 550, y: 600)
  }
}
