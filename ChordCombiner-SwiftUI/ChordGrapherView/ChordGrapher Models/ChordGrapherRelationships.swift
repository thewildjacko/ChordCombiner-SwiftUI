//
//  ChordGrapherRelationships.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/6/24.
//


import Foundation
//import Algorithms

// TODO: 
struct ChordGrapherRelationships {
  // MARK: stored properties
  var parentChord: ChordGrapherParentChord
  
  /// returns an appropriate dot-notation string for the initial children, based on `parentChord.elementsContained`
  private var nextLevelDownString: String = ""
  
  /// a dot-notation string describing the relationship between the parent chord and initial children
  var parentToFirstChildLevelString: String = ""
  
  /// a 2-dimensional array of groups of 4-note simple chords that contain each triad of the parent chord
  private var fourNoteChordsByTriad: [[Chord]] = [[]]
  
  /// an array of dot-notation strings describing the parent-child relationships between the 4-note simple chord groups and the triads they contain (see ``fourNoteSimpleChordsByTriad``), sorted in ascending degree order of ``parentChord``'s notes.
  var fourNoteChordsToTriadStrings: [String] = []
  
  /// a 2-dimensional array of 4-note chord groups that don't contain triads
  private var fourNoteChordsWithoutTriadsByNote: [[Chord]] = [[]]
  
  /// a 2-dimensional array of groups of triads that contain each note of the parent chord
  private var triadsByNote: [[Chord]] = [[]]
  
  /// an array of dot-notation strings describing the parent-child relationships between the chord groups and the notes they contain (see ``triadsByNote``), sorted in ascending degree order of ``parentChord``'s notes.
  var noteToChordsStrings: [String] = []
  
  /// an array of rankSame strings for 4-note chords, triads and notes, including only those items that aren't empty.
  var rankSameStrings: [String] = []
  
  // MARK: Initializer
  init(parentChord: ChordGrapherParentChord) {
    self.parentChord = parentChord
    
    nextLevelDownString = getNextLevelDownString()
    parentToFirstChildLevelString = parentChord.dotName.pointingTo(nextLevelDownString)
    
    fourNoteChordsByTriad = getFourNoteChordsByTriad()
    fourNoteChordsToTriadStrings = getFourNoteChordsToTriadStrings()
    
    fourNoteChordsWithoutTriadsByNote = parentChord.notes.chordsContainNote(chords: parentChord.fourNoteChordsWithoutTriads)
    triadsByNote = parentChord.notes.chordsContainNote(chords: parentChord.triads)
    noteToChordsStrings = getNoteToChordsStrings()
    
    rankSameStrings = getRankSameStrings()
  }
  
  // MARK: private instance methods
  /// build ``nextLevelDownString`` based on ``parentChord.elementsContained``
  private func getNextLevelDownString() -> String {
    var nextLevelDownString: String {
      switch parentChord.elementsContained {
      case .all:
        return parentChord.fourNoteChords.toDotNotationString(bracketed: false)
      case .triadsAndNotes:
        return parentChord.triads.toDotNotationString(bracketed: false)
      case .notes:
        return parentChord.dotNotes
      }
    }
    
    return nextLevelDownString.bracketedAndPadded()
  }
  
  /// build ``fourNoteChordsByTriad``
  private func getFourNoteChordsByTriad() -> [[Chord]] {
    return parentChord.triads.map { triad in
      parentChord.fourNoteChords.filter { fourNoteChord in
        fourNoteChord.contains(triad)
      }
    }
  }
  
  /// build ``fourNoteChordsToTriadStrings`` array
  private func getFourNoteChordsToTriadStrings() -> [String] {
    var fourNoteChordsToTriadStrings: [String] = []
    
    for i in (0..<parentChord.triads.count) {
      if !fourNoteChordsByTriad[i].isEmpty {
        let fourNoteChordsString = fourNoteChordsByTriad[i].toDotNotationString(bracketed: true)
        
        let triadString = parentChord.triads[i].getDotNotationName()
        
        fourNoteChordsToTriadStrings.append(fourNoteChordsString.pointingTo(triadString))
      }
    }
    
    return fourNoteChordsToTriadStrings
  }
  
  /// build the ``noteToChordsStrings``
  private func getNoteToChordsStrings() -> [String] {
    var noteToChordsStrings: [String] = []
    
    for i in (0..<parentChord.notes.count) {
      var chords = fourNoteChordsWithoutTriadsByNote[i] + triadsByNote[i]
      
      if !parentChord.notesWithoutChords.isEmpty &&
          parentChord.notesWithoutChords.contains(parentChord.notes[i]) {
        chords.append(parentChord.chord)
      }
      
      let chordsString = chords.map { $0.getDotNotationName() }
        .joined(separator: " ")
        .bracketedAndPadded()
      
      let noteString = parentChord.notes[i].getDotNotationName()
      
      noteToChordsStrings.append(chordsString.pointingTo(noteString))
    }
        
    return noteToChordsStrings
  }
  
  /// returns a dot-notation string describing equal rankings for items on the same level, such as 4-note chords, triads or notes.
  ///
  /// - Parameter items: an array of `Strings`, such as chord or note names, to map to dot notation.
  private func rankSame(items: [String]) -> String {
    let rankSame = String.GrapherConstants.rankSame.rawValue
    let dotItems = items.map { $0.toDotNotation() }.joined(separator: " ")
    
    return (rankSame + dotItems).bracketedAndPadded()
  }
  
  /// build the ``rankSameStrings``
  private func getRankSameStrings() -> [String] {
    let notes: [String] = parentChord.notes.map { $0.noteName }
    let fourNoteChords: [String]? = !parentChord.fourNoteChords.isEmpty ?
    parentChord.fourNoteChords.map { $0.preciseName } : nil
    let triads: [String]? = !parentChord.triads.isEmpty ?
    parentChord.triads.map { $0.preciseName } : nil
    
    let rankSameOptionalStrings: [[String]?] = [notes, fourNoteChords, triads]
    let rankSameStringsCompacted = rankSameOptionalStrings.compacted()
    
    var rankSameStrings: [String] = []
    
    for items in rankSameStringsCompacted {
      rankSameStrings.append(rankSame(items: items))
    }
    
    return rankSameStrings
  }
  
  // MARK: instance methods
  func appendRelationshipStrings(toItems: inout [String], stringsToAppend: [String]) {
    for string in stringsToAppend { toItems.append(string) }
  }
}
