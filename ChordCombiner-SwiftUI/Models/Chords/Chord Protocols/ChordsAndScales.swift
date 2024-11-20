//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// Protocol to use for both ``Chord`` and Scale objects—essentially any multi-note object.
///
/// - Note: Scale hasn't been implemented yet, beyond the scope of the project
protocol ChordsAndScales: RootNote, GettableKeyName, EnharmonicID, DegreeNumbers {
  var rootKeyNote: RootKeyNote { get }
  var keys: [KeyName] { get }
  var commonName: String { get }
  var notes: [Note] { get set }
  var rootKeyNotes: [RootKeyNote] { get }
  var noteNames: [String] {get}
  var noteNumbers: [NoteNumber] { get }
  var notesByNoteNumber: [NoteNumber: Note] { get }
  var degreeNames: (names: [String], numeric: [String], long: [String]) { get }
  var degreeNamesByNoteNumber: (names: [NoteNumber:String], numeric: [NoteNumber:String], long: [NoteNumber:String]) { get }
}

extension ChordsAndScales {
  var keyName: KeyName { rootKeyNote.keyName }
  
  var keys: [KeyName] { notes.map { $0.keyName } }
  var rootKeyNotes: [RootKeyNote] { notes.map { RootKeyNote($0.keyName) } }

  var noteNames: [String] { notes.map { $0.noteName } }
  
  var notesByNoteNumber: [NoteNumber: Note] {
    var notesByNoteNumber: [NoteNumber: Note] = [:]
    notesByNoteNumber.reserveCapacity(12)
    notesByNoteNumber = notes.keyed { $0.noteNumber }

    return notesByNoteNumber
  }
  
  var degreeNumbers: [Int] { notes.map { $0.noteNumber.rawValue } }
  
  var degreeNames: (names: [String], numeric: [String], long: [String]) {
    return (names: notes.map { $0.degreeName.name },
            numeric: notes.map { $0.degreeName.numeric },
            long: notes.map { $0.degreeName.long })
  }
  
  var degreeNamesByNoteNumber: (names: [NoteNumber:String], numeric: [NoteNumber:String], long: [NoteNumber:String]) {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.names)),
            numeric: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.numeric)),
            long: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.long)))
  }
}
