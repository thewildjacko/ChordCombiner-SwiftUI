//
//  MultiChordVoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import Foundation

struct MultiChordVoicingCalculator {
  var lowerChordVoicingCalculator: VoicingCalculator
  var upperChordVoicingCalculator: VoicingCalculator
  
  var lowerStackedPitches: [Int] {
    lowerChordVoicingCalculator.stackedPitches
  }

  var upperStackedPitches: [Int] {
    upperChordVoicingCalculator.stackedPitches
  }
  
  var lowerRoot: Note {
    lowerChordVoicingCalculator.rootNote.note
  }

  var upperRoot: Note {
    upperChordVoicingCalculator.rootNote.note
  }

  var lowerDegrees: [Int] {
    lowerChordVoicingCalculator.degrees
  }

  var upperDegrees: [Int] {
    upperChordVoicingCalculator.degrees
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
  
  
  
  static func stackedSplit(lowerPitches: [Int], upperPitches: [Int]) -> (lowerPitches: [Int], upperPitches: [Int]) {
    //    print("Highlighting split\n--------")
    // set initial 2nd chord stacked degrees
    var secondChordPitches = upperPitches
    
    // set 1st Chord highest pitch, 2nd chord lowest pitch
    let chordMax = lowerPitches.max() ?? 0
    let secondChordMin = upperPitches.min() ?? 0
    
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
    
    return (lowerPitches, secondChordPitches)
  }  
}
