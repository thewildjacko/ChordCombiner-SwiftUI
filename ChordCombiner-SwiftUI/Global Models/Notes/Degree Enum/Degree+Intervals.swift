//
//  DegreeIntervals.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/24/25.
//

import Foundation

extension Degree {
  func isHalfStep(from otherDegree: Degree) -> Bool {
    (size - 1).degreeNumberInOctave == otherDegree.size.degreeNumberInOctave ||
    (size + 1).degreeNumberInOctave == otherDegree.size.degreeNumberInOctave
  }

  func halfSteps() -> [Degree] {
    return Degree.allCases.filter { $0.isHalfStep(from: self) }
  }

  func isTritone(from otherDegree: Degree) -> Bool {
    (size - 6).degreeNumberInOctave == otherDegree.size.degreeNumberInOctave
  }

  func tritones() -> [Degree] {
    return Degree.allCases.filter { $0.isTritone(from: self) }
  }
}
