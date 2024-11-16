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
      for chordType in ChordType.allCases {
        chords.append(Chord(root, chordType))
      }
    }
    
    return chords
  }
  
  static var allSimpleChords: [Chord] {
    var chords: [Chord] = []
    let roots: [RootKeyNote] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]
    
    for root in roots {
      for chordType in ChordType.allSimpleChordTypes {
        chords.append(Chord(root, chordType))
      }
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
  
  /// This method takes two ``Chord`` objects, and uses **`ChordType.typeByDegreesFiltered(degreeCount: CombinedDegreeCount`** to check if their combined **`degreeNumbers`** form a **unified chord** *(single chord symbol with no alternate bass)*, a **slash chord** *(single chord symbol over an alternate bass)*, or a **polychord** *(two chord symbols, one over the other)*.
  ///
  /// - Returns a tuplet where the first value, `resultChord: Chord?`, equals the result of the above check: an optional ``Chord`` if the combined degreeNumbers form a unified chord or slash chord, or **nil** if they form a polychord. The second value, `equivalentChords: [Chord]` is an array of the other equivalent `Chords`, if any, that have the same degreeNumbers as `resultChord`.
  ///
  /// 1. First checks to see whether `combinedDegreesInC` matches a ``ChordType`` in `firstChord`'s original key
  /// - If **yes**, sets `resultChord` to a ``Chord`` using `firstChord`'s ``RootKeyNote`` and the resulting ``ChordType``. The match is a **unified chord**.
  ///   - Checks the remaining roots for equivalent `Chords`.
  /// - If **no**, moves on to the next root and looks for a ``Chord`` using the same method as above, but sets the chord as a **slash chord**, assigning `slashChordRootKeyNote` to the root that matched.
  ///   - Searches for equivalent chords as above.
  /// - If **all roots fail to produce a match**, returns **`nil`** for the first tuplet value and an empty array for the second. The chord is a **polychord**.
  static func combineChords(firstChord: Chord, secondChord: Chord) -> (resultChord: Chord?, equivalentChords: [Chord]) {
    // Assigns initial values for the result tuplet.
    var resultChord: Chord? = nil
    var equivalentChords: [Chord] = []
    
    // First chord's ``RootKeyNote`` assigned to a constant for convenient reuse
    let lowerRootKeyNote = firstChord.rootKeyNote
       
    /// combine both `Chord`s' degreeNumber arrays
    let combinedDegrees = firstChord.degreeNumbers.combineSetFilterSort(secondChord.degreeNumbers)
    
    print(combinedDegrees)
    
    /// Tranposes the `degreeNumber` array to the key of C *(**0** in a range of **0-11**)
    let combinedDegreesInC = firstChord.degreeNumbers.combinedAndTransposed(with: secondChord.degreeNumbers, to: lowerRootKeyNote)
    
    print(combinedDegreesInC)
    
    var combinedRootKeyNotes = firstChord.combinedRootKeyNotes(with: secondChord)
        
    // check for matching ChordType based on combinedDegreesinC, assign chord from matching chordType to resultChord, and check for equivalentChords
    if let chordType = ChordType(fromDegreeNumbersToMatch: combinedDegreesInC) {
      resultChord = Chord(
//        RootKeyNote(firstChord.root.rootKeyName),
        lowerRootKeyNote,
        chordType,
        isSlashChord: false,
        slashChordBassNote: nil
      )
      
      equivalentChords = EquivalentChordFinder.checkForEquivalentChords(degreeNumbers: combinedDegreesInC, rootKeyNotes: combinedRootKeyNotes)
    } else {
      print("No match for initial root")
      outerloop: while combinedRootKeyNotes.count >= 1 {
        for rootKeyNote in combinedRootKeyNotes {
          print("Trying \(rootKeyNote.keyName.rawValue)")
          if let chordType = ChordType(fromDegreeNumbers: combinedDegrees, transposedTo: rootKeyNote) {
            print("Found a match for \(rootKeyNote.keyName.rawValue)!")
            resultChord = Chord(
              rootKeyNote,
              chordType,
              isSlashChord: true,
              slashChordBassNote: rootKeyNote
            )
            
            print(resultChord!.preciseName)
            
            combinedRootKeyNotes.removeAll { $0 == rootKeyNote }

            equivalentChords = EquivalentChordFinder.checkForEquivalentChords(degreeNumbers: combinedDegreesInC, rootKeyNotes: combinedRootKeyNotes)
            break outerloop
          } else {
            combinedRootKeyNotes.removeAll { $0 == rootKeyNote }
          }
        }
      }
    }
        
    return (resultChord, equivalentChords)
  }
    
  static func combos(count: Int) {
    let numbers = Array(0...11)
    let comboCount = numbers.combinations(ofCount: count).count
    for combo in numbers.combinations(ofCount: count) {
      if combo.contains(0) && !ChordType.allChordDegreeNumbers.contains(combo) {
        print(combo)
      }
    }
    print(comboCount)
  }
}
