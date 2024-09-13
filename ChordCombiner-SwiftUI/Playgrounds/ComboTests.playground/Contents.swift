import UIKit

var chord = Chord(.c, .ma13)
let containingChords = chord.containingChords().map { $0.name }
for chordName in containingChords {
  print(chordName)
}
