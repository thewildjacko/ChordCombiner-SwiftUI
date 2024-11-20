//
//  CustomChordMenuSelectedChordTitleModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/19/24.
//

import SwiftUI

struct CustomChordMenuSelectedChordTitleModel {
  let multiChord: MultiChord
  let chordProperties: ChordProperties
  
  var isLowerChordMenu: Bool {
    chordProperties == multiChord.lowerChordProperties ? true : false
  }
  
  var promptText: String {
    isLowerChordMenu ? "Select Lower Chord" : "Select Upper Chord"
  }
  
  var selectedChord: Chord? {
    isLowerChordMenu ? multiChord.lowerChord : multiChord.upperChord
  }
  
  var chordToMatch: Chord? {
    isLowerChordMenu ? multiChord.upperChord : multiChord.lowerChord
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
    guard let lowerChord = multiChord.lowerChord,
          let upperChord = multiChord.upperChord else {
      return "Select upper and lower chords to show matches"
    }

    return selectedChord == multiChord.lowerChord ? "(showing matches for upper chord \(upperChord.preciseName))" : "(showing matches for lower chord \(lowerChord.preciseName))"
  }
  
  var chordSymbolTitleFont: Font {
    isLowerChordMenu ?
    multiChord.lowerChord != nil ?
      .largeTitle : .headline :
    multiChord.upperChord != nil ?
      .largeTitle : .headline
  }
}
