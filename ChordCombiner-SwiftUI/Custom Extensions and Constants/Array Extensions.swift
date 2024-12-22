//
//  Array Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import SwiftUI
import Algorithms

extension Chord {
  /// Returns a set of the combined elements of two Chord degreeNumber arrays
  func combineSetFilter(_ otherChord: Chord) -> Set<Int> {
    return degreeNumbers.toSet().union(otherChord.degreeNumbers)
  }
}

extension Array {
  func calculateBatch() -> Int {
    return self.count <= 5 ? self.count : 5
  }

  func calculateStartPoint(batch: Int, iteration: Int, elementsInBatch: Int) -> Int {
    guard !self.isEmpty && self.count != 0 else {
      return 0
    }

    let count = self.count
    let endPoint = count - 1

    var startPoint = iteration * elementsInBatch
    startPoint = startPoint <= endPoint ? startPoint : endPoint

    return startPoint
  }

  func calculateEndPoint(startPoint: Int, elementsInBatch: Int) -> Int {
    guard !self.isEmpty && self.count != 0 else {
      return 0
    }

    let count = self.count
    let arrayEnd = count - 1

    var endPoint = startPoint + elementsInBatch
    endPoint = endPoint <= arrayEnd ? endPoint : arrayEnd

    return endPoint
  }

  func elementsInBatch(batch: Double) -> Int {
    let elementsDouble = Double(Double(self.count) / batch).rounded(.up)
    return Int(elementsDouble)
  }
}

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
        //        print(minPitch, startingPitch)
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
}

extension Array where Element: Hashable {
  /// returns a set from a given array
  func toSet() -> Set<Element> { Set(self) }
}

extension Array where Element == Key {
  mutating func highlightIfSelected(pitches: [Int], color: Color) {
    for key in self {
      if let index = pitches.firstIndex(where: { $0 == key.pitch }) {
        self[index].highlight(color: color)
      }
    }
  }
}

extension Array where Element == Note {
  func isEnharmonicEquivalent(to otherNoteArray: [Note]) -> Bool {
    if self.count != otherNoteArray.count {
      return false
    } else {
      let firstArray = self.sorted(by: { $0.noteNumber.rawValue < $1.noteNumber.rawValue })
      let secondArray = otherNoteArray.sorted(by: { $0.noteNumber.rawValue < $1.noteNumber.rawValue })

      var isEnharmonicEquivalent = true

      for index in (0...firstArray.count - 1)
      where !firstArray[index].isEnharmonicEquivalent(to: secondArray[index]) {
        isEnharmonicEquivalent = false
      }

      return isEnharmonicEquivalent
    }
  }

  /// Takes a ``[Note]`` array and ``[Chord]`` array, returns an array of ``[Chord]`` arrays containing each ``Note``
  func chordsContainNote(chords: [Chord]) -> [[Chord]] {
    return self.map { note in
      chords.filterInChordsContainingNote(note)
    }
  }

  func toPitchesByNote(pitches: [Int]) -> PitchesByNote {
    return Dictionary(uniqueKeysWithValues: zip(self, pitches))
  }

  func noteNames() -> [String] { self.map { $0.noteName } }
  func degreeNumbers() -> [Int] { self.map { $0.noteNumber.rawValue } }
}

extension Array where Element == ChordType {
  func filterOmits() -> [Element] {
    self.filter { !$0.rawValue.contains("omit")}
  }

  func filterInTriads() -> [Element] { self.filter { $0.isTriad }}

  func filterInSimple() -> [Element] { self.filter { $0.isSimpleChord }}

  func filterInFourNoteSimple() -> [Element] { self.filter { $0.isFourNoteSimpleChord }}

  func filterInExtended() -> [Element] { self.filter { $0.isExtendedChord }}
}

extension Array where Element == Degree {
  func intersectsWith(_ otherArray: [Element]) -> Bool {
    !self.toSet().isDisjoint(with: otherArray)
  }
}

extension Array where Element == Chord {
  init(sortedByNotes notes: [Note], fromChords chords: [Chord]) {
    var result: [Chord] = []

    for (note, chord) in product(notes, chords) where chord.rootMatchesNoteNumber(note) {
      result.append(chord)
    }

    self = result
  }

  func preciseNames() -> [String] {
    self.map { $0.preciseName }
  }

  func getCommonNames() -> [String] {
    self.map { $0.commonName }
  }

  func filterInFourNoteChords() -> [Chord] {
    self.filter { $0.isFourNoteSimpleChord() }
  }

  func filterInTriads() -> [Chord] {
    self.filter { $0.isTriad() }
  }

  func filterInExtendedChords() -> [Chord] {
    self.filter { $0.isExtended() }
  }

  func filterInChordsContainingNoChords() -> [Chord] {
    guard !self.isEmpty else {
      return []
    }

    let batch = self.calculateBatch()
    let chordsInBatch = self.elementsInBatch(batch: Double(batch))
    var tempChords: [Chord] = []

    var lock = os_unfair_lock()

    DispatchQueue.concurrentPerform(iterations: batch) { iteration in
      let startPoint = self.calculateStartPoint(
        batch: batch,
        iteration: iteration,
        elementsInBatch: chordsInBatch)
      let endPoint = self.calculateEndPoint(
        startPoint: startPoint,
        elementsInBatch: chordsInBatch)
      let subChordArray = Array(self[startPoint..<endPoint])

      var chordMatches: [Chord] = []

      for chord in subChordArray
      where chord.containingChordsConcurrent().isEmpty {
        chordMatches.append(chord)
      }

      os_unfair_lock_lock(&lock)
      tempChords += chordMatches
      os_unfair_lock_unlock(&lock)
    }

    return tempChords
  }

  func filterInChordsContainingNote(_ note: Note) -> [Chord] {
    self.filter { $0.contains(note) }
  }

  func contains(_ note: Note) -> Bool {
    !self.filter { $0.contains(note) }.isEmpty
  }

  func contains(_ chord: Chord) -> Bool {
    !self.filter { $0.contains(chord) }.isEmpty
  }

  func toDotNotationString(bracketed: Bool) -> String {
    let joinedDotNotationString = self.map { $0.getDotNotationName() }
      .joined(separator: " ")

    return bracketed ? joinedDotNotationString.bracketedAndPadded() : joinedDotNotationString
  }
}
