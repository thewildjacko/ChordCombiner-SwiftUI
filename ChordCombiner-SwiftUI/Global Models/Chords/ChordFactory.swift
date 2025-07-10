//
//  ChordFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import Foundation
import Algorithms

struct ChordFactory {
  // MARK: static properties
  static var allChords: [Chord] {
    var chords: [Chord] = []

    for (root, chordType) in product(RootKeyNote.allTwelveKeys, ChordType.allCases) {
      chords.append(Chord(root, chordType))
    }

    return chords
  }

  static var allSimpleChords: [Chord] {
    var chords: [Chord] = []

    for (root, chordType) in product(RootKeyNote.allTwelveKeys, ChordType.allSimpleChordTypes) {
      chords.append(Chord(root, chordType))
    }

    return chords
  }

  static var allChordsInC: [Chord] {
    var chords: [Chord] = []
    let root: RootKeyNote = .c

    for chordType in ChordType.allCases {
      chords.append(Chord(root, chordType))
    }

    return chords
  }

  static func allChords(in root: RootKeyNote) -> [Chord] {
    var chords: [Chord] = []

    for chordType in ChordType.allCases {
      chords.append(Chord(root, chordType))
    }

    return chords
  }

  static var allExtendedChordsInC: [Chord] {
    var chords: [Chord] = []
    let root: RootKeyNote = .c

    for chordType in ChordType.allCases {
      chords.append(Chord(root, chordType))
    }

    return chords.filter { !$0.isTriad() && !$0.isFourNoteSimpleChord() }
  }

  static func combos(count: Int) {
    let numbers = Array(0...11)
    let comboCount = numbers.combinations(ofCount: count).count
    for combo in numbers.combinations(ofCount: count) {
      if combo.contains(0) && !ChordType.allChordDegreeNumbers.contains(combo) {
      }
    }
    print(comboCount)
  }
}
