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
  var degreeNumbersSorted: [Int] { get }
  var degreeNumbersPlusOctave: [Int] { get }
}

extension DegreeNumbers {
  var degreeNumberSet: Set<Int> { degreeNumbers.toSet() }
  var degreeNumbersSorted: [Int] { degreeNumbers.sorted() }

  var degreeNumbersPlusOctave: [Int] {
    degreeNumbersSorted + [degreeNumbers[0] + 12]
  }
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
  var raisedRoot: Int { get set }
  var stackedPitches: [Int] { get }
}
