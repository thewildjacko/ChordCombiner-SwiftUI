//
//  ChordHighlighter.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import Foundation
import SwiftUI

struct ChordHighlighter {
  static func highlightStacked(chord: inout Chord, oldChord: inout Chord, keyboard: inout Keyboard, initial: Bool, color: Color) {
    if initial {
      // highlight chord
      keyboard.highlightKeys(degs: chord.stackedPitches, color: color)
    } else {
      // un-highlight old chord
      keyboard.highlightKeys(degs: oldChord.stackedPitches, color: color)
      
      // highlight new chord
      keyboard.highlightKeys(degs: chord.stackedPitches, color: color)
    }
  }
  
  static func highlightStackedSplit(multiChord: inout MultiChord, keyboard: inout Keyboard, color: Color, secondColor: Color) {
//    print("Highlighting split\n--------")
    // set initial 2nd chord stacked degrees
    var secondChordPitches = multiChord.upperChord.stackedPitches
    
    // set 1st Chord highest pitch, 2nd chord lowest pitch
    let chordMax = multiChord.lowerChord.stackedPitches.max() ?? 0
    let secondChordMin = multiChord.upperChord.stackedPitches.min() ?? 0
    
    // initialize var pitchDifference to root of 2nd Chord
    var pitchDifference = secondChordMin
    
    // if 2nd Chord root is lower than highest note in 1st chord, raise it up by an octave
    while pitchDifference < chordMax {
      pitchDifference += 12
    }
    
    // subtract root pitch of 2nd chord to get pitchDifference in # of octaves * 12
    pitchDifference = pitchDifference - secondChordMin
    
    // if 2nd Chord root + pitchDifference is the same pitch as highest note in first chord, raise it up 1 more octave
    pitchDifference = secondChordMin + pitchDifference == chordMax ? pitchDifference + 12 : pitchDifference
        
    // raise every note in 2nd chord by pitchDifference
    secondChordPitches = secondChordPitches.map {
      $0 + pitchDifference
    }
    
    // highlight keyboard
    keyboard.highlightKeys(degs: multiChord.lowerChord.stackedPitches, color: color)
    keyboard.highlightKeys(degs: secondChordPitches, color: secondColor)
  }
  
  static func highlightStackedCombined(multiChord: inout MultiChord, keyboard: inout Keyboard, color: Color, secondColor: Color) {
//    print("Highlighting combined\n--------")
    if let result = multiChord.resultChord {
      let stackedPitches = result.stackedPitches
            
      let lowerTonesStacked = stackedPitches.includeIfSameNote(multiChord.onlyInLower)
      let upperTonesStacked = stackedPitches.includeIfSameNote(multiChord.onlyInUpper)
      let commonTonesStacked = stackedPitches.includeIfSameNote(multiChord.commonTones)
      
      keyboard.highlightKeys(degs: lowerTonesStacked, color: color)
      keyboard.highlightKeys(degs: upperTonesStacked, color: secondColor)
      keyboard.highlightKeys(degs: commonTonesStacked, color: LinearGradient.commonTone(secondColor, color))
    }
  }
  
  static func highlightStackedCombinedOrSplit(multiChord: inout MultiChord, keyboard: inout Keyboard, color: Color, secondColor: Color) {
//    print("highlighting:", multiChord.lowerChord.name, multiChord.upperChord.name, multiChord.resultChord?.name ?? "nil")
    
    if let _/*result*/ = multiChord.resultChord {
//      print("Result chord exists! \(result.name)")
      ChordHighlighter.highlightStackedCombined(multiChord: &multiChord, keyboard: &keyboard, color: color, secondColor: secondColor)
    } else {
//      print("Result chord is nil.")
      ChordHighlighter.highlightStackedSplit(multiChord: &multiChord, keyboard: &keyboard, color: color, secondColor: secondColor)
    }
  }
}
