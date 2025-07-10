//
//  ArrayExtensions+Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import Foundation
import Algorithms

extension Array where Element == Chord {
  init(sortedByNotes notes: [Note], fromChords chords: [Chord]) {
    var result: [Chord] = []

    for (note, chord) in product(notes, chords) where chord.rootMatchesNoteNumber(note) {
      result.append(chord)
    }

    self = result
  }

  func preciseNames() -> [String] {
    self.map { $0.details.preciseName }
  }

  func getCommonNames() -> [String] {
    self.map { $0.details.commonName }
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
      where chord.containingChords().isEmpty {
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
