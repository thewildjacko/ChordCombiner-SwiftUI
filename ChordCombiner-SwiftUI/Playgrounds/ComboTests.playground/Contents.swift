import SwiftUI
import Algorithms

//for type in ChordType.allChordTypesMinusOmits {
//  print(type.commonName)
//}

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

let type = ChordType.typeByDegrees[[0, 3, 4, 6, 10]]
print(type)


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
print(chord.type.degreeTags)


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
