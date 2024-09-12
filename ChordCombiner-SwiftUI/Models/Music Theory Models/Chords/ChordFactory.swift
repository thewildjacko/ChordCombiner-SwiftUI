//
//  ChordFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import Foundation

struct ChordFactory {
  var equivalentChords: [Chord]
  
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
  
  static var allChordsInC: [Chord] {
    var chords: [Chord] = []
    let root: RootGen = .c
    
    for type in ChordType.allCases {
      chords.append(Chord(root, type))
    }
    
    return chords
  }
  
  //  MARK: static methods
  static func combineChords(_ lowerChord: Chord, _ upperChord: Chord) -> (resultChord: Chord?, equivalentChords: [Chord]) {
    let degrees: [Int] = lowerChord.degrees + upperChord.degrees
    
    var resultChord: Chord? = nil
    
    var chords: [Chord] = []
    
    for chord in allChords {
      if degrees.toSet() == chord.degrees.toSet() {
        if chord.root == lowerChord.root {
          resultChord = chord
        } else {
          chords.append(chord)
        }
      }
    }
    
    return (resultChord, chords)
  }
  
  static func combineChordDegrees(lowerDegrees: [Int], upperDegrees: [Int], lowerRoot: Note, upperRoot: Note) -> Chord? {
//    print("Combining degrees")
    let degrees: [Int] = lowerDegrees + upperDegrees
    let degreesInC = Array(degrees.toSet()).map { $0.minusDeg(lowerRoot.basePitchNum) }.sorted()
    
//    print(lowerChordDegrees, upperChordDegrees, degrees, degreesInC)
    
    let type = ChordType.getChordTypeByDegrees(degrees: degreesInC)
    if let type = type {
      return Chord(RootGen(lowerRoot.rootKey), type)
    } else {
      return nil
    }
  }
  
  static func compareDegreesInC() {
//    var count = 0
//    for chord in allChordsInC {
//      let allNotes = chord.allNotes.map { $0.basePitchNum }
//      if chord.degrees != allNotes {
//        print(chord.type.degreeTags.map { $0.rawValue } )
//        print(chord.degrees)
//        print("all notes by Degree: ", chord.allNotes)
//        print(allNotes)
//        print("----------")
//    }
//    print(count)
  }
  
  static func deltaChords(_ chord: Chord, delta: Int) -> [Chord] {
    let degrees = chord.degrees
    var chords: [Chord] = []
    
    for chord in allChords {
//      let degsSub = degrees.toSet().subtracting(chord.degrees.toSet())
      let chordSub = chord.degrees.toSet().subtracting(degrees.toSet())
      
      if /*degsSub.count == delta || */chordSub.count == delta {
//        if degsSub.count == delta {
//          print(degsSub)
//        } else if chordSub.count == delta {
//          print(chordSub)
//        }
        chords.append(chord)
      }
    }
    
    return chords
  }
  
  static func chordsIn(_ chord: Chord) -> [Chord] {
    return chord.containingChords()
  }
}
