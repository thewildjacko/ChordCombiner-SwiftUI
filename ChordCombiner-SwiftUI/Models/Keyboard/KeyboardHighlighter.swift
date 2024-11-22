//
//  KeyboardHighlighter.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/13/24.
//

import SwiftUI

struct KeyboardHighlighter {
  func highlightSelectedChord(selectedChord: Chord?, selectedKeyboard: inout Keyboard, selectedChordColor: Color) {
    guard let selectedChord = selectedChord else { return }
    // Clear previously highlighted chord
    selectedKeyboard.clearHighlightedKeys()
    
    // Highlight new chord and turn letters on
    selectedKeyboard.highlightKeys_LettersOn(pitches: selectedChord.voicingCalculator.stackedPitches, color: selectedChordColor)
    
    // Set notes to display for each highlighted key
    selectedKeyboard.setNotesStacked(pitchesByNote: selectedChord.voicingCalculator.stackedPitchesByNote)
  }
  
  func highlightCombinedChord(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, combinedKeyboard: inout Keyboard) {
    guard let _ = selectedChord,
          let _ = chordToMatch,
          let resultChord = multiChord.resultChord,
          let multiChordVoicingCalculator = multiChord.multiChordVoicingCalculator else {
      return
    }
    
    print("combining!")
    // Clear previously highlighted chord
    combinedKeyboard.clearHighlightedKeys()
    
    // Highlight new chord and turn letters & symbols on
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(pitches: multiChordVoicingCalculator.lowerTonesToHighlight, color: .lowerChordHighlight, circleType: .lower)
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(pitches: multiChordVoicingCalculator.upperTonesToHighlight, color: .upperChordHighlight, circleType: .upper)
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(pitches: multiChordVoicingCalculator.commonTonesToHighlight, color: .lowerChordHighlight, circleType: .common)
    
    // Set notes to display for each highlighted key
    combinedKeyboard.setNotesStacked(pitchesByNote: resultChord.voicingCalculator.stackedPitchesByNote)
  }
  
  func highlightSplitChord(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, combinedKeyboard: inout Keyboard) {
    guard let _ = selectedChord,
          let _ = chordToMatch,
          let multiChordVoicingCalculator = multiChord.multiChordVoicingCalculator else {
      return
    }
    
    print("splitting!")
    
    let (lowerSplitPitches, upperSplitPitches) = multiChordVoicingCalculator.stackedSplit(lowerPitches: multiChordVoicingCalculator.lowerStackedPitches, upperPitches: multiChordVoicingCalculator.upperStackedPitches)
    // Clear previously highlighted chord
    combinedKeyboard.clearHighlightedKeys()
    
    // Highlight new chord and turn letters & symbols on
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(pitches: lowerSplitPitches, color: .lowerChordHighlight, circleType: .lower)
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(pitches: upperSplitPitches, color: .upperChordHighlight, circleType: .upper)
    
    // FIXME: Set notes to display for each highlighted key -> missing setNotesStacked call here
  }
  
  func highlightKeyboards(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, selectedKeyboard: inout Keyboard, selectedChordColor: Color, combinedKeyboard: inout Keyboard) {
    highlightSelectedChord(selectedChord: selectedChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor)
    
    // resultChord is a combined or slash chord
    if let _ = multiChord.resultChord {
      highlightCombinedChord(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, combinedKeyboard: &combinedKeyboard)
    } else { // combineChords returns a polychord or one or both lower/upper chords aren't selected yet
      switch (multiChord.lowerChord, multiChord.upperChord) {
      case (let lowerChord, nil): // lowerChord is selected
        highlightSelectedChord(selectedChord: lowerChord, selectedKeyboard: &combinedKeyboard, selectedChordColor: .lowerChordHighlight)
      case (nil, let upperChord): // upperChord is selected
        highlightSelectedChord(selectedChord: upperChord, selectedKeyboard: &combinedKeyboard, selectedChordColor: .upperChordHighlight)
      default: // combineChords returns a polychord
        highlightSplitChord(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, combinedKeyboard: &combinedKeyboard)
      }
    }
  }
}
