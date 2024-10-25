//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ChordsAndScales: RootNote, GettableKeyName, EnharmonicID, DegreeNumbers {
  var rootKeyNote: RootKeyNote { get }
  var keys: [KeyName] { get }
  var commonName: String { get }
  var allNotes: [Note] { get set }
  var noteNames: [String] {get}
  var noteNumbers: [NoteNumber] { get }
  var notesByNoteNumber: [NoteNumber: Note] { get }
  var degreeNames: (names: [String], numeric: [String], long: [String]) { get }
  var degreeNamesByNoteNumber: (names: [NoteNumber:String], numeric: [NoteNumber:String], long: [NoteNumber:String]) { get }
  
  mutating func swapEnharmonic()
  mutating func switchEnharmonic(to: EnharmonicSymbol)
}

extension ChordsAndScales {
  var keyName: KeyName { rootKeyNote.keyName }
  
  var keys: [KeyName] { allNotes.map { $0.keyName } }
  
  var noteNames: [String] { allNotes.map { $0.noteName } }
  
  var notesByNoteNumber: [NoteNumber: Note] {
    var notesByNoteNumber: [NoteNumber: Note] = [:]
    notesByNoteNumber.reserveCapacity(12)
    notesByNoteNumber = allNotes.keyed { $0.noteNumber }

    return notesByNoteNumber
  }
  
  var degreeNumbers: [Int] { allNotes.map { $0.noteNumber.rawValue } }
  
  var degreeNames: (names: [String], numeric: [String], long: [String]) {
    return (names: allNotes.map { $0.degreeName.name },
            numeric: allNotes.map { $0.degreeName.numeric },
            long: allNotes.map { $0.degreeName.long })
  }
  
  var degreeNamesByNoteNumber: (names: [NoteNumber:String], numeric: [NoteNumber:String], long: [NoteNumber:String]) {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.names)),
            numeric: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.numeric)),
            long: Dictionary(uniqueKeysWithValues: zip(noteNumbers, degreeNames.long)))
  }
  
  mutating func swapEnharmonic() {
    switch enharmonic {
    case .flat, .sharp:
      enharmonic = enharmonic == .flat ? .sharp : .flat
    case .blackKeyFlats, .blackKeySharps:
      enharmonic = enharmonic == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
    }
    rootNote.note.swapEnharmonic()
  }
  
  mutating func switchEnharmonic(to enharmonic: EnharmonicSymbol) {
    self.enharmonic = enharmonic
    rootNote.note.switchEnharmonic(to: enharmonic)
  }
}
