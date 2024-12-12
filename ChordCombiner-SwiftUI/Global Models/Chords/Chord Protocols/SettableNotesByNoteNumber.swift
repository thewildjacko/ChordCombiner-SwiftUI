//
//  SettableNotesByNoteNumber.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/10/24.
//

import Foundation

typealias NotesByNoteNumber = [NoteNumber: Note]

protocol SettableNotesByNoteNumber {
  var notesByNoteNumber: NotesByNoteNumber { get set }
  
  mutating func setNotesByNoteNumber(_ notesByNoteNumberDictionary: NotesByNoteNumber)
}

extension SettableNotesByNoteNumber {
  mutating func setNotesByNoteNumber(_ notesByNoteNumberDictionary: NotesByNoteNumber) {
    notesByNoteNumber.reserveCapacity(12)
    
    notesByNoteNumber = notesByNoteNumberDictionary
  }
}
