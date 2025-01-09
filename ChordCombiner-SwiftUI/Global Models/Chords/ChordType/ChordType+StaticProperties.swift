//
//  ChordType+StaticProperties.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//

import Foundation

// MARK: static properties
extension ChordType {
  static var allSimpleChordTypes = ChordType.allCases.filterInSimple()

  static var allExtendedChordTypes = ChordType.allCases.filter { $0.isExtendedChord }

  static var allChordDegreeNumbers: [[Int]] { ChordType.allCases.map { $0.degreeNumbers }}

  static var typeByDegreeNumbers: [[Int]: ChordType] = Dictionary(
    uniqueKeysWithValues: zip(allChordDegreeNumbers, allCases)
  )

  static func typeByDegreeNumbersInCFiltered(degreeNumberCount: Int) -> [[Int]: ChordType] {
    typeByDegreeNumbers.filter { $0.key.count == degreeNumberCount }
  }

  static let triadTypes: [ChordType] = [.ma, .mi, .aug, .dim, .sus4, .sus2]
  static let primary7thChords: [ChordType] = [.ma7, .dominant7, .mi7, .mi7b5, .dim7, .miMa7]
  static let extendedMajor7thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .ma7 && $0 != .ma7
  }

  static let alteredMajor7thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .ma7b5 ||
    $0.baseChordType == .ma7sh5 ||
    $0.baseChordType == .ma7sh5sh11
  }

  static let extendedDominantChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .dominant7 && $0 != .dominant7
  }

  static let extendedDominant7b5Chords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .dominant7b5
  }

  static let extendedDominant7sh5Chords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .dominant7sh5
  }

  static let suspendedDominant7Chords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .dominant7sus4 || $0.baseChordType == .dominant7sus2
  }

  static let extendedMinor7thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .mi7 &&
    $0 != .mi7 &&
    !minorFlat13Chords.contains($0) &&
    !phrygianChords.contains($0)
  }

  static let extendedMinor7thb5Chords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .mi7b5 && $0 != .mi7b5
  }

  static let extendedDiminishedChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .dim7 && $0 != .dim7
  }

  static let extendedMajor6thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .ma6
  }

  static let extendedMinor6thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .mi6
  }

  static let extendedMinorMajor7thChords: [ChordType] = ChordType.allCases.filter {
    $0.baseChordType == .miMa7 && $0 != .miMa7
  }

  static let modifiedTriadTypes: [ChordType] = [.add4, .minorAdd4, .add2, .minorAdd2]

  static let phrygianChords: [ChordType] = [
    .mi7b9,
    .mi7b9b13,
    .mi11b9,
    .mi11b9b13,
    .mi13b9
  ]

  static let minorFlat13Chords: [ChordType] = [
    .mib6,
    .mi7b13,
    .mi9b13,
    .mi11b13,
    .mi11b13omit9
  ]

  static let allChordTypeArrays: [[ChordType]] = [
    triadTypes,
    primary7thChords,
    extendedMajor7thChords,
    alteredMajor7thChords,
    extendedDominantChords,
    extendedDominant7b5Chords,
    extendedDominant7sh5Chords,
    suspendedDominant7Chords,
    extendedMinor7thChords,
    extendedMinor7thb5Chords,
    extendedDiminishedChords,
    extendedMajor6thChords,
    extendedMinor6thChords,
    phrygianChords,
    minorFlat13Chords,
    extendedMinorMajor7thChords,
    modifiedTriadTypes
  ]

  static let sectionTitles: [String] = [
    "Triads",
    "Primary 7th Chords",
    "Extended Major 7th Chords",
    "Altered Major 7th Chords",
    "Extended Dominant Chords",
    "Extended 7(♭5) Chords",
    "Extended 7(♯5) Chords",
    "Suspended Dominant Chords",
    "Extended Minor 7th Chords",
    "Extended mi7(♭5) Chords",
    "Extended Diminished Chords",
    "Extended Major 6th Chords",
    "Extended Minor 6th Chords",
    "Phrygian Chords",
    "Extended Min(♭13) Chords",
    "Extended mi(∆7) Chords",
    "Modified Triads"
  ]

  static let sectionTagNames: [String] = [
    "Triads",
    "Std. 7ths",
    "ma7",
    "Alt. ma7",
    "dom7",
    "7(♭5)",
    "7(♯5)",
    "7sus",
    "mi7",
    "mi7(♭5)",
    "dim7",
    "ma6",
    "mi6",
    "Phrygian",
    "mi(♭13)",
    "mi(∆7)",
    "Mod. Triads"
  ]

  static var chordTypeSections: [ChordTypeSection] {
    var chordTypeSections: [ChordTypeSection] = []

    for (index, title) in sectionTitles.enumerated() {
      chordTypeSections.append(
        ChordTypeSection(
          id: index,
          title: title,
          tagName: sectionTagNames[index],
          chordTypes: allChordTypeArrays[index]
        )
      )
    }

    return chordTypeSections
  }

  static let sectionTitlesIndexed = sectionTitles.indexed()
  static let allChordTypeArraysIndexed = allChordTypeArrays.indexed()

  static let sectionsWithTitles = Array(zip(ChordType.sectionTitles, ChordType.allChordTypeArrays))

  static let allChordTypesMinusOmits: [[ChordType]] = allChordTypeArrays.map { $0.filterOmits() }

  static let allSimpleChordTypesMinusOmits: [[ChordType]] = allChordTypeArrays.map {
    $0.filterOmits().filterInSimple()
  }.filter { !$0.isEmpty }

  static let allChordTypesSorted: [ChordType] = allChordTypeArrays.flatMap { $0 }
  static let allChordTypesMinusOmitsSorted: [ChordType] = allChordTypesMinusOmits.flatMap { $0 }
}

extension ChordType {
  static let helpViewPickerDemoTypes: Set<ChordType> = [
    .ma, .mi, .dim, .sus4, .add4, .minorAdd4, .dominant7,
    .dominant7sus4, .mi7, .mi7b13, .mi7b5, .ma6, .mi6
  ]
}
