//
//  ChordCombiner_SwiftUITests.swift
//  ChordCombiner-SwiftUITests
//
//  Created by Jake Smolowe on 10/25/24.
//

import Testing
import Foundation
@testable import ChordCombiner_SwiftUI

struct ChordCombinerTests {
  var chordCombinerViewModelResultChordTest = ChordCombinerViewModel.singleton()

  init() {
    chordCombinerViewModelResultChordTest = ChordCombinerViewModel.singleton()
  }
  
  @Test("Chords Combine Correctly")
  func chordsCombineCorrectly() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    #expect(chordCombinerViewModelResultChordTest.resultChord == Chord(.c, .ma13sh11), "The lower and upper chords should combine to create a Cma13 chord")
  }
  
  @Test("All simple chord types are correct", arguments: ChordType.allSimpleChordTypes)
  func simpleChordTypesCountsAreCorrect(_ chordType: ChordType) async throws {
    var countIsCorrect: Bool
    let chordTypeIsCorrect: Bool = (chordType.isTriad || chordType.isFourNoteSimpleChord) && !chordType.isExtendedChord
    let count = chordType.degreeNumbers.count
    
    switch count {
    case 3:
      countIsCorrect = chordType.isTriad ? true : false
    case 4:
      countIsCorrect = chordType.isFourNoteSimpleChord ? true : false
    default:
      countIsCorrect = false
    }
    
    #expect(countIsCorrect && chordTypeIsCorrect, "allSimpleChordTypes should contain only 3- and 4-note chords")
  }
  
  @Test("All extended chords are correct", arguments: ChordType.allExtendedChordTypes)
  func extendedChordTypesAreCorrect(_ chordType: ChordType) async throws {
    let chordTypeIsCorrect: Bool = (!chordType.isTriad && !chordType.isFourNoteSimpleChord) && chordType.isExtendedChord
    
    #expect(chordTypeIsCorrect, "allExtendedChordTypes should contain no triads or simple 4- or 5-note chords")
  }
  
  @Test("All ChordTypes are either simple or extended", arguments: ChordType.allCases)
  func allChordTypesAreSimpleOrExtended(_ chordType: ChordType) async throws {
    let chordTypeIsSimpleOrTriad: Bool = chordType.isSimpleChord || chordType.isExtendedChord
    
    #expect(chordTypeIsSimpleOrTriad, "All ChordTypes should be either Simple or Extended")
  }
  
  @Test("Simple and Extended ChordTypes Don't Overlap")
  func simpleAndExtendedChordTypesDontOverlap() async throws {
    let overlaps = !Set(ChordType.allSimpleChordTypes).intersection(ChordType.allExtendedChordTypes).isEmpty
    
    #expect(!overlaps, "Simple and Extended ChordTypes shouldn't overlap")
  }
  
  @Test("Chord: degreeNumbers matches degreeNumberSet", arguments: ChordFactory.allChordsInC)
  func degreeNumbersMatchesDegreeNumberSet(_ chord: Chord) async throws {
    let degreeNumbersMatchesDegreeNumberSet: Bool = chord.degreeNumbers.count == chord.degreeNumberSet.count
    
    #expect(degreeNumbersMatchesDegreeNumberSet, "all Chords should have no duplicate degree numbers")
  }
  
  @Test("Stacked pitchesByDegree matches stackedPitches", arguments: ChordFactory.allChordsInC)
  func stackedPitchesByDegreeMatchesStackedPitches(_ chord: Chord) async throws {
    #expect(chord.voicingCalculator.stackedPitches ==
            chord.voicingCalculator.stackedPitchesByDegree,
            """
            \n\(chord.preciseName)\n------\n\(chord.voicingCalculator.stackedPitches)\n\(chord.voicingCalculator
            .stackedPitchesByDegree)
            \nShould be able to get stacked pitches by sorting degrees by size\n
            """)
  }
  
  @Test("combineChords works correctly")
  func combineChordsWorksCorrectly() async throws {
    let lowerChord = Chord(.a, .ma7)
    let upperChord = Chord(.d, .ma)
    
    let resultChord = ChordCombiner.combineChords(firstChord: lowerChord, secondChord: upperChord)
    
    print(resultChord?.preciseName ?? "")
    
    #expect(resultChord?.preciseName ==
            """
Dma9(♯11)", "ChordCombiner.combineChords should not find 
an initial match for lowerChord \(lowerChord.preciseName) and upperChord \(upperChord.preciseName), but should keep searching
 through available roots and eventually land on a match for D.
"""
    )
  }
  
  @Test("Do notes without chords exist?", arguments: ChordFactory.allChordsInC)
  func doNotesWithoutChordsExist (_ chord: Chord) async throws {
    let chordGrapher = ChordGrapher(chord: chord)
    
    let noteWithoutChordsExists: Bool = !chordGrapher.chordGrapherRelationships.parentChord.notesWithoutChords.isEmpty
    
    print(chord.preciseName, chordGrapher.chordGrapherRelationships.parentChord.notesWithoutChords)
    
    #expect(noteWithoutChordsExists == false, "\(chord.preciseName): \(chordGrapher.chordGrapherRelationships.parentChord.notesWithoutChords.map {$0.noteName})")
  }
}
