//
//  ChordFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import Foundation
import Algorithms

struct ChordFactory {
  var equivalentChords: [Chord]
  
  //  MARK: static properties
  static var allChords: [Chord] {
    var chords: [Chord] = []
    let roots: [RootKeyNote] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]
    
    for root in roots {
      for type in ChordType.allCases {
        chords.append(Chord(root, type))
      }
    }
    
    return chords
  }
  
  static var allChordsInC: [Chord] {
    var chords: [Chord] = []
    let root: RootKeyNote = .c
    
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
  
  static func combineChordDegrees(degrees: [Int], otherDegrees: [Int], root: Note, otherRoot: Note) -> Chord? {
    let degrees: [Int] = degrees + otherDegrees
    let degreesInC = Array(degrees.toSet()).map { $0.minusDeg(root.noteNum.rawValue) }.sorted()
    
    let upperRootDegreesInC = Array(degrees.toSet()).map { $0.minusDeg(otherRoot.noteNum.rawValue) }.sorted()

    let degreeCount = degreesInC.count
    let typeByDegreesFiltered = ChordType.typeByDegreesFiltered(degreeCount: degreeCount)
    
    if let type = typeByDegreesFiltered[degreesInC] {
      print("result chord exists with Root!")
      return Chord(RootKeyNote(root.rootKeyName), type, isSlashChord: false, slashChordBassNote: nil)
    } else if let type = typeByDegreesFiltered[upperRootDegreesInC] {
      print("result chord exists with otherRoot!")
      return Chord(RootKeyNote(otherRoot.rootKeyName), type, isSlashChord: true, slashChordBassNote: Root(otherRoot))
    } else {
      print("couldn't find a match for degrees \(degrees) or \(upperRootDegreesInC)")
      return nil
    }
  }
  
  static func compareDegreesInC() {
//    var count = 0
//    for chord in allChordsInC {
//      let allNotes = chord.allNotes.map { $0.noteNum.rawValue }
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
  
  static func combos(count: Int) {
    let numbers = Array(0...11)
    let comboCount = numbers.combinations(ofCount: count).count
    for combo in numbers.combinations(ofCount: count) {
      if combo.contains(0) && !ChordType.allChordDegrees.contains(combo) {
        print(combo)
      }
    }
    print(comboCount)
  }
}
