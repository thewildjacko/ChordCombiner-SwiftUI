//
//  ChordCombinerSelectedChordTitleModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/19/24.
//

import SwiftUI

struct ChordCombinerSelectedChordTitleModel {
  static let initial = ChordCombinerSelectedChordTitleModel(
    chordCombinerViewModel: ChordCombinerViewModel(),
    chordProperties: ChordProperties())

  let chordCombinerViewModel: ChordCombinerViewModel
  let chordProperties: ChordProperties

  var isLowerChordMenu: Bool {
    chordProperties == chordCombinerViewModel.lowerChordProperties ? true : false
  }

  var promptText: String {
    isLowerChordMenu ? "Select Lower Chord" : "Select Upper Chord"
  }

  var selectedChord: Chord? {
    isLowerChordMenu ? chordCombinerViewModel.lowerChord : chordCombinerViewModel.upperChord
  }

  var chordToMatch: Chord? {
    isLowerChordMenu ? chordCombinerViewModel.upperChord : chordCombinerViewModel.lowerChord
  }

  var selectedChordColor: Color {
    isLowerChordMenu ? .lowerChordHighlight : .upperChordHighlight
  }

  var chordToMatchColor: Color {
    isLowerChordMenu ? .upperChordHighlight : .lowerChordHighlight
  }

  var singleChordKeyboardTitleSelector: SingleChordKeyboardTitleSelector {
    SingleChordKeyboardTitleSelector(chord: selectedChord)
  }

  var showingMatchesText: String {
    guard let lowerChord = chordCombinerViewModel.lowerChord,
          let upperChord = chordCombinerViewModel.upperChord else {
      return "Select upper and lower chords to show matches"
    }

    return selectedChord == chordCombinerViewModel.lowerChord ?
    "(showing matches for upper chord \(upperChord.preciseName))" :
    "(showing matches for lower chord \(lowerChord.preciseName))"
  }

  var chordSymbolTitleFont: Font {
    isLowerChordMenu ?
    chordCombinerViewModel.lowerChord != nil ?
      .largeTitle : .headline :
    chordCombinerViewModel.upperChord != nil ?
      .largeTitle : .headline
  }
}
