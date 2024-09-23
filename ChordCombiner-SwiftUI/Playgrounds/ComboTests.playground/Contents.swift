import SwiftUI

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
