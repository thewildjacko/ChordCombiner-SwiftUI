//
//  EquivalentChordFinder.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/23/24.
//

import Foundation

class EquivalentChordFinder {
  /// Checks `degreeNumbers` against vs. an array of `RootKeyNotes` for equivalent `Chords` in each new key.
  ///
  /// - Transposes the elements of `degreeNumbers` down by each ``RootKeyNote``'s `keyName.rawValue` so that the numeric value of the new root is 0
  /// - Runs the tranposed degreeNumbers through ``ChordType``'s failable `init(fromDegreeNumbersToMatch: [Int)`
  /// - If the ``ChordType`` init returns a valid result, adds a ``Chord`` of that ChordType using the matching ``RootKeyNote``
  ///
  static func checkForEquivalentChords(degreeNumbers: [Int], rootKeyNotes: [RootKeyNote]) -> [Chord] {
    var equivalentChords: [Chord] = []
    
    for rootKeyNote in rootKeyNotes {
      // set new degreeNumber array relative to new root
      let degreeNumbersInCTransposed = degreeNumbers.transposed(to: rootKeyNote)
      
      // check for matching ChordType based on new degreeNumbers
      if let chordType = ChordType(fromDegreeNumbersToMatch: degreeNumbersInCTransposed) {
        /// create chord from matching ChordType and add to equivalentChords array
        let chord = Chord(
          rootKeyNote,
          chordType,
          isSlashChord: true,
          slashChordBassNote: rootKeyNote
        )
        
        equivalentChords.append(chord)
      }
    }
    
    return equivalentChords
  }
}
