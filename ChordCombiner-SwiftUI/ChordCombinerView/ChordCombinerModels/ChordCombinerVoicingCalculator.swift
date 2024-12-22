//
//  ChordCombinerVoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import Foundation

struct ChordCombinerVoicingCalculator: SettableNotesByNoteNumber {
  var lowerChordVoicingCalculator: VoicingCalculator
  var upperChordVoicingCalculator: VoicingCalculator
  var resultChordVoicingCalculator: VoicingCalculator? {
    didSet { setResultChordVoicingCalculatorProperties() }
  }

  var notesByNoteNumber: NotesByNoteNumber = [:]

  private(set) var resultChordStackedPitches: [Int] = []

  var lowerTonesToHighlight: [Int] = []
  var upperTonesToHighlight: [Int] = []
  var commonTonesToHighlight: [Int] = []

  private(set) var resultChordDegreesInOctaveSorted: [Int] = []

  var resultChordNotes: [Note] {
    var notes: [Note] = []

    for degreeNumber in resultChordDegreesInOctaveSorted {
      if let note = resultChordVoicingCalculator?.notesByNoteNumber[NoteNumber(degreeNumber)] {
        notes.append(note)
      }
    }

    return notes
  }

  var resultChordDegreeNames: [String] {
    var degreeNames: [String] = []

    for degreeNumber in resultChordDegreesInOctaveSorted {
      if let degreeName = resultChordVoicingCalculator?.notesByNoteNumber[NoteNumber(degreeNumber)] {
        degreeNames.append(degreeName.degreeName.numeric)
      }
    }

    return degreeNames
  }

  var upperDegreeNamesInLowerKey: [String] {
    var upperNotesInLowerKey: [Note] = []

    for degreeNumber in upperChordVoicingCalculator.degreeNumbers {
      if let upperNote = upperChordVoicingCalculator.notesByNoteNumber[NoteNumber(degreeNumber)] {
        for lowerNote in lowerChordVoicingCalculator.allChordNotesInKeyFiltered()
        where lowerNote.noteName == upperNote.noteName {
          upperNotesInLowerKey.append(lowerNote)
        }
      }
    }

    return upperNotesInLowerKey.map { $0.degreeName.numeric }
  }

  init(
    lowerChordVoicingCalculator: VoicingCalculator,
    upperChordVoicingCalculator: VoicingCalculator,
    resultChordVoicingCalculator: VoicingCalculator? = nil) {
    self.lowerChordVoicingCalculator = lowerChordVoicingCalculator
    self.upperChordVoicingCalculator = upperChordVoicingCalculator
    self.resultChordVoicingCalculator = resultChordVoicingCalculator

    setNotesByNoteNumber(
      lowerChordVoicingCalculator.notesByNoteNumber
        .merging(upperChordVoicingCalculator.notesByNoteNumber) { (_, second) in
          second
        }
    )

    setResultChordVoicingCalculatorProperties()
    setResultChordCombinedHighlightedPitches()

  }

  // MARK: Initializer helper methods
  mutating func setResultChordVoicingCalculatorProperties() {
    resultChordStackedPitches = resultChordVoicingCalculator?.stackedPitches ?? []
    resultChordDegreesInOctaveSorted = resultChordVoicingCalculator?.stackedPitches
      .sorted()
      .map({ $0.degreeNumberInOctave }) ?? []
  }

  mutating func setNotesByNoteNumber() {
    notesByNoteNumber.reserveCapacity(12)

    notesByNoteNumber = lowerChordVoicingCalculator.notesByNoteNumber
      .merging(upperChordVoicingCalculator.notesByNoteNumber) { (_, second) in
      second
    }
  }

  // MARK: Instance methods
  mutating func setResultChordCombinedHighlightedPitches() {
    let onlyInLower: [Int] = lowerChordVoicingCalculator.degreeNumbers
        .subtracting(upperChordVoicingCalculator.degreeNumbers)

    let onlyInUpper: [Int] = upperChordVoicingCalculator.degreeNumbers
        .subtracting(lowerChordVoicingCalculator.degreeNumbers)

    let commonTones: [Int] = lowerChordVoicingCalculator.degreeNumbers
        .intersection(upperChordVoicingCalculator.degreeNumbers)

    lowerTonesToHighlight = resultChordStackedPitches.includeIfSameNote(onlyInLower)
    upperTonesToHighlight = resultChordStackedPitches.includeIfSameNote(onlyInUpper)
    commonTonesToHighlight = resultChordStackedPitches.includeIfSameNote(commonTones)
  }

  func stackedSplit(lowerPitches: [Int], upperPitches: [Int]) -> (lowerPitches: [Int], upperPitches: [Int]) {
    //    print("Highlighting split\n--------")
    // set initial 2nd chord stacked degreeNumbers
    var secondChordPitches = upperPitches

    // set 1st Chord highest pitch, 2nd chord lowest pitch
    let chordMax = lowerPitches.max() ?? 0
    let secondChordMin = upperPitches.min() ?? 0

    // initialize var pitchDifference to root of 2nd Chord
    var pitchDifference = secondChordMin

    // if 2nd Chord root is lower than highest note in 1st chord, raise it up by an octave
    while pitchDifference <= chordMax {
      pitchDifference += 12
    }

    // subtract root pitch of 2nd chord to get pitchDifference in # of octaves * 12
    pitchDifference -= secondChordMin

    // if 2nd Chord root + pitchDifference is the same pitch as highest note in first chord, raise it up 1 more octave
//    pitchDifference = secondChordMin + pitchDifference == chordMax ? pitchDifference + 12 : pitchDifference

    // raise every note in 2nd chord by pitchDifference
    secondChordPitches = secondChordPitches.map {
      $0 + pitchDifference
    }

    return (lowerPitches, secondChordPitches)
  }

  func printDegreeNumberArrays() {
    if let resultChordVoicingCalculator = resultChordVoicingCalculator {
      resultChordVoicingCalculator.printDegreeNumberArrays()
      print("lowerTonesToHighlight: \(lowerTonesToHighlight)")
      print("upperTonesToHighlight: \(upperTonesToHighlight)")
      print("commonTonesToHighlight: \(commonTonesToHighlight)")
    }
  }
}
