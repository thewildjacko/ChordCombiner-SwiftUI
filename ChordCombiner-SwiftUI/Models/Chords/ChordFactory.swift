//
//  ChordFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import Foundation

struct ChordFactory {
  //  MARK: static properties
  static var allChords: [Chord] {
    var chords: [Chord] = []
    let roots: [RootGen] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]


    for root in roots {
      for type in ChordType.allCases {
        chords.append(Chord(root, type))
      }
    }
    
    return chords
  }
  
  //  MARK: static methods
  static func combineChords(_ lowerChord: Chord, _ upperChord: Chord) -> Chord? {
    var degrees: [Int] {
      return lowerChord.degrees + upperChord.degrees
    }
    
    var chords: [Chord] = []
    
    for chord in allChords {
      if degrees.toSet() == chord.degrees.toSet() {
        chords.append(chord)
      } else {
        continue
      }
    }
    
    if !chords.isEmpty {
      return chords.first
    } else {
      return nil
    }
  }
  
  static func chordsIn(_ chord: Chord) -> [Chord] {
    return chord.containingChords()
  }
}
