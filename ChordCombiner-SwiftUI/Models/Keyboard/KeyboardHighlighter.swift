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
    
    selectedKeyboard.highlightKeysAfterClearing(pitches: selectedChord.voicingCalculator.stackedPitches, color: selectedChordColor)
    selectedKeyboard.setNotesStacked(pitchesByNote: selectedChord.voicingCalculator.stackedPitchesByNote, color: selectedChordColor)
  }
  
  func highlightCombinedChord(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, combinedKeyboard: inout Keyboard) {
    guard let _ = selectedChord,
          let _ = chordToMatch,
          let _ = multiChord.resultChord,
          let multiChordVoicingCalculator = multiChord.multiChordVoicingCalculator else {
      return
    }
    
    print("combining!")
    
    combinedKeyboard.highlightKeysAfterClearing(pitches: multiChordVoicingCalculator.lowerTonesToHighlight, color: .lowerChordHighlight)
    combinedKeyboard.highlightKeysWithoutClearing(pitches: multiChordVoicingCalculator.upperTonesToHighlight, color: .upperChordHighlight)
    combinedKeyboard.highlightKeysWithoutClearing(pitches: multiChordVoicingCalculator.commonTonesToHighlight, color: LinearGradient.commonToneGradient)
  }
  
  func highlightSplitChord(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, combinedKeyboard: inout Keyboard) {
    guard let _ = selectedChord,
          let _ = chordToMatch,
          let multiChordVoicingCalculator = multiChord.multiChordVoicingCalculator else {
      return
    }
    
    print("splitting!")
    
    let (lowerSplitPitches, upperSplitPitches) = multiChordVoicingCalculator.stackedSplit(lowerPitches: multiChordVoicingCalculator.lowerStackedPitches, upperPitches: multiChordVoicingCalculator.upperStackedPitches)
        
    combinedKeyboard.highlightKeysAfterClearing(pitches: lowerSplitPitches, color: .lowerChordHighlight)
    combinedKeyboard.highlightKeysWithoutClearing(pitches: upperSplitPitches, color: .upperChordHighlight)
  }
  
  func highlightKeyboards(selectedChord: Chord?, chordToMatch: Chord?, multiChord: MultiChord, selectedKeyboard: inout Keyboard, selectedChordColor: Color, combinedKeyboard: inout Keyboard) {
    highlightSelectedChord(selectedChord: selectedChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor)
    
    if let _ = multiChord.resultChord {
      highlightCombinedChord(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, combinedKeyboard: &combinedKeyboard)
    } else {
      highlightSplitChord(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, combinedKeyboard: &combinedKeyboard)
    }
  }
}
