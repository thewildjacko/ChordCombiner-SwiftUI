//
//  DegreeAndPitchOperator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/13/24.
//

import Foundation

protocol Degrees {
  var degrees: [Int] { get set }
  var degSet: Set<Int> { get }
}

extension Degrees {
  var degSet: Set<Int> { Set(degrees) }
}

protocol StartingOctave {
  var startingOctave: Int { get set }
}

protocol StartingPitch {
  var startingPitch: Int { get }
}

protocol OctaveAndPitch: StartingOctave, StartingPitch { }

protocol DegreeAndPitchOperator: RootNote, Degrees, StartingOctave  {
  var noteNums: [NoteNum] { get }
  var raisedPitches: [Int] { get }
  var raisedRoot: Int { get }
  var pitchesRaisedAboveRoot: [Int] { get }
  var stackedPitches: [Int] { get }
}

extension DegreeAndPitchOperator {
  var raisedPitches: [Int] {
    return degrees.map { $0.toPitch(startingOctave: startingOctave) }
  }

  var raisedRoot: Int {
    rootNote.note.noteNum.rawValue.toPitch(startingOctave: startingOctave)
  }
  
  var pitchesRaisedAboveRoot: [Int] {
    return raisedPitches.map {
      $0.raiseAbove(pitch: raisedRoot, degs: nil)
    }
  }
}
