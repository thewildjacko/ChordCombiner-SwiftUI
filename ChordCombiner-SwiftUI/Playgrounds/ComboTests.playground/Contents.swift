import SwiftUI

//for type in ChordType.allChordTypesMinusOmits {
//  print(type.commonName)
//}

var chord = Chord(.c, .ma13_sh11, startingOctave: 4)
print(chord.type.degreeTags)

var allChordNotesInKey = chord.voicingCalculator.allChordNotesInKey
var allNotes = chord.allNotes
print(allNotes)

for note in allNotes {
  allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
}

print(allChordNotesInKey)

//let containingChords = chord.containingChords().map { $0.commonName }
//for chordName in containingChords {
//  print(chordName)
//}
