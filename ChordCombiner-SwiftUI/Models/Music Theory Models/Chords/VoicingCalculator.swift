//
//  VoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/12/24.
//

import Foundation

struct VoicingCalculator {
  var type: ChordType
  var degrees: [Int]
  var startingOctave: Int
  var key: KeyName
  var rootNote: Root

  var root: Note { rootNote.note }
  var rootKey: RootGen { rootNote.rootKey }
  var baseChord: Chord { Chord(rootKey, type.baseChordType) }

  var raisedPitches: [Int] {
    return degrees.map { $0.toPitch(startingOctave: startingOctave) }
  }

  var raisedRoot: Int {
    rootNote.note.basePitchNum.toPitch(startingOctave: startingOctave)
  }
  

  var pitchesRaisedAboveRoot: [Int] {
    return raisedPitches.map {
      $0.raiseAbove(pitch: raisedRoot, degs: nil)
    }
  }

  var stackedPitches: [Int] {
    return pitchesRaisedAboveRoot.map {
       $0.raiseAboveDegreesIfAbsent(baseChord.pitchesRaisedAboveRoot)
    }
  }
  
  var noteNums: [NoteNum] {
    return degrees.map { NoteNum($0) }
  }
}
