import SwiftUI
import Algorithms

let lowerDegrees = [0, 4, 7, 10]
lowerDegrees.convert(to: .two)
let upperDegrees = [2, 4, 9]
let upperDegrees2 = [2, 6, 9]

let resultChord = ChordFactory.combineChordDegrees(degrees: lowerDegrees, otherDegrees: upperDegrees, root: Note(.c), otherRoot: Note(.d))
let resultChord2 = ChordFactory.combineChordDegrees(degrees: lowerDegrees, otherDegrees: upperDegrees2, root: Note(.c), otherRoot: Note(.d))

//let stackedPitches = [60, 64, 67, 70, 74, 76, 81]
let stackedPitches = resultChord?.voicingCalculator.stackedPitches ?? []
let stackedPitches2 = resultChord2?.voicingCalculator.stackedPitches ?? []

var onlyInLower: [Int] {
  lowerDegrees.subtracting(upperDegrees2)
}

var onlyInUpper: [Int] {
  upperDegrees2.subtracting(lowerDegrees)
}

var commonTones: [Int] {
  lowerDegrees.intersection(upperDegrees2)
}

let lowerTones = stackedPitches2.includeIfSameNote(onlyInLower)
let upperTones = stackedPitches2.includeIfSameNote(onlyInUpper)
let sharedTones = stackedPitches2.includeIfSameNote(commonTones)



let chordType = ChordType.mi_ma13
let chordType2 = ChordType.mi_ma9
chordType.isTriad
chordType.isModifiedTriad
chordType.isFourNote6thChord
chordType.isFourNote7thChord
chordType.isFourNoteSimpleChord
chordType.isSimpleChord
chordType.isExtendedChord
chordType.is9thChord
chordType.is11thChord
chordType.is13thChord
chordType2.is9thChord
chordType2.is11thChord
chordType2.is13thChord



for array in ChordType.allSimpleChordTypesMinusOmits {
  for chordType in array {
    print(chordType.commonName)
  }
}
/*
//var unmatchedChordDegreeSets: [[Int]] = []
//
//for chord in ChordFactory.allChordsInC {
//  for secondChord in ChordFactory.allChords.filter({ !ChordFactory.allChordsInC.contains($0) }) {
//    let degrees = Array(
//      (chord.degrees + secondChord.degrees).toSet()).map { $0.minusDeg(chord.root.noteNum.rawValue)
//      }
//      .sorted()
//    
//    if degrees.count <= 8 && ChordFactory.combineChordDegrees(lowerDegrees: chord.degrees, upperDegrees: secondChord.degrees, lowerRoot: chord.root, upperRoot: secondChord.root) == nil && !unmatchedChordDegreeSets.contains(degrees) {
//      unmatchedChordDegreeSets.append(degrees)
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

//let chordType = ChordType.typeByDegrees[[0, 3, 4, 6, 10]]
//print(chordType)

for chordType in ChordType.allCases {
  print(chordType.rawValue, chordType.degrees, chordType.degreeTags)
}

print(ChordType.allCases.filter({ !$0.rawValue.contains("omit9") }).count)

var theChord = Chord(.c, .ma13_sh11)
print(theChord.notesByNoteNum)

var multiChord = MultiChord(
  lowerChord: Chord(.c, .aug, startingOctave: 4),
  upperChord: Chord(.a, .mi, startingOctave: 4)
)

multiChord.resultChord = ChordFactory.combineChordDegrees(lowerDegrees: multiChord.multiChordVoicingCalculator.lowerDegrees, upperDegrees: multiChord.multiChordVoicingCalculator.upperDegrees, lowerRoot: multiChord.multiChordVoicingCalculator.lowerRoot, upperRoot: multiChord.multiChordVoicingCalculator.upperRoot)

multiChord.resultChord



let numbers: [Int] = Array(0...11)
let numbersCycled = numbers.cycled(times: 2)
numbersCycled.count
let numbersCycledTrimmed = numbersCycled.trimmingSuffix { $0 > 1 }
let numbersCycledWindowed = numbersCycledTrimmed.windows(ofCount: 3)

var combos = numbers.combinations(ofCount: 8)
combos.count
var combosFiltered = combos.filter { $0.contains(0) }
combosFiltered.count

for (combo, window) in product(combosFiltered, numbersCycledWindowed) {
  let windowArray = Array(window)
  if combo.includes(windowArray) {
//    print(combo, windowArray)
    if let index = combosFiltered.firstIndex(of: combo) {
      combosFiltered.remove(at: index)
    }
  }
}

combosFiltered
combosFiltered.count

var all8NoteChordDegrees = ChordType.allChordDegrees.filter { $0.count == 8 }

combosFiltered = combosFiltered.filter { combo in
  !all8NoteChordDegrees.contains(combo)
}

for degree in 1...11 {
  for (index, degrees) in all8NoteChordDegrees.enumerated() {
    all8NoteChordDegrees[index] = degrees.map { $0.plusDeg(degree) }
  }
  
  for (combo, degrees) in product(combosFiltered, all8NoteChordDegrees) {
    if combo.includes(degrees) {
      if let index = combosFiltered.firstIndex(of: combo) {
        combosFiltered.remove(at: index)
      }
    }
  }
  
  all8NoteChordDegrees = ChordType.allChordDegrees.filter { $0.count == 8 }
}

combosFiltered.count
for combo in combosFiltered {
  print(combo)
}


ChordFactory.combos(count: 4)

var chord = Chord(.c, .ma13_sh11, startingOctave: 4)
print(chord.chordType.degreeTags)


var allNotes = chord.notesByNoteNum.values
var allChordNotesInKey = chord.voicingCalculator.allChordNotesInKeyFiltered
//print(allChordNotesInKey)
//print(allNotes)

for note in allNotes {
  allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
}

print(allChordNotesInKey)

//let containingChords = chord.containingChords().map { $0.commonName }
//for chordName in containingChords {
//  print(chordName)
//}
*/
