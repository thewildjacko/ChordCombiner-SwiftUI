//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ChordsAndScales: RootNote, GettableKeyName, EnharmonicID, Degrees {
  var rootKeyNote: RootKeyNote { get }
  var keys: [KeyName] { get }
  var commonName: String { get }
  var allNotes: [Note] { get set }
  var noteNames: [String] {get}
  var noteNums: [NoteNum] { get }
  var notesByNoteNum: [NoteNum: Note] { get }
  var degreeNames: (names: [String], numeric: [String], long: [String]) { get }
  var degreeNamesByNoteNum: (names: [NoteNum:String], numeric: [NoteNum:String], long: [NoteNum:String]) { get }
  
  mutating func swapEnharmonic()
  mutating func switchEnharmonic(to: EnharmonicSymbol)
}

extension ChordsAndScales {
  var keyName: KeyName { rootKeyNote.keyName }
  
  var keys: [KeyName] { allNotes.map { $0.keyName } }
  
  var noteNames: [String] { allNotes.map { $0.noteName } }
  
  var notesByNoteNum: [NoteNum: Note] {
    var notesByNoteNum: [NoteNum: Note] = [:]
    notesByNoteNum.reserveCapacity(12)
    notesByNoteNum = allNotes.keyed { $0.noteNum }
    //    notesByNoteNum = Dictionary(uniqueKeysWithValues: zip(noteNums, allNotes))
    return notesByNoteNum
  }
  
  var degrees: [Int] { allNotes.map { $0.noteNum.rawValue } }
  
  var degreeNames: (names: [String], numeric: [String], long: [String]) {
    return (names: allNotes.map { $0.degreeName.name },
            numeric: allNotes.map { $0.degreeName.numeric },
            long: allNotes.map { $0.degreeName.long })
  }
  
  var degreeNamesByNoteNum: (names: [NoteNum:String], numeric: [NoteNum:String], long: [NoteNum:String]) {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNums, degreeNames.names)),
            numeric: Dictionary(uniqueKeysWithValues: zip(noteNums, degreeNames.numeric)),
            long: Dictionary(uniqueKeysWithValues: zip(noteNums, degreeNames.long)))
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
