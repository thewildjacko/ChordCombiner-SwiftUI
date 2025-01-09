//
//  Keyboard.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import SwiftUI

struct Keyboard: View, Identifiable, OctaveAndPitch {
  static let initialSingleChordKeyboard = Keyboard(
    width: 200,
    initialKeyType: .c,
    startingOctave: 4,
    octaves: 2)
  static let initialSingleGlowKeyboard = Keyboard(
    width: 200,
    initialKeyType: .c,
    startingOctave: 4,
    octaves: 2,
    glowColor: .glow,
    glowRadius: 5,
    chord: .initial,
    color: .lowerChordHighlight)
  static let initialDualChordKeyboard = Keyboard(
    width: 200,
    initialKeyType: .c,
    startingOctave: 4,
    octaves: 3)

  // MARK: @State properties
  var width: CGFloat {
    mutating didSet {
      setWidthAndHeight()
      for index in keys.indices {
        let previousKey = keys[index]

        keys[index] = Key(
          pitch: previousKey.pitch,
          keyType: previousKey.keyType,
          baseWidth: width,
          widthDivisor: previousKey.widthDivisor,
          keyPosition: previousKey.keyType.initialKeyPosition,
          initialKey: previousKey.initialKey,
          finalKey: previousKey.finalKey,
          lettersOn: previousKey.lettersOn,
          circlesOn: previousKey.circlesOn)
      }
    }
  }

  // MARK: instance properties
  var id: UUID = UUID()
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
  var circlesOn: Bool = false
  var letterPadding: Bool = false

  // MARK: initializers
  init(width: CGFloat,
       keyCount: Int? = nil,
       initialKeyType: KeyType = .c,
       startingOctave: Int = 4,
       octaves: Int? = nil,
       glowColor: Color = .clear,
       glowRadius: CGFloat = 0,
       lettersOn: Bool = false,
       circlesOn: Bool = false,
       letterPadding: Bool = false) {
    self.width = width
    self.keyCount = keyCount
    self.startingOctave = startingOctave
    self.initialKeyType = initialKeyType
    startingPitch = initialKeyType.toPitch(startingOctave: startingOctave)

    self.keyTypes.append(initialKeyType)
    self.octaves = octaves
    self.glowColor = glowColor
    self.glowRadius = glowRadius
    self.lettersOn = lettersOn
    self.circlesOn = circlesOn
    self.letterPadding = letterPadding

    keyTypesByCount()
    setWidthAndHeight()
    addKeys()

    self.keyCount = keys.count
  }

  init(width: CGFloat,
       keyCount: Int? = nil,
       initialKeyType: KeyType = .c,
       startingOctave: Int = 4,
       octaves: Int? = nil,
       glowColor: Color = .clear,
       glowRadius: CGFloat = 0,
       chord: Chord,
       color: Color,
       lettersOn: Bool = false,
       circlesOn: Bool = false,
       letterPadding: Bool = false) {
    self.init(
      width: width,
      keyCount: keyCount,
      initialKeyType: initialKeyType,
      startingOctave: startingOctave,
      octaves: octaves,
      glowColor: glowColor,
      glowRadius: glowRadius,
      lettersOn: lettersOn,
      circlesOn: circlesOn,
      letterPadding: letterPadding
    )

    highlightKeys(pitches: chord.voicingCalculator.stackedPitches, color: color)
  }

  // MARK: body
  var body: some View {
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
            .glow(color: glowColor, radius: glowRadius))
        .frame(width: width, height: height)
      }
    }
    .padding(.top, letterPadding ? 10 * widthMultiplier : 0)
  }
}

#Preview {
  @Previewable @State var size = CGSize()
  @Previewable @State var keyboard = Keyboard(
    width: 351,
    initialKeyType: .c,
    startingOctave: 4,
    octaves: 2)

  GeometryReader { proxy in
    VStack {
      keyboard
        .border(.red)
    }
    .onAppear {
      size = proxy.size

      keyboard = Keyboard(
        width: size.width * 0.7,
        initialKeyType: .c,
        startingOctave: 4,
        octaves: 2)
    }
  }
}
