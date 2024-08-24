//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI

struct MultiChord {
  var lowerChord: Chord
  var upperChord: Chord
  var resultChord: Chord?
  
  var lowerRoot: Root {
    lowerChord.root
  }

  var upperRoot: Root {
    upperChord.root
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
  
//  mutating func setAndHighlightChords(initial: Bool, lowerKeyboard: inout Keyboard, upperKeyboard: inout Keyboard, combinedKeyboard: inout Keyboard, multiChord: inout MultiChord, color: Color, secondColor: Color) {
//    self.resultChord = ChordFactory.combineChords(self.lowerChord, self.upperChord).resultChord
//    
//    if initial {
//      self.resultChord = ChordFactory.combineChords(self.lowerChord, self.upperChord).resultChord
//      ChordHighlighter.highlightStacked(
//        multiChord: multiChord,
//        keyboard: &lowerKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: true
//      )
//      ChordHighlighter.highlightStacked(
//        multiChord: multiChord,
//        keyboard: &upperKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: false
//      )
//      
//      ChordHighlighter.highlightStackedCombinedOrSplit(
//        multiChord: self,
//        keyboard: &combinedKeyboard,
//        color: color,
//        secondColor: secondColor
//      )
//    } else {
//      ChordHighlighter.highlightStacked(
//        multiChord: multiChord,
//        keyboard: &lowerKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: true
//      )
//      ChordHighlighter.highlightStacked(
//        multiChord: multiChord,
//        keyboard: &upperKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: false
//      )
//      
//      ChordHighlighter.highlightStacked(
//        multiChord: self,
//        keyboard: &lowerKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: true
//      )
//      ChordHighlighter.highlightStacked(
//        multiChord: self,
//        keyboard: &upperKeyboard,
//        color: color,
//        secondColor: secondColor,
//        isLower: false
//      )
//      
//      ChordHighlighter.highlightStackedCombinedOrSplit(
//        multiChord: multiChord,
//        keyboard: &combinedKeyboard,
//        color: color,
//        secondColor: secondColor
//      )
//      ChordHighlighter.highlightStackedCombinedOrSplit(
//        multiChord: self,
//        keyboard: &combinedKeyboard,
//        color: color,
//        secondColor: secondColor
//      )
//    }
//    
//    multiChord = self
//  }
}
