//
//  ChordDetails.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/18/25.
//

import Foundation

struct ChordDetails {
  static let initial = ChordDetails(
    root: Note(.c),
    chordType: .ma,
    notes: [])

  var root: Note = Note(.c)
  var chordType: ChordType = .ma
  var notes: [Note] = []

  var noteNamesArray: [String] = []
  var noteNames: String { noteNamesArray.joined(separator: ", ") }

  var degrees: [Degree] = []
  var degreeNameGroup: DegreeNameGroup = DegreeNameGroup.initial
  var degreeNames: String { degreeNameGroup.numeric.joined(separator: ", ") }
  var otherDegreeNames: String { notes.map { $0.degreeName.numeric }.joined(separator: ", ") }

  var commonName: String { root.noteName + chordType.commonName }
  var preciseName: String { root.noteName + chordType.preciseName }

  init(root: Note, chordType: ChordType, notes: [Note]) {
    self.root = root
    self.chordType = chordType
    self.notes = notes

    setNoteProperties()
  }

  mutating func setNoteProperties() {
    noteNamesArray = notes.noteNames()
    degrees = notes.toDegrees()
    degreeNameGroup = notes.toDegreeNameGroup()
  }

  func degreeNamesByNoteNumber() -> DegreeNamesByNoteNumberGroup {
    return DegreeNamesByNoteNumberGroup(
      names: Dictionary(
        uniqueKeysWithValues: zip(notes.noteNumbers(), degreeNameGroup.names)),
      numeric: Dictionary(
        uniqueKeysWithValues: zip(notes.noteNumbers(), degreeNameGroup.numeric)),
      long: Dictionary(
        uniqueKeysWithValues: zip(notes.noteNumbers(), degreeNameGroup.long)))
  }
}
