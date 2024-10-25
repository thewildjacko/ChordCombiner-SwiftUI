//
//  ChordCombiner_SwiftUITests.swift
//  ChordCombiner-SwiftUITests
//
//  Created by Jake Smolowe on 10/25/24.
//

import Testing
@testable import ChordCombiner_SwiftUI

struct ChordCombiner_SwiftUITests {
  var multiChordResultChordTest: MultiChord
  
  init() {
    multiChordResultChordTest = MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    )
  }
  
  @Test("Chords Combine Correctly")
  func chordsCombineCorrectly() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    #expect(multiChordResultChordTest.resultChord == Chord(.c, .ma13_sh11), "The lower and upper chords should combine to create a Cma13 chord")
  }
  
  @Test("All simple chord types are correct", arguments: ChordType.allSimpleChordTypes)
  func simpleChordTypesCountsAreCorrect(_ chordType: ChordType) async throws {
    var countIsCorrect: Bool
    let chordTypeIsCorrect: Bool = (chordType.isTriad || chordType.isFourNoteSimpleChord || chordType.isFiveNoteSimpleChord) && !chordType.isExtendedChord
    let count = chordType.degreeNumbers.count
    
    switch count {
    case 3:
      countIsCorrect = chordType.isTriad ? true : false
    case 4:
      countIsCorrect = chordType.isFourNoteSimpleChord ? true : false
    case 5:
      countIsCorrect = chordType.isFiveNoteSimpleChord ? true : false
    default:
      countIsCorrect = false
    }
    
    #expect(countIsCorrect && chordTypeIsCorrect, "allSimpleChordTypes should contain only 3- and 4-note chords, or 5-note chords without extensions")
  }
  
  @Test("All extended chords are correct", arguments: ChordType.allExtendedChordTypes)
  func extendedChordTypesAreCorrect(_ chordType: ChordType) async throws {
    let chordTypeIsCorrect: Bool = (!chordType.isTriad && !chordType.isFourNoteSimpleChord && !chordType.isFiveNoteSimpleChord) && chordType.isExtendedChord
    
    #expect(chordTypeIsCorrect, "allExtendedChordTypes should contain no triads or simple 4- or 5-note chords")
  }
  
  
}
