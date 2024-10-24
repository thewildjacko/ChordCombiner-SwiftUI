//
//  DegreeAndPitchOperator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/13/24.
//

import Foundation

protocol DegreeNumbers {
  var degreeNumbers: [Int] { get set }
  var degreeNumberSet: Set<Int> { get }
}

extension DegreeNumbers {
  var degreeNumberSet: Set<Int> { Set(degreeNumbers) }
}

protocol StartingOctave {
  var startingOctave: Int { get set }
}

protocol StartingPitch {
  var startingPitch: Int { get }
}

protocol OctaveAndPitch: StartingOctave, StartingPitch { }

protocol DegreeAndPitchNumberOperator: RootNote, DegreeNumbers, StartingOctave  {
  var noteNumbers: [NoteNumber] { get }
  var raisedPitches: [Int] { get }
  var raisedRoot: Int { get }
  var pitchesRaisedAboveRoot: [Int] { get }
  var stackedPitches: [Int] { get }
}

extension DegreeAndPitchNumberOperator {
  var raisedPitches: [Int] {
    return degreeNumbers.map { $0.toPitch(startingOctave: startingOctave) }
  }

  var raisedRoot: Int {
    rootNote.note.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }
  
  var pitchesRaisedAboveRoot: [Int] {
    return raisedPitches.map {
      $0.raiseAbove(pitch: raisedRoot, degreeNumbers: nil)
    }
  }
}
