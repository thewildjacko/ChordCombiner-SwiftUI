//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

typealias DegreeNames = (names: [String], numeric: [String], long: [String])
typealias DegreeNamesByNoteNumber = (names: [NoteNumber:String], numeric: [NoteNumber:String], long: [NoteNumber:String])

/// Protocol to use for both ``Chord`` and Scale objects—essentially any multi-note object.
///
/// - Note: Scale hasn't been implemented yet, beyond the scope of the project
protocol ChordsAndScales: RootNote, GettableKeyName, EnharmonicID, DegreeNumbers, SettableNotesByNoteNumber {
  var rootKeyNote: RootKeyNote { get }
  var commonName: String { get }
  var notes: [Note] { get set }
  var rootKeyNotes: [RootKeyNote] { get set }
  var noteNames: [String] { get set }
  var noteNumbers: [NoteNumber] { get set }
  
  var degreeNames: DegreeNames { get set }
  func degreeNamesByNoteNumber() -> DegreeNamesByNoteNumber
}

extension ChordsAndScales {
  func degreeNamesByNoteNumber() -> DegreeNamesByNoteNumber {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.names)),
            numeric: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.numeric)),
            long: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.long)))
  }
}
