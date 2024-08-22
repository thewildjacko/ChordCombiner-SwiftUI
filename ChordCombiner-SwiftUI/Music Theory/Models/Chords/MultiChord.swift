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
  
  var lowerRoot: {
    lowerChord.root
  }

  var upperRoot: {
    upperChord.root
  }

  var lowerDegrees: {
    lowerChord.degrees
  }

  var upperDegrees: {
    upperChord.degrees
  }
}
