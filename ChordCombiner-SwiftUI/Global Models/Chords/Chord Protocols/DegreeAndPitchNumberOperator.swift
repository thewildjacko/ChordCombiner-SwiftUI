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
  var startingPitch: Int { get set }
}

protocol OctaveAndPitch: StartingOctave, StartingPitch { }

protocol DegreeAndPitchNumberOperator: RootNote, DegreeNumbers, StartingOctave {
  var noteNumbers: [NoteNumber] { get set }
  var raisedPitches: [Int] { get set }
  var raisedRoot: Int { get set }
  var pitchesRaisedAboveRoot: [Int] { get set }
  var stackedPitches: [Int] { get }
}
