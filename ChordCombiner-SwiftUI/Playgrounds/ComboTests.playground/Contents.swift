import SwiftUI
import Algorithms

let lowerDegreeNumbers = [0, 4, 7, 10]
lowerDegreeNumbers.converted(to: .two)
let upperDegreeNumbers = [2, 6, 9]
upperDegreeNumbers.converted(to: .two)
let upperDegreeNumbers2 = [2, 6, 9]

let firstChord = Chord(.c, .dominant7)
let secondChord = Chord(.d, .ma)

func combineChords(firstChord: Chord, secondChord: Chord) -> (resultChord: Chord?, equivalentChords: [Chord]) {
  // Assigns initial values for the result tuplet.
  var resultChord: Chord? = nil
  var equiavalentChords: [Chord] = []
  
  /// Combines the two degreeNumber arrays into a single set.
  let combinedDegreeSet = firstChord.degreeNumbers.combineSetFilter(secondChord.degreeNumbers)
  
  /// Tranposes the degreeNumber set to the key of C (C is 0 in a range of 0-11), then converts it into an array sorted in ascending order
  let combinedDegreesInC = Array(combinedDegreeSet).map { $0.minusDegreeNumber(firstChord.root.noteNumber.rawValue)
  }.sorted()
  
  /// First chord's ``RootKeyNote`` assigned to a constant for convenient reuse
  let lowerRootKeyNote = firstChord.rootKeyNote
  
  /// All ``RootKeyNotes`` in `firstChord`
  let firstChordRootKeyNotes = firstChord.allNotes.map { RootKeyNote($0.keyName) }
  
  /// All ``RootKeyNotes`` in `firstChord` minus  `lowerRootKeyNote`
  let firstChordRemainingRootKeyNotes = firstChordRootKeyNotes.filter { $0 != lowerRootKeyNote }
  
  /// All ``RootKeyNotes`` in `secondChord` not present in `firstChord`
  let secondChordUniqueRootKeyNotes = secondChord.allNotes.map { RootKeyNote($0.keyName) }
    .filter { !firstChordRootKeyNotes.contains($0) }

  /// All ``RootKeyNotes`` sorted in order of the original two chords' combined `allNotes` arrays, filtering out duplicate values and `lowerRootKeyNote`.
  var combinedRootKeyNotes = firstChordRemainingRootKeyNotes + secondChordUniqueRootKeyNotes
  
  /// the number of notes in `combinedDegreesInC` (for input into `ChordType.typeByDegreesInCFiltered`)
  let combinedDegreeCount = combinedDegreesInC.count
  
  /// Array of `ChordType` objects where each element matches `combinedDegreeCount` so that we're only comparing degreeNumber arrays of the same number of notes.
  let typeByDegreesFiltered = ChordType.typeByDegreesInCFiltered(degreeCount: combinedDegreeCount)
      
  // Checks the remaining roots for equivalent `Chords` by transposing the elements of `combinedDegreesInC` down by the numeric value of each new root so that the new root becomes 0, and running the tranposed degreeNumbers through `typeByDegreesFiltered`
  func checkForEquivalentChords() {
    for rootKeyNote in combinedRootKeyNotes {
      // set new degreeNumber array relative to new root
      let degreesInCRelativeToNewRoot = combinedDegreesInC.map { $0.minusDegreeNumber(rootKeyNote.keyName.noteNumber.rawValue) }.sorted()
      
      // check for matching ChordType based on new degreeNumbers
      if let chordType = typeByDegreesFiltered[degreesInCRelativeToNewRoot] {
        /// create chord from matching ChordType and add to equivalentChords array
        let chord = Chord(
          rootKeyNote,
          chordType,
          isSlashChord: true,
          slashChordBassNote: rootKeyNote
        )
        
        equiavalentChords.append(chord)
      }
    }
  }
  
  // check for matching ChordType based on combinedDegreesinC, assign chord from matching chordType to resultChord, and check for equivalentChords
  if let chordType = typeByDegreesFiltered[combinedDegreesInC] {
    resultChord = Chord(
      RootKeyNote(firstChord.root.rootKeyName),
      chordType,
      isSlashChord: false,
      slashChordBassNote: nil
    )
    
    checkForEquivalentChords()
    
  } else {
    while combinedRootKeyNotes.count >= 1 {
      print(combinedRootKeyNotes.map { $0.keyName })
      for rootKeyNote in combinedRootKeyNotes {
        let degreesInCRelativeToNewRoot = combinedDegreesInC.map { $0.minusDegreeNumber(rootKeyNote.keyName.noteNumber.rawValue) }.sorted()
        
        if let chordType = typeByDegreesFiltered[degreesInCRelativeToNewRoot] {
          resultChord = Chord(
            rootKeyNote,
            chordType,
            isSlashChord: true,
            slashChordBassNote: rootKeyNote
          )
          
          if let resultChord = resultChord {
            print(resultChord.commonName)
          }
          combinedRootKeyNotes.removeAll { $0 == rootKeyNote }
          print(combinedRootKeyNotes.map { $0.keyName })
          checkForEquivalentChords()
          break
        } else {
          combinedRootKeyNotes.removeAll { $0 == rootKeyNote }
          print(combinedRootKeyNotes.map { $0.keyName })
        }
      }
    }
  }
  
  if resultChord == nil {
//      print("couldn't find a match for degreeNumbers \(firstChord.degreeNumbers) or any other root in the chord.")
  }
  
  return (resultChord, equiavalentChords)
}

let (combinedChord, equivalentChords) = ChordFactory.combineChordsCheckingAllChords(firstChord, secondChord)

combinedChord
equivalentChords
print(equivalentChords.map {$0.commonName})

let (comboChord, comboEquivalentChords) = combineChords(firstChord: firstChord, secondChord: secondChord)

comboChord
comboEquivalentChords
print(comboEquivalentChords.map {$0.commonName})
comboEquivalentChords.map {$0.commonName}

equivalentChords.map { $0.preciseName }.sorted() == comboEquivalentChords.map { $0.preciseName }.sorted()
equivalentChords.map { $0.preciseName } == comboEquivalentChords.map { $0.preciseName }

let upperRootDegreesInC = Array(Set(lowerDegreeNumbers + upperDegreeNumbers)).map { $0.minusDegreeNumber(secondChord.root.noteNumber.rawValue) }.sorted()

upperRootDegreesInC

let converted = Array(firstChord.degreeNumbers + secondChord.degreeNumbers).converted(to: secondChord.root.keyName.noteNumber)

var combinedNotes: [RootKeyNote] {
  let firstChordRoots = firstChord.allNotes.map { RootKeyNote($0.keyName) }
  
  let secondChordRoots = secondChord.allNotes.map { RootKeyNote($0.keyName) }
   + secondChord.allNotes.map { RootKeyNote($0.keyName) }
  
  return Array(Set(firstChordRoots + secondChordRoots)
    .filter { $0 != firstChord.rootKeyNote })
}

combinedNotes


let resultChord = ChordFactory.combineChordDegrees(firstChordDegrees: lowerDegreeNumbers, secondChordDegrees: upperDegreeNumbers, firstChordRoot: Note(.c), secondChordRoot: Note(.d))
let resultChord2 = ChordFactory.combineChordDegrees(firstChordDegrees: lowerDegreeNumbers, secondChordDegrees: upperDegreeNumbers2, firstChordRoot: Note(.c), secondChordRoot: Note(.d))

//let stackedPitches = [60, 64, 67, 70, 74, 76, 81]
let stackedPitches = resultChord?.voicingCalculator.stackedPitches ?? []
let stackedPitches2 = resultChord2?.voicingCalculator.stackedPitches ?? []

var onlyInLower: [Int] {
  lowerDegreeNumbers.subtracting(upperDegreeNumbers2)
}

var onlyInUpper: [Int] {
  upperDegreeNumbers2.subtracting(lowerDegreeNumbers)
}

var commonTones: [Int] {
  lowerDegreeNumbers.intersection(upperDegreeNumbers2)
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
//    let degreeNumbers = Array(
//      (chord.degreeNumbers + secondChord.degreeNumbers).toSet()).map { $0.minusDegreeNumber(chord.root.noteNumber.rawValue)
//      }
//      .sorted()
//    
//    if degreeNumbers.count <= 8 && ChordFactory.combineChordDegrees(lowerDegreeNumbers: chord.degreeNumbers, upperDegreeNumbers: secondChord.degreeNumbers, lowerRoot: chord.root, upperRoot: secondChord.root) == nil && !unmatchedChordDegreeSets.contains(degreeNumbers) {
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

//let chordType = ChordType.typeByDegrees[[0, 3, 4, 6, 10]]
//print(chordType)

for chordType in ChordType.allCases {
  print(chordType.rawValue, chordType.degreeNumbers, chordType.degreeTags)
}

print(ChordType.allCases.filter({ !$0.rawValue.contains("omit9") }).count)

var theChord = Chord(.c, .ma13_sh11)
print(theChord.notesByNoteNum)

var multiChord = MultiChord(
  lowerChord: Chord(.c, .aug, startingOctave: 4),
  upperChord: Chord(.a, .mi, startingOctave: 4)
)

multiChord.resultChord = ChordFactory.combineChordDegrees(lowerDegreeNumbers: multiChord.multiChordVoicingCalculator.lowerDegreeNumbers, upperDegreeNumbers: multiChord.multiChordVoicingCalculator.upperDegreeNumbers, lowerRoot: multiChord.multiChordVoicingCalculator.lowerRoot, upperRoot: multiChord.multiChordVoicingCalculator.upperRoot)

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

for degreeNumber in 1...11 {
  for (index, degreeNumbers) in all8NoteChordDegrees.enumerated() {
    all8NoteChordDegrees[index] = degreeNumbers.map { $0.plusDegreeNumber(degreeNumber) }
  }
  
  for (combo, degreeNumbers) in product(combosFiltered, all8NoteChordDegrees) {
    if combo.includes(degreeNumbers) {
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
