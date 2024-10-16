//
//  CustomChordMenuViewModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/14/24.
//

import SwiftUI

class CustomChordMenuViewModel {
  
  @Published var chord: Chord
  @Published var keyboard: Keyboard
  @Published var selectedLetter: Letter
  @Published var selectedAccidental: RootAccidental

  static func clearAccidentals(matchingAccidentals: inout Set<RootAccidental>) {
    matchingAccidentals.removeAll()
  }
  
  static func clearLetters(matchingLetters: inout Set<Letter>) {
    matchingLetters.removeAll()
  }

  static func clearMatches(matchingLetters: inout Set<Letter>, matchingAccidentals: inout Set<RootAccidental>) {
    matchingAccidentals.removeAll()
    matchingLetters.removeAll()
  }
  
  static func insertMatchingAccidental(lowerChord: Chord, upperChord: Chord, accidental: RootAccidental, matchingAccidentals: inout Set<RootAccidental>, matchesLower: Bool) {
    var firstChord: Chord { matchesLower ? upperChord : lowerChord }
    var secondChord: Chord { matchesLower ? lowerChord : upperChord }
    
    if firstChord.combinesWith(chordFrom: accidental, secondChord.type) {
      matchingAccidentals.insert(accidental)
    }
  }
  
  static func matchByAccidental(selectedAccidental: RootAccidental, multiChord: MultiChord, matchingAccidentals: inout Set<RootAccidental>) {
    for accidental in RootAccidental.allCases {
      if selectedAccidental == multiChord.lowerChord.accidental {
        CustomChordMenuViewModel.insertMatchingAccidental(
          lowerChord: multiChord.lowerChord,
          upperChord: multiChord.upperChord,
          accidental: accidental,
          matchingAccidentals: &matchingAccidentals,
          matchesLower: true
        )
//        if multiChord.upperChord.combinesWith(chordFrom: accidental, multiChord.lowerChord.type) {
//          matchingAccidentals.insert(accidental)
//        }
      } else {
        CustomChordMenuViewModel.insertMatchingAccidental(
          lowerChord: multiChord.lowerChord,
          upperChord: multiChord.upperChord,
          accidental: accidental,
          matchingAccidentals: &matchingAccidentals,
          matchesLower: true
        )
//        if multiChord.lowerChord.combinesWith(chordFrom: accidental, multiChord.upperChord.type) {
//          matchingAccidentals.insert(accidental)
//        }
      }
    }
    print(matchingAccidentals.map { $0.rawValue })
  }
  
  static func insertMatchingLetter(lowerChord: Chord, upperChord: Chord, letter: Letter, matchingLetters: inout Set<Letter>, matchesLower: Bool) {
    var firstChord: Chord { matchesLower ? upperChord : lowerChord }
    var secondChord: Chord { matchesLower ? lowerChord : upperChord }
    
    if firstChord.combinesWith(chordFrom: letter, secondChord.type) {
      matchingLetters.insert(letter)
    }
  }
  
  static func matchByLetter(selectedLetter: Letter, multiChord: MultiChord, matchingLetters: inout Set<Letter>) {
    for letter in Letter.allCases {
      if selectedLetter == multiChord.lowerChord.letter {
        CustomChordMenuViewModel.insertMatchingLetter(
          lowerChord: multiChord.lowerChord,
          upperChord: multiChord.upperChord,
          letter: letter,
          matchingLetters: &matchingLetters,
          matchesLower: true
        )
//        if multiChord.upperChord.combinesWith(chordFrom: letter, multiChord.lowerChord.type) {
//          matchingLetters.insert(letter)
//        }
      } else {
        CustomChordMenuViewModel.insertMatchingLetter(
          lowerChord: multiChord.lowerChord,
          upperChord: multiChord.upperChord,
          letter: letter,
          matchingLetters: &matchingLetters,
          matchesLower: true
        )
//        if multiChord.lowerChord.combinesWith(chordFrom: letter, multiChord.upperChord.type) {
//          matchingLetters.insert(letter)
//        }
      }
    }
    print(matchingLetters.map { $0.rawValue })
  }
  
  static func matchByLetterAndAccidental(multiChord: MultiChord, selectedLetter: Letter, matchingLetters: inout Set<Letter>, selectedAccidental: RootAccidental, matchingAccidentals: inout Set<RootAccidental>) {
    CustomChordMenuViewModel.clearMatches(matchingLetters: &matchingLetters, matchingAccidentals: &matchingAccidentals)

    CustomChordMenuViewModel.matchByLetter(selectedLetter: selectedLetter, multiChord: multiChord, matchingLetters: &matchingLetters)
    
    CustomChordMenuViewModel.matchByAccidental(selectedAccidental: selectedAccidental, multiChord: multiChord, matchingAccidentals: &matchingAccidentals)
  }
}
