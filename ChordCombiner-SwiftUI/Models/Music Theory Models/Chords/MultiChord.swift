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
  
  func stackedChord(degrees: [Int]) -> [Int] {
    print("raising pitches!")
    var pitches: [Int] = degrees
    print("pitches:", pitches)
    pitches = pitches.map {
      $0.raiseAbove(pitch: lowerRaisedRoot, degs: nil)
    }
    print("pitches:", pitches)
    return pitches
  }
  
  mutating func setAndHighlightChords(initial: Bool, keyboard: inout Keyboard, oldMultiChord: inout MultiChord, color: Color, secondColor: Color) {
    self.resultChord = ChordFactory.combineChords(self.lowerChord, self.upperChord).resultChord
    
    if initial {
      self.resultChord = ChordFactory.combineChords(self.lowerChord, self.upperChord).resultChord
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: &self,
        keyboard: &keyboard,
        color: color,
        secondColor: secondColor
      )
    } else {
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: &oldMultiChord,
        keyboard: &keyboard,
        color: color,
        secondColor: secondColor
      )
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: &self,
        keyboard: &keyboard,
        color: color,
        secondColor: secondColor
      )
    }
    
    oldMultiChord = self
  }
}
