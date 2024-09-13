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
  var name: String { get }
  var allNotes: [Note] { get set }
  var noteNames: [String] {get}
  var noteNums: [NoteNum] { get }
  var notesByNoteNum: [NoteNum: Note] { get }
  var degreeNames: (names: [String], short: [String], long: [String]) { get }
  var degreeNamesByNoteNum: (names: [NoteNum:String], short: [NoteNum:String], long: [NoteNum:String]) { get }
  
  mutating func swapEnharmonic()
  mutating func switchEnharmonic(to: EnharmonicSymbol)
}

extension ChordsAndScales {
  var keyName: KeyName { rootKeyNote.keyName }
  
  var keys: [KeyName] { allNotes.map { $0.keyName } }
  
  var noteNames: [String] { allNotes.map { $0.noteName } }
  
  var notesByNoteNum: [NoteNum: Note] {
    Dictionary(uniqueKeysWithValues: zip(noteNums, allNotes))
  }
  
  var degrees: [Int] { allNotes.map { $0.noteNum.rawValue } }
  
  var degreeNames: (names: [String], short: [String], long: [String]) {
    return (names: allNotes.map { $0.degreeName.name },
            short: allNotes.map { $0.degreeName.short },
            long: allNotes.map { $0.degreeName.long })
  }
  
  var degreeNamesByNoteNum: (names: [NoteNum:String], short: [NoteNum:String], long: [NoteNum:String]) {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNums, degreeNames.names)),
            short: Dictionary(uniqueKeysWithValues: zip(noteNums, degreeNames.short)),
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
