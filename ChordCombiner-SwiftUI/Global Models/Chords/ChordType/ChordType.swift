//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, ChordAndScaleProperty {
  var id: Self { return self }

  // MARK: Triads
  // swiftlint:disable identifier_name
  case ma = ""      // [0, 4, 7]
  case mi           // [0, 3, 7]
  // swiftlint:enable identifier_name
  case aug = "+"    // [0, 4, 8]
  case dim = "˚"    // [0, 3, 6]
  case sus4         // [0, 5, 7]
  case sus2         // [0, 2, 7]

  // MARK: Modified Triads
  case add4 = "add4"               // [0, 4, 5, 7] -> ma7(sus2) 2nd inversion
  case minorAdd4 = "mi(add4)"        // [0, 3, 5, 7]
  case add2 = "add2"               // [0, 2, 4, 7]
  case minorAdd2 = "mi(add2)"        // [0, 2, 3, 7]

  // MARK: Major Lydian 7th Chords
  case ma7                                   // [0, 4, 7, 11]
  case ma9                                   // [0, 2, 4, 7, 11]
  case ma13                                  // [0, 2, 4, 7, 9, 11]
  case ma13omit9 = "ma13(omit9)"            // [0, 4, 7, 9, 11]
  case ma7sh11 = "ma7(♯11)"                 // [0, 4, 6, 7, 11]
  case ma9sh11 = "ma9(♯11)"                 // [0, 2, 4, 6, 7, 11]
  case ma13sh11 = "ma13(♯11)"               // [0, 2, 4, 6, 7, 9, 11]
  case ma13sh11omit9 = "ma13(♯11 omit9)"   // [0, 4, 6, 7, 9, 11]

  // MARK: Altered Major 7th Chords
  // ma7(♭5)
  case ma7b5 = "ma7(♭5)"                            // [0, 4, 6, 11]
  case ma9b5 = "ma9(♭5)"                            // [0, 4, 6, 11]
  case ma13b5 = "ma13(♭5)"                          // [0, 2, 4, 6, 9, 11]
  case ma13b5omit9 = "ma13(♭5 omit9)"              // [0, 4, 6, 9, 11]
  // ma7(♯5)
  case ma7sh5 = "ma7(♯5)"                           // [0, 4, 8, 11]
  case ma9sh5 = "ma9(♯5)"                           // [0, 2, 4, 8, 11]
  case ma13sh5 = "ma13(♯5)"                         // [0, 2, 4, 8, 9, 11]
  case ma13sh5omit9 = "ma13(♯5 omit9)"             // [0, 4, 8, 9, 11]
  case ma7sh5sh11 = "ma7(♯5♯11)"                   // [0, 4, 6, 8, 11]
  case ma9sh5sh11 = "ma9(♯5♯11)"                   // [0, 4, 6, 8, 11]
  case ma13sh5sh11 = "ma13(♯5♯11)"                 // [0, 2, 4, 6, 8, 9, 11]
  case ma13sh5sh11omit9 = "ma13(♯5♯11 omit9)"     // [0, 4, 6, 8, 9, 11]

  // MARK: Ma7(sus4) Chords
  case ma7sus4 = "ma7sus4"                    // [0, 5, 7, 11]
  case ma9sus4 = "ma9sus4"                    // [0, 2, 5, 7, 11]
  case ma13sus4 = "ma13sus4"                   // [0, 2, 5, 7, 9, 11]
  case ma13sus4omit9 = "ma13sus4(omit9)"        // [0, 5, 7, 9, 11]

  // MARK: Altered Ma7(sus4) Chords
  case ma7sus4sh5 = "ma7sus4(♯5)"                // [0, 5, 8, 11]
  case ma9sus4sh5 = "ma9sus4(♯5)"                // [0, 2, 5, 8, 11]

  // MARK: Dominant 7th Chords
  // 7th chords
  case dominant7 = "7"                                   // [0, 4, 7, 10]
  case dominant9 = "9"                                   // [0, 2, 4, 7, 10]
  case dominant13 = "13"                                 // [0, 2, 4, 7, 9, 10]
  case dominant13omit9 = "13(omit9)"                    // [0, 4, 7, 9, 10]
  // ♭9
  case dominant7b9 = "7(♭9)"                            // [0, 1, 4, 7, 10]
  case dominant7b9b5 = "7(♭9♭5)"                       // [0, 1, 4, 6, 10]
  case dominant7b9sh5 = "7(♭9♯5)"                      // [0, 1, 4, 8, 10]
  case dominant7b9sh9 = "7(♭9♯9)"                      // [0, 1, 3, 4, 7, 10]
  case dominant7b9sh11 = "7(♭9♯11)"                    // [0, 1, 4, 6, 7, 10]
  case dominant7altb9sh9sh11 = "7alt(♭9♯9♯11)"         // [0, 1, 3, 4, 6, 7, 10]
  case dominant7altb9sh9b5 = "7alt(♭9♯9♭5)"            // [0, 1, 3, 4, 6, 10]
  case dominant7altb9sh5sh11 = "7alt(♭9♯5♯11)"         // [0, 1, 4, 6, 8, 10]
  case dominant7altb9sh9sh5sh11 = "7alt(♭9♯9♯5♯11)"    // [0, 1, 3, 4, 6, 8, 10]
  // ♯9
  case dominant7sh9 = "7(♯9)"                           // [0, 3, 4, 7, 10]
  case dominant7sh9b5 = "7(♯9♭5)"                      // [0, 3, 4, 6, 10]
  case dominant7sh9sh5 = "7(♯9♯5)"                     // [0, 3, 4, 8, 10]
  case dominant7sh9sh11 = "7(♯9♯11)"                   // [0, 3, 4, 6, 7, 10]
  case dominant7altsh9sh5sh11 = "7alt(♯9♯5♯11)"         // [0, 3, 4, 6, 8, 10]
  // ♯11
  case dominant7sh11 = "7(♯11)"                         // [0, 4, 6, 7, 10]
  case dominant9sh11 = "9(♯11)"                         // [0, 2, 4, 6, 7, 10]
  case dominant13sh11 = "13(♯11)"                       // [0, 2, 4, 6, 7, 9, 10]
  case dominant13sh11omit9 = "13(♯11 omit9)"           // [0, 4, 6, 7, 9, 10]
  // ♭5
  case dominant7b5 = "7(♭5)"                            // [0, 4, 6, 10]
  case dominant9b5 = "9(♭5)"                            // [0, 2, 4, 6, 10]
  case dominant13b5 = "13(♭5)"                          // [0, 2, 4, 6, 9, 10]
  case dominant13b5omit9 = "13(♭5 omit9)"              // [0, 4, 6, 9, 10]
  case dominant9sh5 = "9(♯5)"                           // [0, 2, 4, 8, 10]
  // ♯5
  case dominant7sh5 = "7(♯5)"                           // [0, 4, 8, 10]
  case dominant7sh5sh11 = "7(♯5♯11)"                   // [0, 4, 6, 8, 10]

  // MARK: 7sus4
  case dominant7sus4 = "7sus4"                              // [0, 5, 7, 10]
  case dominant9sus4 = "9sus4"                              // [0, 2, 5, 7, 10]
  case dominant13sus4 = "13sus4"                            // [0, 2, 5, 7, 9, 10]
  case dominant13sus4omit9 = "13sus4(omit9)"               // [0, 5, 7, 9, 10]

  // MARK: 7sus4(♭9)
  case dominant7sus4b9 = "7sus4(♭9)"                        // [0, 1, 5, 7, 10]
  case dominant13sus4b9 = "13sus4(♭9)"                      // [0, 1, 5, 7, 9, 10]

  // MARK: 7sus2
  case dominant7sus2 = "7sus2"                              // [0, 2, 7, 10]
  case dominant13sus2 = "13sus2"                            // [0, 2, 7, 9, 10]

  // MARK: Minor Dorian 7th Chords
  case mi7                                 // [0, 3, 7, 10]
  case mi9                                 // [0, 2, 3, 7, 10]
  case mi11                                // [0, 2, 3, 5, 7, 10]
  case mi11omit9 = "mi11(omit9)"          // [0, 3, 5, 7, 10]
  case mi13                                // [0, 2, 3, 5, 7, 9, 10]
  case mi13omit9 = "mi13(omit9)"          // [0, 3, 5, 7, 9, 10]
  case mi13omit11 = "mi13(omit11)"        // [0, 2, 3, 7, 9, 10]
  case mi7add13 = "mi7(add13)"            // [0, 3, 7, 9, 10]

  // MARK: Phrygian
  case mi7b9 = "mi7(♭9)"                  // [0, 1, 3, 7, 10]
  case mi7b9b13  = "mi7(♭9♭13)"           // [0, 1, 3, 7, 8, 10]
  case mi11b9 = "mi11(♭9)"                // [0, 1, 3, 5, 7, 10]
  case mi11b9b13 = "mi11(♭9♭13)"          // [0, 1, 3, 5, 7, 8, 10]
  case mi13b9 = "mi13(♭9)"                // [0, 1, 3, 5, 7, 9, 10]

  // MARK: Min(♭13)
  case mib6 = "mi(♭6)"                    // [0, 3, 7, 8]
  case mi7b13 = "mi7(♭13)"                // [0, 3, 7, 8, 10]
  case mi9b13 = "mi9(♭13)"                // [0, 2, 3, 7, 8, 10]
  case mi11b13 = "mi11(♭13)"              // [0, 2, 3, 5, 7, 8, 10]
  case mi11b13omit9 = "mi11(♭13 omit9)"  // [0, 3, 5, 7, 8, 10]

  // MARK: mi7(♭5)
  case mi7b5 = "mi7(♭5)"                  // [0, 3, 6, 10]
  case mi9b5 = "mi9(♭5)"                  // [0, 2, 3, 6, 10]
  case mi7b5add11 = "mi7(♭5add11)"        // [0, 3, 5, 6, 10]
  case mi11b5 = "mi11(♭5)"                // [0, 2, 3, 5, 6, 10]
  case mi11b5b13 = "mi11(♭5♭13)"          // [0, 2, 3, 5, 6, 8, 10] (locrian ♯2)
  case mi7b5b9 = "mi7(♭5♭9)"              // [0, 1, 3, 6, 10]
  case mi11b5b9 = "mi11(♭5♭9)"            // [0, 1, 3, 5, 6, 10]
  case mi7b5b13 = "mi7(♭5♭13)"            // [0, 3, 6, 8, 10]
  case locrian = " locrian"               // [0, 1, 3, 5, 6, 8, 10] (mi11(♭5♭9♭13))
  case mi13b5 = "mi13(♭5)"                // [0, 2, 3, 5, 6, 9, 10] (dorian ♭5 / 2nd mode harmonic major)
  case mi13b5omit9 = "mi13(♭5 omit9)"    // [0, 3, 5, 6, 9, 10]
  case mi13b5omit11 = "mi13(♭5 omit11)"    // [0, 2, 3, 6, 9, 10]
  case mi7b5add13 = "mi7(♭5 add13)"       // [0, 3, 6, 9, 10]

  // MARK: diminished
  case dim7 = "˚7"                                      // [0, 3, 6, 9]
  case dim7b13 = "˚7(♭13)"                             // [0, 3, 6, 8, 9]
  case dim7addMa7 = "˚7(add∆7)"                       // [0, 3, 6, 9, 11]
  case dim7b13addMa7 = "˚7(♭13add∆7)"                // [0, 3, 6, 8, 9, 11]
  case dim9 = "˚9"                                      // [0, 2, 3, 6, 9]
  case dim9addMa7 = "˚9(add∆7)"                       // [0, 2, 3, 6, 9, 11]
  case dim9b13 = "˚9(♭13)"                             // [0, 2, 3, 6, 8, 9]
  case dim9b13addMa7 = "˚9(♭13add∆7)"                // [0, 2, 3, 6, 8, 9, 11]
  case dim11 = "˚11"                                    // [0, 2, 3, 5, 6, 9]
  case dim7add11 = "˚7(add11)"                         // [0, 3, 5, 6, 9]
  case dim11b13 = "˚11(♭13)"                           // [0, 2, 3, 5, 6, 8, 9]
  case dim11b13omit9 = "˚11(♭13 omit9)"               // [0, 3, 5, 6, 8, 9]
  case dim11addMa7 = "˚11(add∆7)"                     // [0, 2, 3, 5, 6, 9, 11]
  case dim11addMa7omit9 = "˚11(add∆7 omit9)"         // [0, 3, 5, 6, 9, 11]
  case dim11b13addMa7 = "˚11(♭13add∆7)"              // [0, 2, 3, 5, 6, 8, 9, 11]
  case dim11b13addMa7omit9 = "˚11(♭13add∆7 omit9)"  // [0, 3, 5, 6, 8, 9, 11]

  // MARK: Diminished Ma7 Chords
  case dimMa7 = "˚ma7"                        // [0, 3, 6, 11]
  case dimMa9 = "˚ma9"                        // [0, 2, 3, 6, 11]
  case dimMa11 = "˚ma11"                      // [0, 2, 3, 5, 6, 11]
  case dimMa7b13 = "˚ma7(♭13)"                // [0, 3, 6, 8, 11]
  case dimMa9b13 = "˚ma9(♭13)"                // [0, 2, 3, 6, 8, 11]
  case dimMa11b13 = "˚ma11(♭13)"              // [0, 2, 3, 5, 6, 8, 11]
  case dimMa11b13omit9 = "˚ma11(♭13 omit9)"   // [0, 3, 5, 6, 8, 11]

  // MARK: Major 6
  case ma6 = "6"                           // [0, 4, 7, 9]
  case ma6sh9 = "6(♯9)"                   // [0, 3, 4, 7, 9]
  case ma6b9 = "6(♭9)"                    // [0, 1, 4, 7, 9]
  case ma6sh9sh11 = "6(♯9♯11)"           // [0, 3, 4, 6, 7, 9]
  case ma6b9sh11 = "6(♭9♯11)"             // [0, 1, 4, 6, 7, 9]
  case ma6sh11 = "6(♯11)"                 // [0, 4, 6, 7, 9]
  case ma69 = "⁶/₉"                       // [0, 2, 4, 7, 9]
  case ma69sh11 = "⁶/₉(♯11)"              // [0, 2, 4, 6, 7, 9]

  // MARK: minor 6
  case mi6 = "mi6"                         // [0, 3, 7, 9]
  case mi69 = "mi⁶/₉"                     // [0, 3, 4, 7, 9]
  case mi6911 = "mi⁶/₉(11)"              // [0, 3, 4, 5, 7, 9]

  // MARK: mi(∆7)
  case miMa7 = "mi(∆7)"                       // [0, 3, 7, 11]
  case miMa9 = "mi(∆9)"                       // [0, 2, 3, 7, 11]
  case miMa11 = "mi(∆11)"                     // [0, 2, 3, 5, 7, 11]
  case miMa11omit9 = "mi(∆11 omit9)"         // [0, 3, 5, 7, 11]
  case miMa13 = "mi(∆13)"                     // [0, 2, 3, 5, 7, 9, 11]
  case miMa13omit9 = "mi(∆13 omit9)"         // [0, 3, 5, 7, 9, 11]

  var preciseName: String { self == .ma ? "ma" : self.rawValue }

  // MARK: commonName
  var commonName: String {
    switch self {
    case .ma13omit9:
      return "ma13"
    case .ma13b5omit9:
      return "ma13(♭5)"
    case .ma13sh11omit9:
      return "ma13(♯11)"
    case .ma13sh5omit9:
      return "ma13(♯5)"
    case .ma13sh5sh11omit9:
      return "ma13(♯5♯11)"
    case .ma13sus4omit9:
      return "ma13sus4"
    case .dominant13omit9:
      return "13"
    case .dominant7altb9sh9sh11, .dominant7altb9sh9b5, .dominant7altb9sh5sh11,
        .dominant7altb9sh9sh5sh11, .dominant7altsh9sh5sh11:
      return "7alt"
    case .dominant13sh11omit9:
      return "13(♯11)"
    case .dominant13b5omit9:
      return "13(♭5)"
    case .dominant13sus4omit9:
      return "13sus4"
    case .mi11omit9:
      return "mi11"
    case .mi13omit9, .mi13omit11:
      return "mi13"
    case .mi11b13omit9:
      return "mi11(♭13)"
    case .mi13b5omit9, .mi13b5omit11:
      return "mi13(♭5)"
    case .dim11b13omit9:
      return "˚11(♭13)"
    case .dim11addMa7omit9:
      return "˚11(add∆7)"
    case .dim11b13addMa7omit9:
      return "˚11(♭13 add∆7)"
    case .dimMa11b13omit9:
      return "˚ma11(♭13)"
    case .miMa11omit9:
      return "mi(∆11)"
    case .miMa13omit9:
      return "mi(∆13)"
    default:
      return rawValue
    }
  }
}

// MARK: Initializers
extension ChordType {
  /// Failable initializer from a set of degreeNumbers.
  ///
  /// Compares `degreeNumbers` against an array of ``ChordType`` enum cases
  /// - Note: the ``ChordType`` array isfiltered by `count` using `ChordType.typeByDegreesInCFiltered`
  init?(fromDegreeNumbersToMatch degreeNumbers: [Int]) {
    let count = degreeNumbers.count

    if let chordType = ChordType.typeByDegreeNumbersInCFiltered(degreeNumberCount: count)[degreeNumbers] {
      self = chordType
    } else {
      return nil
    }
  }

  /// Failable initializer from two chords.
  ///
  /// - Combines the `degreeNumbers` arrays from both chords into a set to filter out duplicates.
  /// - Tranposes the combined set to an array in the key of C
  ///   - Note: *(C is 0 in a range of 0-11)*
  /// - After transposing, sorts the array in ascending order before initializing
  init?(from firstChord: Chord, and secondChord: Chord) {
    let combinedDegreeSet = firstChord.voicingCalculator.degreeNumbers
      .combineSetFilter(secondChord.voicingCalculator.degreeNumbers)

    let combinedDegreesInC = Array(combinedDegreeSet).transposed(to: firstChord.rootKeyNote)

    self.init(fromDegreeNumbersToMatch: combinedDegreesInC)
  }

  /// Failable initializer from a set of `degreeNumbers` plus a ``RootKeyNote`` to use as a basis for transposition
  ///
  /// - Tranposes the combined set to an array in the key of C, relative to the supplied `rootKeyNote`
  ///   - Note: *(C is 0 in a range of 0-11)*
  /// - After transposing, sorts the array in ascending order before initializing
  init?(fromDegreeNumbers degreeNumbers: [Int], transposedTo rootKeyNote: RootKeyNote) {
    let degreeNumbersTransposed = degreeNumbers.transposed(to: rootKeyNote)

    self.init(fromDegreeNumbersToMatch: degreeNumbersTransposed)
  }

  /// Failable initializer from a set of `degreeNumbers` and a ``RootKeyNote``
  ///
  /// - The ``RootKeyNote`` is usually the lower chord's root
  /// - The initializer filters out the ``RootKeyNote``'s degree from `degreeNumbers` before initializing
  init?(fromDegreeNumbers degreeNumbersInC: [Int], withRootToFilter rootKeyNote: RootKeyNote) {
    var degreeNumbersInCFiltered = degreeNumbersInC

    guard let index = degreeNumbersInCFiltered.firstIndex(
      where: { $0 == rootKeyNote.keyName.noteNumber.rawValue }) else { return nil
    }

    degreeNumbersInCFiltered.remove(at: index)

    self.init(fromDegreeNumbersToMatch: degreeNumbersInCFiltered)
  }
}

// MARK: Comparable compliance
extension ChordType: Comparable {
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}
