import SwiftUI

for type in ChordType.allChordTypesMinusOmits {
  print(type.commonName)
}

var chord = Chord(.c, .ma13)
let containingChords = chord.containingChords().map { $0.commonName }
for chordName in containingChords {
  print(chordName)
}
