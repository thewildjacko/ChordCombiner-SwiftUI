//
//  CVCStats.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/13/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation


enum ChordStat: Int {
  case letter = 0, accidental, type
}

/**
 Stores the row numbers of the pickers, plus the letter, accidental and chord type of the lower chord and upper structure tried
 
 **Initialization**
 
 1. `pickerStats`, `lowerChordStats` and `ustStats`
 */

struct CVCStats {
  var pickerStats: ((lettRows: [Int], accRows: [Int], qualRows: [Int])) // row in each picker for letter, accidental and chord type
  
  var lowerChordStats: (letter: Letter, accidental: RootAcc, type: FNCType) // lower chord letter, accidental and chord type
  var ustStats: (letter: Letter, accidental: RootAcc, type: TriadType) // upper structure triad letter, accidental and chord type
  
  
  init(
    pickerStats: ((lettRows: [Int], accRows: [Int], qualRows: [Int])),
    lowerChordStats: (letter: Letter, accidental: RootAcc, type: FNCType),
    ustStats: (letter: Letter, accidental: RootAcc, type: TriadType)) {
      self.pickerStats = pickerStats
      self.lowerChordStats = lowerChordStats
      self.ustStats = ustStats
    }
  
  /// converts `Int` to `Letter`, `RootAcc`, or type
  func getComponentStat(_ component: Int) -> ChordStat {
    ChordStat(rawValue: component) ?? .letter
  }
  
  /// changes letter of selected chord in cvcStats
  mutating func changeLetter(_ letter: Letter, isLower: Bool) {
    if isLower {
      lowerChordStats.letter = letter
    } else {
      ustStats.letter = letter
    }
  }
  
  /// changes accidental of selected chord in cvcStats
  mutating func changeAccidental(_ accidental: RootAcc, isLower: Bool) {
    if isLower {
      lowerChordStats.accidental = accidental
    } else {
      ustStats.accidental = accidental
    }
  }
  
  /// changes type of selected chord in cvcStats
  mutating func changeType(_ qual: QualProtocol, isLower: Bool) {
    if isLower {
      lowerChordStats.type = qual as! FNCType
    } else {
      ustStats.type = qual as! TriadType
    }
  }
}
