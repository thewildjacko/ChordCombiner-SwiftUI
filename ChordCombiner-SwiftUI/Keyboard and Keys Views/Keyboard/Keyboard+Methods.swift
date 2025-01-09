//
//  Keyboard+Additions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/8/25.
//

import SwiftUI

extension Keyboard {
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
            keyType: keyType,
            baseWidth: width,
            widthDivisor: widthDivisor,
            keyPosition: keyType.initialKeyPosition,
            initialKey: true,
            lettersOn: lettersOn,
            circlesOn: circlesOn
          )
        )
        keyPosition += keyType.initialKeyPosition + keyType.nextKeyPosition
        pitch += 1
      } else if index < keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType: keyType,
            baseWidth: width,
            widthDivisor: widthDivisor,
            keyPosition: keyPosition,
            lettersOn: lettersOn,
            circlesOn: circlesOn
          )
        )
        keyPosition += keyType.nextKeyPosition
        pitch += 1
      } else if index == keyTypes.count - 1 {
        keys.append(
          Key(
            pitch: pitch,
            keyType: keyType,
            baseWidth: width,
            widthDivisor: widthDivisor,
            keyPosition: keyPosition,
            finalKey: true,
            lettersOn: lettersOn,
            circlesOn: circlesOn
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
}

// MARK: Equatable
extension Keyboard: Equatable {
  static func == (lhs: Keyboard, rhs: Keyboard) -> Bool {
    lhs.initialKeyType == rhs.initialKeyType &&
    lhs.keys == rhs.keys &&
    lhs.width == rhs.width &&
    lhs.glowColor == rhs.glowColor &&
    lhs.glowRadius == rhs.glowRadius &&
    lhs.lettersOn == rhs.lettersOn &&
    lhs.circlesOn == rhs.circlesOn
  }
}
