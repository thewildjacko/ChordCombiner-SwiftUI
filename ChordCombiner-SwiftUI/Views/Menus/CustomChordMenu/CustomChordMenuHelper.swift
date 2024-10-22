//
//  CustomChordMenuHelper.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/14/24.
//

import SwiftUI

//struct CustomChordMenuHelper {
//  
//  static func clearAccidentals(matchingAccidentals: inout Set<RootAccidental>) {
//    matchingAccidentals.removeAll()
//  }
//  
//  static func clearLetters(matchingLetters: inout Set<Letter>) {
//    matchingLetters.removeAll()
//  }
//
//  static func clearMatches(matchingLetters: inout Set<Letter>, matchingAccidentals: inout Set<RootAccidental>) {
//    matchingAccidentals.removeAll()
//    matchingLetters.removeAll()
//  }
//  
//  static func insertMatchingAccidental(lowerChord: Chord, upperChord: Chord, accidental: RootAccidental, matchingAccidentals: inout Set<RootAccidental>, matchesLower: Bool) {
//    var firstChord: Chord { matchesLower ? upperChord : lowerChord }
//    var secondChord: Chord { matchesLower ? lowerChord : upperChord }
//    
//    if firstChord.combinesWith(chordFrom: accidental, secondChord.chordType) {
//      matchingAccidentals.insert(accidental)
//    }
//  }
//  
//  static func matchByAccidental(selectedAccidental: RootAccidental, multiChord: MultiChord, matchingAccidentals: inout Set<RootAccidental>) {
//    for accidental in RootAccidental.allCases {
//      if selectedAccidental == multiChord.lowerChord.accidental {
//        CustomChordMenuHelper.insertMatchingAccidental(
//          lowerChord: multiChord.lowerChord,
//          upperChord: multiChord.upperChord,
//          accidental: accidental,
//          matchingAccidentals: &matchingAccidentals,
//          matchesLower: true
//        )
////        if multiChord.upperChord.combinesWith(chordFrom: accidental, multiChord.lowerChord.chordType) {
////          matchingAccidentals.insert(accidental)
////        }
//      } else {
//        CustomChordMenuHelper.insertMatchingAccidental(
//          lowerChord: multiChord.lowerChord,
//          upperChord: multiChord.upperChord,
//          accidental: accidental,
//          matchingAccidentals: &matchingAccidentals,
//          matchesLower: true
//        )
////        if multiChord.lowerChord.combinesWith(chordFrom: accidental, multiChord.upperChord.chordType) {
////          matchingAccidentals.insert(accidental)
////        }
//      }
//    }
//    print(matchingAccidentals.map { $0.rawValue })
//  }
//  
//  static func insertMatchingLetter(lowerChord: Chord, upperChord: Chord, letter: Letter, matchingLetters: inout Set<Letter>, matchesLower: Bool) {
//    var firstChord: Chord { matchesLower ? upperChord : lowerChord }
//    var secondChord: Chord { matchesLower ? lowerChord : upperChord }
//    
//    if firstChord.combinesWith(chordFrom: letter, secondChord.chordType) {
//      matchingLetters.insert(letter)
//    }
//  }
//  
//  static func matchByLetter(selectedLetter: Letter, multiChord: MultiChord, matchingLetters: inout Set<Letter>) {
//    for letter in Letter.allCases {
//      if selectedLetter == multiChord.lowerChord.letter {
//        CustomChordMenuHelper.insertMatchingLetter(
//          lowerChord: multiChord.lowerChord,
//          upperChord: multiChord.upperChord,
//          letter: letter,
//          matchingLetters: &matchingLetters,
//          matchesLower: true
//        )
////        if multiChord.upperChord.combinesWith(chordFrom: letter, multiChord.lowerChord.chordType) {
////          matchingLetters.insert(letter)
////        }
//      } else {
//        CustomChordMenuHelper.insertMatchingLetter(
//          lowerChord: multiChord.lowerChord,
//          upperChord: multiChord.upperChord,
//          letter: letter,
//          matchingLetters: &matchingLetters,
//          matchesLower: true
//        )
////        if multiChord.lowerChord.combinesWith(chordFrom: letter, multiChord.upperChord.chordType) {
////          matchingLetters.insert(letter)
////        }
//      }
//    }
//    print(matchingLetters.map { $0.rawValue })
//  }
//  
//  static func matchByLetterAndAccidental(multiChord: MultiChord, selectedLetter: Letter, matchingLetters: inout Set<Letter>, selectedAccidental: RootAccidental, matchingAccidentals: inout Set<RootAccidental>) {
//    CustomChordMenuHelper.clearMatches(matchingLetters: &matchingLetters, matchingAccidentals: &matchingAccidentals)
//
//    CustomChordMenuHelper.matchByLetter(selectedLetter: selectedLetter, multiChord: multiChord, matchingLetters: &matchingLetters)
//    
//    CustomChordMenuHelper.matchByAccidental(selectedAccidental: selectedAccidental, multiChord: multiChord, matchingAccidentals: &matchingAccidentals)
//  }
//}
