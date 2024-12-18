//
//  ChordCombiner.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/22/24.
//
import Foundation

struct ChordCombiner {
  /// Combines the **`degreeNumbers`** of two ``Chord``s to check to see what type of result they produce
  ///
  ///   - Parameters:
  ///     - firstChord: The lower (left hand) chord
  ///     - secondChord: The upper (right hand) chord
  ///
  ///   - Returns: `Chord?` if `degreeNumbers` form a unified or slash chord, or **nil** if they form a polychord.
  ///
  /// Uses **`ChordType.typeByDegreesFiltered(degreeCount: CombinedDegreeCount`** to perform the check.
  ///
  /// 3 possible results:
  ///
  /// 1. A **unified chord** *(single chord symbol with no alternate bass)*
  /// 2. A **slash chord** *(single chord symbol over an alternate bass)*
  /// 3. A **polychord** *(two chord symbols, one over the other)*
  ///
  /// Overview:
  ///
  /// - First checks to see whether `combinedDegreesInC` matches a ``ChordType`` in `firstChord`'s original key
  ///   - If **yes**:
  ///     - Uses the ``ChordType`` result and `firstChord`'s ``RootKeyNote`` to return a ``Chord``.
  ///   - The match is a **unified chord**.
  /// - If **no**, tranposes `degreeNumbers` to the next available `RootKeyNote` and checks again.
  ///   - If a match is found, sets the chord as a **slash chord**, assigning `slashChordRootKeyNote` to the new root.
  /// - If **all roots fail to produce a match**, returns **`nil`**. The chord is a **polychord**.
  static func combineChords(firstChord: Chord, secondChord: Chord) -> Chord? {
    // Assigns initial value for the result.
    var resultChord: Chord?

    // First chord's ``RootKeyNote`` assigned to a constant for convenient reuse
    let lowerRootKeyNote = firstChord.rootKeyNote

    /// combine both `Chord`s' degreeNumber arrays
    let combinedDegrees = firstChord.degreeNumbers.combineSetFilterSort(secondChord.degreeNumbers)

    /// Tranposes the `degreeNumber` array to the key of C *(**0** in a range of **0-11**)
    let combinedDegreesInC = firstChord.degreeNumbers
      .combinedAndTransposed(with: secondChord.degreeNumbers, to: lowerRootKeyNote)

    var combinedRootKeyNotes = firstChord.combinedRootKeyNotes(with: secondChord)

    // 1. Check for matching ChordType based on combinedDegreesinC
    // 2. Assign chord from matching chordType to resultChord
    if let chordType = ChordType(fromDegreeNumbersToMatch: combinedDegreesInC) {
      resultChord = Chord(
        //        RootKeyNote(firstChord.root.rootKeyName),
        lowerRootKeyNote,
        chordType,
        isSlashChord: false,
        slashChordBassNote: nil
      )
    } else {
      //      print("No match for initial root")
      outerloop: while combinedRootKeyNotes.count >= 1 {
        for rootKeyNote in combinedRootKeyNotes {
          //          print("Trying \(rootKeyNote.keyName.rawValue)")
          if let chordType = ChordType(fromDegreeNumbers: combinedDegrees, transposedTo: rootKeyNote) {
            //            print("Found a match for \(rootKeyNote.keyName.rawValue)!")
            resultChord = Chord(
              rootKeyNote,
              chordType,
              isSlashChord: true,
              slashChordBassNote: lowerRootKeyNote
            )

            //            print(resultChord!.preciseName)

            combinedRootKeyNotes.removeAll { $0 == rootKeyNote }
            break outerloop
          } else {
            combinedRootKeyNotes.removeAll { $0 == rootKeyNote }
          }
        }
      }
    }

    return resultChord
  }
}
