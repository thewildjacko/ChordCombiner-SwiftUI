import SwiftUI
import Algorithms

let allChordsInC = ChordFactory.allChordsInC
for chord in ChordFactory.allChordsInC {
  print(chord.voicingCalculator.stackedPitches, chord.voicingCalculator.stackedPitchesByDegree)
}

let names = allChordsInC.map { $0.preciseName }
let stackedPitches = allChordsInC.map { $0.voicingCalculator.stackedPitches }
let stackedPitchesByDegree = allChordsInC.map { $0.voicingCalculator.stackedPitchesByDegree }

var stackedPitchesComparison: [(name: String, stacked: [Int], stackedByDegree: [Int])] = []

for chord in ChordFactory.allChordsInC {
  let voicingCalculator = chord.voicingCalculator
  stackedPitchesComparison.append((chord.preciseName, voicingCalculator.stackedPitches, voicingCalculator.stackedPitchesByDegree))
}

stackedPitchesComparison

//
//var unmatchedChordDegreeSets: [[Int]] = []
//
//for chord in ChordFactory.allChordsInC {
//  for secondChord in ChordFactory.allChords.filter({ !ChordFactory.allChordsInC.contains($0) }) {
//    let degreeNumbers = Array(
//      (chord.degreeNumbers + secondChord.degreeNumbers).toSet()).map { $0.minusDegreeNumber(chord.root.noteNumber.rawValue)
//      }
//      .sorted()
//    
//    if degreeNumbers.count <= 8 && ChordFactory.combineChords(firstChord: chord, secondChord: secondChord).resultChord == nil && !unmatchedChordDegreeSets.contains(degreeNumbers) {
//      unmatchedChordDegreeSets.append(degreeNumbers)
//    }
//  }
//}
//
//unmatchedChordDegreeSets.sort { set1, set2 in
//  set1.count < set2.count
//}
//
//for degreeSet in unmatchedChordDegreeSets {
//  print(degreeSet)
//}
//
//let chordType = ChordType(fromDegreeNumbersToMatch: [0, 3, 4, 6, 10])
//print(chordType ?? "")
//
//for chordType in ChordType.allCases {
//  print(chordType.rawValue, chordType.degreeNumbers, chordType.degreeTags)
//}
//
//print(ChordType.allCases.filter({ !$0.rawValue.contains("omit9") }).count)
//
//var theChord = Chord(.c, .ma13_sh11)
//print(theChord.notesByNoteNumber)
//
//var multiChord = MultiChord(
//  lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .aug),
//  upperChordProperties: ChordProperties(letter: .a, accidental: .natural, chordType: .mi)
//)
//
//multiChord.resultChord
//
//let numbers: [Int] = Array(0...11)
//let numbersCycled = numbers.cycled(times: 2)
//numbersCycled.count
//let numbersCycledTrimmed = numbersCycled.trimmingSuffix { $0 > 1 }
//let numbersCycledWindowed = numbersCycledTrimmed.windows(ofCount: 3)
//
//var combos = numbers.combinations(ofCount: 8)
//combos.count
//var combosFiltered = combos.filter { $0.contains(0) }
//combosFiltered.count
//
//for (combo, window) in product(combosFiltered, numbersCycledWindowed) {
//  let windowArray = Array(window)
//  if combo.includes(windowArray) {
////    print(combo, windowArray)
//    if let index = combosFiltered.firstIndex(of: combo) {
//      combosFiltered.remove(at: index)
//    }
//  }
//}
//
//combosFiltered
//combosFiltered.count
//
//var all8NoteChordDegrees = ChordType.allChordDegreeNumbers.filter { $0.count == 8 }
//
//combosFiltered = combosFiltered.filter { combo in
//  !all8NoteChordDegrees.contains(combo)
//}
//
//for degreeNumber in 1...11 {
//  for (index, degreeNumbers) in all8NoteChordDegrees.enumerated() {
//    all8NoteChordDegrees[index] = degreeNumbers.map { $0.plusDegreeNumber(degreeNumber) }
//  }
//  
//  for (combo, degreeNumbers) in product(combosFiltered, all8NoteChordDegrees) {
//    if combo.includes(degreeNumbers) {
//      if let index = combosFiltered.firstIndex(of: combo) {
//        combosFiltered.remove(at: index)
//      }
//    }
//  }
//  
//  all8NoteChordDegrees = ChordType.allChordDegreeNumbers.filter { $0.count == 8 }
//}
//
//combosFiltered.count
//for combo in combosFiltered {
//  print(combo)
//}
//
//
//ChordFactory.combos(count: 4)
//
//var chord = Chord(.c, .ma13_sh11, startingOctave: 4)
//print(chord.chordType.degreeTags)
//
//
//var allNotes = chord.notesByNoteNumber.values
//var allChordNotesInKey = chord.voicingCalculator.allChordNotesInKeyFiltered
////print(allChordNotesInKey)
////print(allNotes)
//
//for note in allNotes {
//  allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
//}
//
//print(allChordNotesInKey)
//
////let containingChords = chord.containingChords().map { $0.commonName }
////for chordName in containingChords {
////  print(chordName)
////}
////
