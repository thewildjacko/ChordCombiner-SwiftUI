//
//  ChordGrapher.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/3/24.
//

import Foundation

struct ChordGrapher {
  enum GrapherConstants: String {
    case arrow = " -> "
    case openBracket = "{ "
    case closedBracket = " }"
  }
  
  var chord: Chord
  
  var chordToNotes: String {
    var chordToNotes: String = chord.preciseName + GrapherConstants.arrow.rawValue + GrapherConstants.openBracket.rawValue
    for note in chord.notes {
      var noteName = note.noteName
      noteName = noteName.replacing(/♯/, with: "#")
      noteName = noteName.replacing(/♭/, with: "b")
      noteName = noteName.replacing(/𝄫/, with: "bb")
      noteName = noteName.replacing(/𝄪/, with: "x")
      chordToNotes.append("\"\(noteName)\" ")
    }
    
    chordToNotes.append(GrapherConstants.closedBracket.rawValue)
    
    return chordToNotes
    
    
  }
  
  init(chord: Chord) {
    self.chord = chord
  }
  
  
}
