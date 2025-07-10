//
//  ArrayExtensions+Int.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import SwiftUI
import Algorithms

extension Array where Element == Int {
  // MARK: Set operations
  /// Returns a set of the combined elements of two Integer arrays
  func combineSetFilter(_ otherArray: [Int]) -> Set<Int> {
    return self.toSet().union(otherArray)
  }

  /// Combines two Integer arrays into another array with no duplicate values, sorted in ascending order
  func combineSetFilterSort(_ otherArray: [Int]) -> [Int] {
    return self.combineSetFilter(otherArray).sorted()
//    return self.toSet().union(otherArray).sorted()
  }

  /// Returns an array of the elements in an array not contained in the supplied `otherArray` parameter
  func subtracting(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().subtracting(otherArray))
  }

  /// Returns an array of the elements in an array also contained in the supplied `otherArray` parameter
  func intersection(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().intersection(otherArray))
  }

  /// Returns a Boolean value indicating whether the array is a superset of the supplied `otherArray` parameter
  func includes(_ otherArray: [Int]) -> Bool {
    self.toSet().isSuperset(of: otherArray)
  }

  /// Combines two arrays, filtering out elements in the second array already contained in the original
  func combineAndFilter(_ otherArray: [Int]) -> [Int] {
    return self + otherArray.filter { !self.contains($0) }
  }

  func noteNumbers() -> [NoteNumber] { self.map { NoteNumber($0) } }

  /// Compares elements in two Int arrays (raisedPitch & baseDegrees) to see if they match in key
  ///
  /// - Parameter baseDegrees, an [Int] array with values from **0-11**
  ///
  /// - Returns an array of raised pitches that match in key to elements in the `baseDegrees` array
  ///
  /// - Elements match if `raisedPitch % 12 == pitch % 12`
  /// - Remark: Helps calculate multi-chord stacked voicings and determine common tones
  /// - raised pitch values range from **21-108** (the piano MIDI pitch range)
  func includeIfSameNote(_ baseDegrees: [Int]) -> [Int] {
    var result: [Int] = []

    for (raisedPitch, pitch) in product(self, baseDegrees)
    where raisedPitch.isSameNote(as: pitch) {
      result.append(raisedPitch)
    }

    return result
  }

  func containsAdjacentPitch(to pitch: Int) -> Bool {
    let pitchBelow = pitch - 1
    let pitchAbove = pitch + 1
    return !self.toSet().isDisjoint(with: [pitchBelow, pitchAbove])
  }

  /// raises every ``Int`` in a pitch array by an octave except the indicated pitch
  mutating func raiseAllExceptPitch(_ pitch: Int) {
    self = self.map { pitchToRaise in
      pitchToRaise == pitch ? pitchToRaise : pitchToRaise + 12
    }
  }

  /// raises every ``Int`` in a pitch array that is lower than the indicated pitch by an octave
  mutating func raiseAllBelowPitch(_ pitch: Int) {
    self = self.map { pitchToRaise in
      pitchToRaise >= pitch ? pitchToRaise : pitchToRaise + 12
    }
  }

  mutating func raiseAllBy(_ halfSteps: Int) {
    self = self.map { $0 + halfSteps }
  }

  mutating func lowerAllBy(_ halfSteps: Int) {
    self = self.map { $0 - halfSteps }
  }

  mutating func pivotAround(pivotPitch: Int, raiseUp: Bool) {
    self = self.map { pitch in
      var alteredPitch = pitch

      if raiseUp {
        alteredPitch.raiseAbove(pitch: pivotPitch)
      } else {
        alteredPitch.lowerBelow(pitch: pivotPitch)
      }

      return alteredPitch
    }
  }

  mutating func pivot(around pivotPitch: Int, with dividingPitch: Int, raiseUp: Bool) {
    self = self.map { pitch in
      var alteredPitch = pitch

      if raiseUp {
        alteredPitch.raiseAbove(pitch: pivotPitch)

        return pitch < dividingPitch ? alteredPitch : pitch
      } else {
        alteredPitch.lowerBelow(pitch: pivotPitch)

        return pitch > dividingPitch ? alteredPitch : pitch
      }
    }
  }

  func raiseAbove(startingPitch: Int, lowerTones: inout [Int], upperTones: inout [Int], commonTones: inout [Int]) {
    if let minPitch = self.min() {
      var tempMinPitch = minPitch

      while tempMinPitch < startingPitch {
        lowerTones.raiseAllBy(12)
        upperTones.raiseAllBy(12)
        commonTones.raiseAllBy(12)
        tempMinPitch += 12
      }
    }
  }

  /// Tranposes the degreeNumber array to a given ``RootKeyNote``, sorting in ascending order
  func transposed(to rootKeyNote: RootKeyNote) -> [Int] {
    return self.map { $0.minusDegreeNumber(rootKeyNote.keyName.noteNumber.rawValue)}
      .sorted()
  }

  /// Combines two degreeNumber arrays, tranposes combined array to a given ``RootKeyNote``, sorting in ascending order
  func combinedAndTransposed(with otherDegreeNumbers: [Int], to rootKeyNote: RootKeyNote) -> [Int] {
    let combinedDegreeArray = Array(self.combineSetFilter(otherDegreeNumbers))

    return combinedDegreeArray.transposed(to: rootKeyNote)
  }

  func highlightIfSelected(keys: inout [Key], highlightedPitches: inout Set<Int>, color: Color) {
    for pitch in self {
      highlightedPitches.insert(pitch)

      if let index = pitch.indexFromKeys(keys: &keys) {
        keys[index].highlight(color: color)
      }
    }
  }

  func lettersOnIfSelected(keys: inout [Key]) {
    for pitch in self {
      if let index = pitch.indexFromKeys(keys: &keys) {
        if keys[index].lettersOn == false {
          keys[index].lettersOn = true
        }
      }
    }
  }

  func circlesOnIfSelected(keys: inout [Key], circleType: KeyCircleType) {
    for pitch in self {
      if let index = pitch.indexFromKeys(keys: &keys) {
        if keys[index].circlesOn == false {
          keys[index].circlesOn = true
          keys[index].circleType = circleType
        }
      }
    }
  }

  func adjacentPitchIntervalCount(degree: Degree) -> Int {
    var count = 0

    let windows = self.windows(ofCount: 2).map { Array($0) }
    for window in windows where window[1] - window[0] == degree.size {
      count += 1
    }

    return count
  }

  func intervalInOctaveCount(degree: Degree) -> Int {
    let combos = self.combinations(ofCount: 2).filter { combo in
      combo[0].isIntervalUpOrDown(of: degree, from: combo[1])
    }

    return combos.count
  }

  func potentialPitchIntervalStats(degree: Degree) -> PitchIntervalStats {
    let count = intervalInOctaveCount(degree: degree)
    let score = degree.tensionScore * Double(count)

    return PitchIntervalStats(count: count, score: score, degree: degree)
  }

  func pitchIntervalStats(degree: Degree) -> PitchIntervalStats {
    var count = 0
    var score = 0.0

    if degree == .minor2nd {
      count = adjacentPitchIntervalCount(degree: degree)
      return PitchIntervalStats(
        count: count,
        score: degree.tensionScore * Double(count),
        degree: degree)
    } else if degree.size.degreeNumberInOctave == 6 {
      count = intervalInOctaveCount(degree: degree)
      return PitchIntervalStats(
        count: count,
        score: degree.tensionScore * Double(count),
        degree: degree)
    } else {
      for combo in self.combinations(ofCount: 2) {
        let firstMinusSecond = combo[1] - combo[0]

        if firstMinusSecond == degree.size ||
            (firstMinusSecond > 24 &&
             firstMinusSecond == degree.size.degreeNumberInOctave) {
          count += 1

          let minor9thNotAgainstRoot = degree == .minor9th && combo[0] != self[0]

          score += minor9thNotAgainstRoot ? 4 : degree.tensionScore
        }
      }

      return PitchIntervalStats(count: count, score: score, degree: degree)
    }
  }
}
