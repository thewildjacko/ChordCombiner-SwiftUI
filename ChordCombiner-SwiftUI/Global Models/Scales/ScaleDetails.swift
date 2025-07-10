//
//  ScaleDetails.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

struct ScaleDetails {
  static let initial = ScaleDetails(
    root: Note(.c),
    scaleType: .major,
    notes: [])

  var root: Note = Note(.c)
  var scaleType: ScaleType = .major
  var notes: [Note] = []

  var noteNamesArray: [String] = []
  var noteNames: String { noteNamesArray.joined(separator: ", ") }

  var degreeNameGroup: DegreeNameGroup = DegreeNameGroup.initial
  var degreeNames: String { degreeNameGroup.numeric.joined(separator: ", ") }

  var name: String { root.noteName + " " + scaleType.rawValue }

  var alternateNames: [String] {
    scaleType.alternateNames.map { root.noteName + " " + $0 }
  }

  init(root: Note, scaleType: ScaleType, notes: [Note]) {
    self.root = root
    self.scaleType = scaleType
    self.notes = notes

    setNoteProperties()
  }

  mutating func setNoteProperties() {
    noteNamesArray = notes.noteNames()
    degreeNameGroup = notes.toDegreeNameGroup()
  }
}
