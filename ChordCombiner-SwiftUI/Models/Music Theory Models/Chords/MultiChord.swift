//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import Foundation

class MultiChord: ObservableObject {
  @Published var lowerChord: Chord {
    didSet { setResultChord() }
  }
  
  @Published var upperChord: Chord {
    didSet { setResultChord() }
  }
  
  @Published var resultChord: Chord? = nil

  var multiChordVoicingCalculator: MultiChordVoicingCalculator {
    MultiChordVoicingCalculator(
      lowerChordVoicingCalculator: lowerChord.voicingCalculator,
      upperChordVoicingCalculator: upperChord.voicingCalculator)
  }
  
  init(lowerChord: Chord, upperChord: Chord) {
//    print("initializing MultiChord (lowerChord: \(lowerChord.name), upperChord: \(upperChord.name))")
    self.lowerChord = lowerChord
    self.upperChord = upperChord
    setResultChord()
  }
  
  var lowerRoot: Note {
    multiChordVoicingCalculator.lowerChordVoicingCalculator.rootNote.note
  }

  var upperRoot: Note {
    multiChordVoicingCalculator.upperChordVoicingCalculator.rootNote.note
  }

  var lowerDegrees: [Int] {
    lowerChord.degrees
  }

  var upperDegrees: [Int] {
    upperChord.degrees
  }
  
  var onlyInLower: [Int] {
    lowerDegrees.subtracting(upperDegrees)
  }
  
  var onlyInUpper: [Int] {
    upperDegrees.subtracting(lowerDegrees)
  }
  
  var commonTones: [Int] {
    lowerDegrees.intersection(upperDegrees)
  }
  
  var lowerRaisedPitches: [Int] {
    lowerChord.raisedPitches
  }
  
  var lowerRaisedRoot: Int {
    lowerChord.raisedRoot
  }
  
  var upperRaisedPitches: [Int] {
    upperChord.raisedPitches
  }
  
  var upperRaisedRoot: Int {
    upperChord.raisedRoot
  }
  
  var lowerStackedPitches: [Int] {
    lowerChord.stackedPitches
  }
  
  var upperStackedPitches: [Int] {
    upperChord.stackedPitches
  }
  
  var lowerTonesToHighlight: [Int] = []
  var upperTonesToHighlight: [Int] = []
  var commonTonesToHighlight: [Int] = []

  func setResultChord() {
    resultChord = ChordFactory.combineChordDegrees(
      lowerDegrees: multiChordVoicingCalculator.lowerDegrees,
      upperDegrees: multiChordVoicingCalculator.upperDegrees,
      lowerRoot: multiChordVoicingCalculator.lowerRoot,
      upperRoot: multiChordVoicingCalculator.upperRoot)
  }

  func setHighlightedPitches() {
    if let result = resultChord {
      lowerTonesToHighlight = result.voicingCalculator.stackedPitches.includeIfSameNote(onlyInLower)
      upperTonesToHighlight = result.voicingCalculator.stackedPitches.includeIfSameNote(onlyInUpper)
      commonTonesToHighlight = result.voicingCalculator.stackedPitches.includeIfSameNote(commonTones)
    }
    
    
  }
}
