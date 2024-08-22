//
//  ChordCategory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ChordCategory {
  var dRC: ResultChord? { get }
  var verdict: Verdict { get set }
  var slashRoot: Root? { get set }
  var detailChord: DetailChord? { get }
  var chord: ComboChord { get set }
  var scale: ScaleDetails { get set }
  static var matches: [[Int]] { get }
  static var validCombos: [[[Int]]] { get }
  static var tcArray: [[Int]] { get }
  static var tensionTones: Set<Int> { get }
  
  init(resultChord: ResultChord?, detailChord: DetailChord?)
  
  mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int)
}

extension ChordCategory {
  mutating func getSlashRoot(offset: Int) {
    if let rc = dRC {
      let root = rc.lowerRoot
      let enharm = rc.enharm
      let newNum = root.num.minusDeg(offset)
      let newRootNum = NoteNum(newNum)
      slashRoot = Root(noteNum: newRootNum, enharm: enharm)
    }
  }
  
  func setRCSlashChord(_ root: Root?) {
    if let rc = dRC {
      if let _ = root {
        rc.slashChord = true
      } else {
        rc.slashChord = false
      }
    }
  }
  
  mutating func tensionOrGoodToGo() {
    if let rc = dRC, let dc = detailChord {
      let root = rc.lowerRoot.rootKey
      let degSet = rc.degSet
      
      if !dc.tension.contains(rc.degrees) {
        self.getComboChordAndScale(root: root, degSet: degSet, validCombosIndex: dc.validCombosIndex)
        setRCSlashChord(slashRoot)
      } else {
        setRCSlashChord(slashRoot)
        chord = TensionPolyChord(uprStrNotes: rc.upperDegs)
        verdict = .tension
        scale = ChromaticScale(root, chromaticRC: rc)
      }
    } else {
      fatalError("couldn't find RC!")
    }
  }
  
  func setRCType(_ type: FNCType) {
    if let rc = dRC {
      rc.type = type
    }
  }
}
