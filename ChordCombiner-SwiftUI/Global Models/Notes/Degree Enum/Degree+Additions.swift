//
//  Degree+Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//

import Foundation

typealias DegreeNamesByNoteNumber = [NoteNumber: String]

struct DegreeName {
  var name: String
  var numeric: String
  var long: String
}

struct DegreeNameGroup {
  static let initial = DegreeNameGroup(names: [], numeric: [], long: [])

  var names: [String]
  var numeric: [String]
  var long: [String]
}

struct DegreeNamesByNoteNumberGroup {
  var names: DegreeNamesByNoteNumber
  var numeric: DegreeNamesByNoteNumber
  var long: DegreeNamesByNoteNumber
}

// MARK: Instance methods
extension Degree {
  //   swiftlint:disable cyclomatic_complexity
  func getKeyName(using keySwitcher: KeySwitcher, rootNumber: NoteNumber) -> KeyName {
    switch self {
    case .root, .octave, .perfect15th:
      keySwitcher.root(rootNumber: rootNumber)
    case .minor2nd, .minor9th:
      keySwitcher.minor9th(rootNumber: rootNumber)
    case .major2nd, .major9th:
      keySwitcher.major9th(rootNumber: rootNumber)
    case .sharp2nd, .sharp9th:
      keySwitcher.sharp9th(rootNumber: rootNumber)
    case .minor3rd, .minor10th:
      keySwitcher.minor3rd(rootNumber: rootNumber)
    case .major3rd, .major10th:
      keySwitcher.major3rd(rootNumber: rootNumber)
    case .flat4th, .flat11th:
      keySwitcher.dim4th(rootNumber: rootNumber)
    case .perfect4th, .perfect11th:
      keySwitcher.perfect4th(rootNumber: rootNumber)
    case .sharp4th, .sharp11th:
      keySwitcher.sharp4th(rootNumber: rootNumber)
    case .diminished5th, .diminished12th:
      keySwitcher.dim5th(rootNumber: rootNumber)
    case .perfect5th, .perfect12th:
      keySwitcher.perfect5th(rootNumber: rootNumber)
    case .sharp5th, .sharp12th:
      keySwitcher.sharp5th(rootNumber: rootNumber)
    case .minor6th, .flat13th:
      keySwitcher.minor6th(rootNumber: rootNumber)
    case .major6th, .major13th:
      keySwitcher.major6th(rootNumber: rootNumber)
    case .diminished7th, .diminished14th:
      keySwitcher.dim7th(rootNumber: rootNumber)
    case .minor7th, .minor14th:
      keySwitcher.minor7th(rootNumber: rootNumber)
    case .major7th, .major14th:
      keySwitcher.major7th(rootNumber: rootNumber)
    }
  }
  // swiftlint:enable cyclomatic_complexity
}

// MARK: Static properties
extension Degree {
  static let chordTones: [Degree] = [
    .root,
    .major2nd,
    .minor3rd,
    .major3rd,
    .perfect4th,
    .sharp4th,
    .diminished5th,
    .perfect5th,
    .sharp5th,
    .minor6th,
    .major6th,
    .diminished7th,
    .minor7th,
    .major7th,
    .minor9th,
    .major9th,
    .sharp9th,
    .perfect11th,
    .sharp11th,
    .flat13th,
    .major13th
  ]

}

// MARK: Static functions
extension Degree {
  // MARK: allNotesInKey
  static func allNotesInKey(rootKeyNote: RootKeyNote) -> [Note] {
    return Degree.allCases.map { Note($0, of: rootKeyNote)}
  }

  // MARK: allChordNotesInKey
  static func allChordNotesInKey(rootKeyNote: RootKeyNote) -> [Note] {

    return chordTones.map { Note($0, of: rootKeyNote)}
  }

  // MARK: setNotesByDegree
  static func setNotesByDegrees(rootKeyNote: RootKeyNote, degreeTags: [Degree]) -> [Note] {
    return degreeTags.map { Note($0, of: rootKeyNote)}
  }

  static func degreeNumbersInC(degreeTags: [Degree]) -> [Int] {
    return degreeTags.map { $0.noteNumber.rawValue }.sorted()
  }
}
