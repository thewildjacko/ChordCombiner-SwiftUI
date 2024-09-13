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
  
  @Published var resultChord: Chord? = nil { 
    didSet { multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches() }
  }
  
  var multiChordVoicingCalculator: MultiChordVoicingCalculator {
    get {
      MultiChordVoicingCalculator(
        lowerChordVoicingCalculator: lowerChord.voicingCalculator,
        upperChordVoicingCalculator: upperChord.voicingCalculator,
        resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
    }
    set { }
  }
  
  init(lowerChord: Chord, upperChord: Chord) {
    self.lowerChord = lowerChord
    self.upperChord = upperChord
    setResultChord()
  }

  func setResultChord() {
    resultChord = ChordFactory.combineChordDegrees(
      lowerDegrees: multiChordVoicingCalculator.lowerDegrees,
      upperDegrees: multiChordVoicingCalculator.upperDegrees,
      lowerRoot: multiChordVoicingCalculator.lowerRoot,
      upperRoot: multiChordVoicingCalculator.upperRoot)
    multiChordVoicingCalculator.resultChordVoicingCalculator = resultChord?.voicingCalculator ?? nil
  }
}
