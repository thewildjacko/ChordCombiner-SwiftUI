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
}
