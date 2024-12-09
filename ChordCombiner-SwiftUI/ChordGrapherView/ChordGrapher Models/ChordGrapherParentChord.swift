//
//  ChordGrapherParentChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/6/24.
//

import Foundation

typealias ElementsContained = ChordGrapherParentChord.ElementsContained

struct ChordGrapherParentChord {
  // MARK: stored properties
  
  /// the parent chord for the graph
  let chord: Chord

  /// an array of all the triads and simple 4-note chords that the parent chord contains
  let containingChords: [Chord]/* { chord.containingChords() }*/
  
  /// the name of the parent chord in dot notation
  let dotName: String
  
  /// the notes of the parent chord
  let notes: [Note]
  
  /// a string joined from `notes`, mapped to dot notation
  let dotNotes: String
    
  /// an array of all simple 4-note chords that the parent chord contains
  let fourNoteChords: [Chord]
  
  /// all chords in ``fourNoteSimpleChords`` that don't contain triads
  let fourNoteChordsWithoutTriads: [Chord]
  
  /// an array of all triads that the parent chord contains
  let triads: [Chord]
  
  /// an array of ``Note``s that belong only to the parent chord, not to any containing chord
  var notesWithoutChords: [Note] = []
  
  // MARK: Initializer
  init(chord: Chord) {
    self.chord = chord
    
    containingChords = chord.containingChords()
    notes = chord.notes
    dotNotes = chord.notes.map { $0.getDotNotationName() }.joined(separator: " ")
    dotName = chord.getDotNotationName()
        
    fourNoteChords = Array(
      sortedByNotes: notes,
      fromChords: containingChords.filterInFourNoteChords()
    )
    
    fourNoteChordsWithoutTriads = fourNoteChords.filterInChordsContainingNoChords()
    
    triads = Array(
      sortedByNotes: notes,
      fromChords: containingChords.filterInTriads()
    )
    
    notesWithoutChords = notes.filter { note in
      !triads.contains(note) && !fourNoteChords.contains(note)
    }
  }
}

// MARK: ElementsContained
extension ChordGrapherParentChord {
  /// an enum to check which smaller musical structures the parent chord contains.
  ///
  /// Examples include:
  ///
  /// - 4-note-chords, triads, and notes;
  /// - Triads and notes;
  /// - Notes only
  enum ElementsContained {
    case all, triadsAndNotes, notes
  }
  
  /// Used to select the correct parent-child relationship for the initial child level
  ///
  /// Criteria:
  ///
  /// - If the parent chord contains 4-note chords, then the initial child level is 4-note chords
  /// - If the parent chord doesn't contain 4-note chords but does contain triads, then the initial child level is triads
  /// - If the parent chord contains neither 4-note chords nor triads, then the initial (and only) child level is notes
  var elementsContained: ElementsContained {
    guard !fourNoteChords.isEmpty else {
      guard !triads.isEmpty else {
        return .notes
      }
      return .triadsAndNotes
    }
    return .all
  }
}
