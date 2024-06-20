//
//  TensionChord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

struct TensionChordCategory: ChordCategory {
  var dRC: ResultChord?
  
  var verdict: Verdict = .tension
  
  var slashRoot: Root?
  
  var detailChord: DetailChord?
  
  var chord: ComboChord
  
  var scale: ScaleDetails
  
  static var matches: [[Int]] = []
  
  static var validCombos: [[[Int]]] = []
  
  static var tcArray: [[Int]] = []
  
  static var tensionTones: Set<Int> = []
  
  init(resultChord: ResultChord?, detailChord: DetailChord?) {
    self.dRC = resultChord
    self.detailChord = detailChord
    if let rc = dRC {
      let upStrNotes = rc.upperDegs.easyFilter(rc.lowerDegs)
      chord = TensionPolyChord(uprStrNotes: upStrNotes)
      let root = rc.lowerRoot.rootKey
      scale = ChromaticScale(root, chromaticRC: rc)
    } else {
      fatalError("couldn't find RC!")
    }
  }
  
  func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
  }
}

struct TensionPolyChord: ComboChord {
  static var validCombos: [[Int]] = []
  
  var quality: Suffix = .tension
  
  var uprStrNotes: [Int] = []
  
  init(uprStrNotes: [Int]) {
    self.uprStrNotes = uprStrNotes
  }
}
