//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ChordsAndScales: RootKey {
  var key: KeyName { get }
  var keys: [KeyName] { get }
  var enharm: Enharmonic { get set }
  var name: String { get }
  var allNotes: [Note] { get set }
  var noteNames: [String] {get}
  var noteNums: [NoteNum] { get }
  var notesByNoteNum: [NoteNum:Note] { get }
  var degrees: [Int] { get }
  var degNames: (names: [String], short: [String], long: [String]) { get }
  var degNamesByNoteNum: (names: [NoteNum:String], short: [NoteNum:String], long: [NoteNum:String]) { get }
  
  mutating func swapEnharm()
  mutating func switchEnharm(to: Enharmonic)
}

extension ChordsAndScales {
  var key: KeyName {
    return rootKey.r
  }
  
  var keys: [KeyName] {
    return allNotes.map { $0.key }
  }
  
  var noteNames: [String] {
    return allNotes.map { $0.noteName }
  }
  
  var degrees: [Int] {
    return allNotes.map {$0.num}
  }
  
  var notesByNoteNum: [NoteNum:Note] {
    return Dictionary(uniqueKeysWithValues: zip(noteNums, allNotes))
  }
  
  var degNames: (names: [String], short: [String], long: [String]) {
    return (names: allNotes.map { $0.degName.name.rawValue },
            short: allNotes.map { $0.degName.short.rawValue },
            long: allNotes.map { $0.degName.long.rawValue })
  }
  
  var degNamesByNoteNum: (names: [NoteNum:String], short: [NoteNum:String], long: [NoteNum:String]) {
    return (names: Dictionary(uniqueKeysWithValues: zip(noteNums, degNames.names)),
            short: Dictionary(uniqueKeysWithValues: zip(noteNums, degNames.short)),
            long: Dictionary(uniqueKeysWithValues: zip(noteNums, degNames.long)))
  }
  
  mutating func swapEnharm() {
    switch enharm {
    case .flat, .sharp:
      enharm = enharm == .flat ? .sharp : .flat
    case .blackKeyFlats, .blackKeySharps:
      enharm = enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
    }
    root.swapEnharm()
  }
  
  mutating func switchEnharm(to enharm: Enharmonic) {
    self.enharm = enharm
    root.switchEnharm(to: enharm)
  }
}
