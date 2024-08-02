import UIKit

//print("\(FileManager.documentsDirectoryURL)\n")
//
//ScaleFactory.containsTriad(triad: Triad())

var cMajTriad = Chord(rootNum: .zero, type: .ma)

var Dma7 = Chord(.d, .ma7)
var Emaj = Chord(.e, .ma)

Dma7.degrees
Emaj.degrees

Dma7.convertDegsToOwnRoot()
Emaj.convertDegrees(to: Dma7.root.noteNum)

Dma7.convertedDegrees
Emaj.convertedDegrees



cMajTriad.degrees
cMajTriad.noteCount
cMajTriad.degSet
var BbAugTriad = Chord(rootNum: .ten, type: .aug)
BbAugTriad.degrees
cMajTriad.degSet.union(BbAugTriad.degSet)

var CAugTriad = Chord(rootNum: .zero, type: .aug)
//print(CAugTriad.allNotes.map {$0.noteName})
var CMaj13sh11 = Chord(rootNum: .zero, type: .ma13_sh11)
CMaj13sh11.noteCount

CMaj13sh11.degrees
CMaj13sh11.convertDegrees(to: .two)
CMaj13sh11.convertedDegrees
//print(CMaj13sh11.allNotes.map {$0.noteName})

let roots: [RootGen] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]

var allChords: [Chord] = []

for root in roots {
  for type in ChordType.allCases {
    allChords.append(Chord(root, type))
  }
}

var cSus4Triad = Chord(rootNum: .zero, type: .sus4)

//for chord in allChords {
//  if cSus4Triad.degSet == chord.degSet && chord != cSus4Triad {
//    chordMatches.append(chord)
//  }
//}

var Cma9 = Chord(rootNum: .zero, type: .ma9)

func chordsIn(_ root: RootGen, _ type: ChordType) -> [Chord] {
  var chordMatches: [Chord] = []
  let testChord = Chord(root, type)
  
  let notesbyNoteNum = testChord.notesByNoteNum
  let enharms = testChord.notesByNoteNum.map { $0.value.enharmByKey }
  
  for chord in allChords {
    let chordNum = chord.root.noteNum
    
    if testChord.degrees.includes(chord.degrees) && chord.name != testChord.name {
      if let noteNum = notesbyNoteNum.first(where: { $0.key == chordNum }) {
        let enharmByKey = noteNum.value.enharmByKey
        chordMatches.append(Chord(rootNum: chordNum, type: chord.type, enharm: enharmByKey))
      }
    }
  }
  
  return chordMatches
}

//let chordsInCma9 = chordsIn(.c, .ma9)

//print(chordsInCma9.map { $0.name } )
let chordsInCma13sh11 = CMaj13sh11.containingChords()
for chord in chordsInCma13sh11 {
  print(chord.name)
}


/*
var chordArray = ["| [[Cma9]] | [[Csus2/Cma7]] |", "| [[C9]] | [[Csus2/C7]] |", "| [[Cmi9]] | [[Csus2/Cmi7]] |", "| [[C6_9]] | [[Csus2/C6]] |", "| [[E13]] | [[Csus2/E6]] |", "| [[Fma13]] | [[Csus2/Fma7]] |", "| [[F13]] | [[Csus2/F7]] |", "| [[Fmi13]] | [[Csus2/Fmi7]] |", "| [[G♭ locrian]] | [[Csus2/G♭mi7(♭5)]] |", "| [[B7alt]] | [[Csus2/G♭˚7]] |", "| [[A♭ma7(♯11)]] | [[Csus2/A♭ma7]] |", "| [[Ami11]] | [[Csus2/Ami7]] |", "| [[Ami11(♭5)]] | [[Csus2/Ami7(♭5)]] |", "| [[A13]] | [[Csus2/A6]] |", "| [[B7alt]] | [[Csus2/B7]] |", "| [[Bmi7(♭9♭13)]] | [[Csus2/Bmi7]] |"]

chordArray.sort()

chordArray.forEach { chord in
  print(chord)
}

var lowerChords: [FourNoteChord] = []
var triads: [Triad] = []
 
let matchmaker = Matchmaker(resultChord: ResultChord(baseChord: FourNoteChord(), upStrctTriad: Triad(.c, .sus2)))

var chords: [ResultChord] = []

let roots: [RootGen] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]
let allRCChords = matchmaker.allRC_Chords(roots: roots, enharm: .blackKeyFlats)

//allRCChords.forEach { chord in
//  let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//    print(chord.name, slashName, separator: String(repeating: "\t", count: 10))
////  print(chord.name)
//}

chords = allRCChords

var c = Triad(.c, .sus2) // sus2 triad
c.switchEnharm(to: .blackKeyFlats)
var chordsWithC = chords.filter { $0.degSetUnconverted.isSuperset(of: c.degrees) }
  .filter { $0.chordCategory.verdict == .goodToGo /*&& $0.root == $0.lowerRoot */}

//chordsWithC.forEach { chord in
//  let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//    print(chord.name, slashName, separator: String(repeating: "\t", count: 10))
////  print(chord.name)
//}

var chordsWithCFiltered: [ResultChord] = []

for (index, chord) in chordsWithC.enumerated() {
  if let firstChordIndex = chordsWithC.firstIndex(where: { $0.name == chord.name }) {
    if index == firstChordIndex {
      chordsWithCFiltered.append(chord)
      let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
      var noteNames = Set(chord.noteNames).sorted(by: { KeyName(rawValue: $0)!.noteNum.rawValue < KeyName(rawValue: $1)!.noteNum.rawValue })
//      print(chord.name, "\(noteNames)", separator: String(repeating: "\t", count: 10))
      if chord.root.noteNum != .zero {
        for (index, root) in noteNames.enumerated() {
          if KeyName(rawValue: root)!.noteNum != chord.root.noteNum {
            noteNames.append(noteNames[0])
//            print("adding \(noteNames[0])", String(repeating: "\t", count: 10), noteNames)
//            print("removing \(noteNames[0])", String(repeating: "\t", count: 10), noteNames)
            noteNames.remove(at: 0)
          } else {
            break
          }
        }
      }
//      if chord.root.noteNum != .zero {
//        print(String(repeating: "\t", count: 10), "new notes: \(noteNames)", separator: "")
//      }
//      print(chord.name, "\(noteNames)", separator: String(repeating: "\t", count: 10))
//      print(chord.name)
    }
  }
}

let chordsWithCBaseIsC = chordsWithCFiltered.filter { $0.lowerDegs.includes(c.degrees) }
let chordsWithCUST = chordsWithCFiltered.filter { $0.upperDegs == c.degrees && !$0.lowerDegs.includes(c.degrees) }

//print("Chord Name | UST/Lower Chord\n-- | --")
//chordsWithCFiltered.forEach { chord in
//  let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//  print("| [[", chord.name, "]] | [[", slashName, "]] |", separator: "")
//}
//print("Chord Name | UST/Lower Chord\n-- | --")
//chordsWithCBaseIsC.forEach { chord in
//  let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//  print("| [[", chord.name, "]] | [[", slashName, "]] |", separator: "")
//}
//print("Chord Name | UST/Lower Chord\n-- | --")
//chordsWithCUST.forEach { chord in
//  let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//  print("| [[", chord.name, "]] | [[", slashName, "]] |", separator: "")
//}
*/
