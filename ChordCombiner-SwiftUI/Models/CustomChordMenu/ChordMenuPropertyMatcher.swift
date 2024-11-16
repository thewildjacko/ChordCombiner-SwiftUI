//
//  ChordMenuPropertyMatcher.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/13/24.
//

import SwiftUI

struct ChordMenuPropertyMatcher {
  let multiChord: MultiChord
  let isLowerChordMenu: Bool
  
  @Binding var matchingLetters: Set<Letter>
  @Binding var matchingAccidentals: Set<RootAccidental>
  @Binding var matchingChordTypes: Set<ChordType>
  
  func clearLetters() { matchingLetters.removeAll() }
  func clearAccidentals() { matchingAccidentals.removeAll() }
  func clearChordTypes() { matchingChordTypes.removeAll() }
  
  func clearMatches(propertyChanged: ChordProperties.ChordPropertyChanged) {
    if propertyChanged == .accidental || propertyChanged == .chordType { clearLetters() }
    if propertyChanged == .letter || propertyChanged == .chordType { clearAccidentals() }
    if propertyChanged == .letter || propertyChanged == .accidental { clearChordTypes() }
  }
  
  func setChordsForMatches() -> (firstChord: Chord?, secondChord: Chord?) {
    guard let lowerChord = multiChord.lowerChord,
          let upperChord = multiChord.upperChord else {
      return (nil, nil)
    }
    
    let (firstChord, secondChord) = isLowerChordMenu ?
    (upperChord, lowerChord) :
    (lowerChord, upperChord)
    
    return (firstChord, secondChord)
  }
  
  func insertMatching<T: ChordAndScaleProperty>(chordProperty: T, matchingProperties: inout Set<T>) {
    guard let firstChord = setChordsForMatches().firstChord,
          let secondChord = setChordsForMatches().secondChord else {
      return
    }
    
    if secondChord.variantCombinesWith(chordFrom: chordProperty, chordToMatch: firstChord) {
      chordProperty.insertMatching(matchingProperties: &matchingProperties)
    }
  }
  
  func matchByLetter() {
    for letter in Letter.allCases {
      insertMatching(chordProperty: letter, matchingProperties: &matchingLetters)
    }
  }
  
  func matchByAccidental() {
    for accidental in RootAccidental.allCases {
      insertMatching(chordProperty: accidental, matchingProperties: &matchingAccidentals)
    }
  }
  
  func matchByChordType() {
    for chordType in ChordType.allSimpleChordTypes {
      insertMatching(chordProperty: chordType, matchingProperties: &matchingChordTypes)
    }
  }
  
  func matchChords() {
    matchByLetter()
    matchByAccidental()
    matchByChordType()
  }
  
  func renewChordMatches(propertyChanged: ChordProperties.ChordPropertyChanged) {
    if propertyChanged == .accidental || propertyChanged == .chordType { matchByLetter() }
    if propertyChanged == .letter || propertyChanged == .chordType { matchByAccidental() }
    if propertyChanged == .letter || propertyChanged == .accidental { matchByChordType() }
  }
  
  func clearAndMatchChords(propertyChanged: ChordProperties.ChordPropertyChanged) {
    clearMatches(propertyChanged: propertyChanged)
    renewChordMatches(propertyChanged: propertyChanged)
  }
}

