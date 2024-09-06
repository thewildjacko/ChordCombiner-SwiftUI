//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI

class MultiChord: ObservableObject {
  @Published var lowerChord: Chord
  @Published var upperChord: Chord
  @Published var resultChord: Chord?
  
  init(lowerChord: Chord, upperChord: Chord, resultChord: Chord? = nil) {
//    print("initializing MultiChord (lowerChord: \(lowerChord.name), upperChord: \(upperChord.name))")
    self.lowerChord = lowerChord
    self.upperChord = upperChord
    self.resultChord = resultChord
  }
  
  var lowerRoot: Note {
    lowerChord.root
  }

  var upperRoot: Note {
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
  
  var lowerStackedPitches: [Int] {
    lowerChord.stackedPitches
  }
  
  var upperStackedPitches: [Int] {
    upperChord.stackedPitches
  }
}
