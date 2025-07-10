//
//  ChordType+baseChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//

import Foundation

typealias BaseChordType = ChordType.BaseChordType

extension ChordType {
  // swiftlint:disable identifier_name
  enum BaseChordType {
    case ma
    case mi
    case aug
    case dim
    case sus4
    case sus2

    case add4
    case add2
    case mib6
    case minorAdd4
    case minorAdd2

    case ma7
    case ma7b5
    case ma7sh5
    case ma7sh5sh11
    case ma7sus4
    case ma7sus4sh5

    case dominant7
    case dominant7b5
    case dominant7sh5

    case dominant7sus4
    case dominant7sus2

    case mi7
    case mi7b5
    case dim7
    case dimMa7
    case ma6
    case mi6
    case miMa7
  }
  // swiftlint:enable identifier_name

  var baseChordType: BaseChordType {
    switch self {
      // MARK: Triads
    case .ma:
      return .ma
    case .mi:
      return .mi
    case .aug:
      return .aug
    case .dim:
      return .dim
    case .sus4:
      return .sus4
    case .sus2:
      return .sus2
      // MARK: Modified triads
    case .add4:
      return .add4
    case .add2:
      return .add2
    case .mib6:
      return .mib6
    case .minorAdd4:
      return .minorAdd4
    case .minorAdd2:
      return .minorAdd2
      // MARK: Major 7th chords
    case .ma7, .ma9, .ma13, .ma13omit9, .ma7sh11, .ma9sh11, .ma13sh11, .ma13sh11omit9:
      return .ma7
      // MARK: Altered Major 7th Chords
      // MARK: ma7(♭5)
    case .ma7b5, .ma9b5, .ma13b5, .ma13b5omit9:
      return .ma7b5
      // MARK: ma7(♯5)
    case .ma7sh5, .ma9sh5, .ma13sh5, .ma13sh5omit9, .ma7sh5sh11,
        .ma9sh5sh11, .ma13sh5sh11, .ma13sh5sh11omit9:
      return .ma7sh5
      // MARK: Ma7(sus4) Chords
    case .ma7sus4, .ma9sus4, .ma13sus4, .ma13sus4omit9:
      return .ma7sus4
      // MARK: Altered Ma7(sus4) Chords
    case .ma7sus4sh5, .ma9sus4sh5:
      return .ma7sus4sh5
      // MARK: Dominant 7th Chords
      // MARK: unaltered
    case .dominant7,
        .dominant9,
        .dominant13,
        .dominant13omit9,
      // MARK: ♭9
        .dominant7b9,
        .dominant7b9sh9,
        .dominant7b9sh11,
        .dominant7altb9sh9sh11,
      // MARK: ♯9
        .dominant7sh9,
        .dominant7sh9sh11,
      // MARK: ♯11
        .dominant7sh11,
        .dominant9sh11,
        .dominant13sh11,
        .dominant13sh11omit9:
      return .dominant7
      // MARK: 7(♭5)
    case .dominant7b5,
        .dominant9b5,
        .dominant13b5,
        .dominant13b5omit9,
        .dominant7b9b5,
        .dominant7altb9sh9b5,
        .dominant7sh9b5:
      return .dominant7b5
      // MARK: 7(♯5)
    case .dominant7sh5,
        .dominant7sh5sh11,
        .dominant9sh5,
        .dominant7b9sh5,
        .dominant7sh9sh5,
        .dominant7altb9sh5sh11,
        .dominant7altb9sh9sh5sh11,
        .dominant7altsh9sh5sh11:
      return .dominant7sh5
      // MARK: 7sus4, 7sus2
    case .dominant7sus4, .dominant9sus4, .dominant13sus4, .dominant13sus4omit9,
        .dominant7sus4b9, .dominant13sus4b9:
      return .dominant7sus4
    case .dominant7sus2, .dominant13sus2:
      return .dominant7sus2
      // MARK: Minor 7th chords
      // Dorian
    case .mi7, .mi9, .mi11, .mi11omit9, .mi13, .mi13omit9, .mi13omit11, .mi7add13,
      // Natural minor
        .mi7b13, .mi9b13, .mi11b13, .mi11b13omit9,
      // Phrygian
        .mi7b9, .mi7b9b13, .mi11b9b13,
      // Phrygian or Dorian ♭2
        .mi11b9,
      // Dorian ♭2
        .mi13b9:
      return .mi7
      // MARK: Min7(♭5) chords
    case .mi7b5, .mi9b5, .mi7b5add11, .mi11b5, .mi11b5b13, .mi7b5b9, .mi11b5b9,
        .mi7b5b13, .locrian, .mi13b5, .mi13b5omit9, .mi13b5omit11, .mi7b5add13:
      return .mi7b5
      // MARK: Diminished
    case .dim7, .dim7b13, .dim7addMa7, .dim7b13addMa7, .dim9, .dim9addMa7,
        .dim9b13, .dim9b13addMa7, .dim11, .dim11b13, .dim11addMa7, .dim11b13addMa7,
        .dim7add11, .dim11b13omit9, .dim11addMa7omit9, .dim11b13addMa7omit9:
      return .dim7
      // MARK: Diminished Ma7 Chords
    case .dimMa7, .dimMa9, .dimMa11, .dimMa7b13, .dimMa9b13, .dimMa11b13, .dimMa11b13omit9:
      return .dimMa7
      // MARK: Major 6th chords
    case .ma6, .ma6sh9, .ma6b9, .ma6sh9sh11, .ma6b9sh11, .ma6sh11, .ma69, .ma69sh11:
      return .ma6
      // MARK: minor 6
    case .mi6, .mi69, .mi6911:
      return .mi6
      // MARK: mi(∆7)
    case .miMa7, .miMa9, .miMa11, .miMa13, .miMa11omit9, .miMa13omit9:
      return .miMa7
    }
  }
}
