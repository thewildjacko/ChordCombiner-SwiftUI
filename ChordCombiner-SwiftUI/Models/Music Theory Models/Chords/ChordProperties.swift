//
//  ChordProperties.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/22/24.
//


import SwiftUI

struct ChordProperties: Equatable {
  var id: UUID = UUID()
  var letter: Letter?
  var accidental: RootAccidental?
  var chordType: ChordType?
  
  var propertiesAreSet: Bool {
    return letter != nil && accidental != nil && chordType != nil
  }
  
  init(letter: Letter? = nil, accidental: RootAccidental? = nil, chordType: ChordType? = nil) {
    self.letter = letter
    self.accidental = accidental
    self.chordType = chordType
  }
}