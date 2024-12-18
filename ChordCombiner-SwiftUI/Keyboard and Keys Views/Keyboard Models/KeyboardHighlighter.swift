//
//  KeyboardHighlighter.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/13/24.
//

import SwiftUI

struct KeyboardHighlighter {
  func highlightSelectedChord(
    selectedChord: Chord?,
    selectedKeyboard: inout Keyboard,
    selectedChordColor: Color) {
    guard let selectedChord = selectedChord else { return }
    // Clear previously highlighted chord
    selectedKeyboard.clearHighlightedKeys()

    // Highlight new chord and turn letters on
    selectedKeyboard.highlightKeys_LettersOn(
      pitches: selectedChord.voicingCalculator.stackedPitches,
      color: selectedChordColor)

    // Set notes to display for each highlighted key
    selectedKeyboard.setNotesStacked(pitchesByNote: selectedChord.voicingCalculator.stackedPitchesByNote)
  }

  func highlightCombinedTones(
    lowerTones: [Int],
    upperTones: [Int],
    commonTones: [Int],
    keyboard: inout Keyboard) {
      keyboard.highlightKeys_LettersAndCirclesOn(
        pitches: lowerTones,
        color: .lowerChordHighlight,
        circleType: .lower)
      keyboard.highlightKeys_LettersAndCirclesOn(
        pitches: upperTones,
        color: .upperChordHighlight,
        circleType: .upper)
      keyboard.highlightKeys_LettersAndCirclesOn(
        pitches: commonTones,
        color: .lowerChordHighlight,
        circleType: .common)
  }

  func highlightCombinedChord(
    selectedChord: Chord?,
    chordToMatch: Chord?,
    chordCombinerViewModel: ChordCombinerViewModel,
    combinedKeyboard: inout Keyboard) {
    guard selectedChord != nil,
          chordToMatch != nil,
          chordCombinerViewModel.resultChord != nil,
          let chordCombinerVoicingCalculator = chordCombinerViewModel.chordCombinerVoicingCalculator else {
      return
    }

//    print("combining!")

    // Clear previously highlighted chord
    combinedKeyboard.clearHighlightedKeys()

    let pitchesToHighlight = chordCombinerViewModel.getPitchesToHighlight(
      startingPitch: combinedKeyboard.startingPitch,
      lowerTones: chordCombinerVoicingCalculator.lowerTonesToHighlight,
      upperTones: chordCombinerVoicingCalculator.upperTonesToHighlight,
      commonTones: chordCombinerVoicingCalculator.commonTonesToHighlight)

//    print(resultChord.preciseName, resultChord.isSlashChord,
//          resultChord.slashChordBassNote?.keyName.rawValue ?? "nil",
//          resultChord.slashChordBassNote?.keyName.noteNumber.rawValue ?? -1)

//    chordCombinerVoicingCalculator.printDegreeNumberArrays()

    // Highlight new chord and turn letters & symbols on
    highlightCombinedTones(
      lowerTones: pitchesToHighlight.lower,
      upperTones: pitchesToHighlight.upper,
      commonTones: pitchesToHighlight.common,
      keyboard: &combinedKeyboard)

    // Set notes to display for each highlighted key
    let pitchesByNote = chordCombinerViewModel.getPitchesByNote(
      combinedTones: pitchesToHighlight.combinedSorted)
    combinedKeyboard.setNotesStacked(pitchesByNote: pitchesByNote)
  }

  func highlightSplitChord(
    selectedChord: Chord?,
    chordToMatch: Chord?,
    chordCombinerViewModel: ChordCombinerViewModel,
    combinedKeyboard: inout Keyboard) {
    guard selectedChord != nil,
          chordToMatch != nil,
          let chordCombinerVoicingCalculator = chordCombinerViewModel.chordCombinerVoicingCalculator else {
      return
    }

    let (lowerChordVoicingCalculator, upperChordVoicingCalculator) = (
      chordCombinerVoicingCalculator.lowerChordVoicingCalculator,
      chordCombinerVoicingCalculator.upperChordVoicingCalculator
      )

//    print("splitting!")

    let (lowerSplitPitches, upperSplitPitches) = chordCombinerVoicingCalculator.stackedSplit(
      lowerPitches: lowerChordVoicingCalculator.stackedPitches,
      upperPitches: upperChordVoicingCalculator.stackedPitches
    )

    let combinedPitches = lowerSplitPitches + upperSplitPitches
    let combinedNotes = lowerChordVoicingCalculator.notes + upperChordVoicingCalculator.notes

    // Clear previously highlighted chord
    combinedKeyboard.clearHighlightedKeys()

    // Highlight new chord and turn letters & symbols on
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(
      pitches: lowerSplitPitches,
      color: .lowerChordHighlight,
      circleType: .lower
    )
    combinedKeyboard.highlightKeys_LettersAndCirclesOn(
      pitches: upperSplitPitches,
      color: .upperChordHighlight,
      circleType: .upper
    )

    combinedKeyboard.setNotesSplit(notes: combinedNotes, pitches: combinedPitches)
  }

  func highlightKeyboards(
    selectedChord: Chord?,
    chordToMatch: Chord?,
    chordCombinerViewModel: ChordCombinerViewModel,
    selectedChordColor: Color,
    combinedKeyboard: inout Keyboard) {

    // resultChord is a combined or slash chord
    if chordCombinerViewModel.resultChord != nil {
      highlightCombinedChord(
        selectedChord: selectedChord,
        chordToMatch: chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        combinedKeyboard: &combinedKeyboard
      )
    } else { // combineChords returns a polychord or one or both lower/upper chords aren't selected yet
      switch (chordCombinerViewModel.lowerChord, chordCombinerViewModel.upperChord) {
      case (let lowerChord, nil): // lowerChord is selected
        highlightSelectedChord(
          selectedChord: lowerChord,
          selectedKeyboard: &combinedKeyboard,
          selectedChordColor: .lowerChordHighlight)
      case (nil, let upperChord): // upperChord is selected
        highlightSelectedChord(
          selectedChord: upperChord,
          selectedKeyboard: &combinedKeyboard,
          selectedChordColor: .upperChordHighlight
        )
      default: // combineChords returns a polychord
        highlightSplitChord(
          selectedChord: selectedChord,
          chordToMatch: chordToMatch, chordCombinerViewModel: chordCombinerViewModel,
          combinedKeyboard: &combinedKeyboard
        )
      }

//      print(combinedKeyboard.keys.filter {$0.highlighted}.map { $0.pitch })
//      print(combinedKeyboard.keys.compactMap { $0.note }.map {$0.noteName})
    }
  }
}
