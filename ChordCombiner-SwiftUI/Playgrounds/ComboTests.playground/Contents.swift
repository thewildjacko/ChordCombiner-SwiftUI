import UIKit

//print("\(FileManager.documentsDirectoryURL)\n")
//
//ScaleFactory.containsTriad(triad: Triad())

var lowerChords: [FourNoteChord] = []
var triads: [Triad] = []


//NoteNum.allCases.forEach { noteNum in
//  let triadsInKey = TriadType.allCases.map {
//    Triad(rootNum: noteNum, type: $0)
//  }.map { $0.name }
////  print(triadsInKey)
//  
//  let fourNoteChordsInKey = FNCType.allCases.map {
//    FourNoteChord(rootNum: noteNum, type: $0)
//  }.map { $0.name }
////  print(fourNoteChordsInKey)
//  
//}

//for noteNum in NoteNum.allCases {
//  for type in TriadType.allCases {
//    triads.append(Triad(rootNum: noteNum, type: type))
//  }
//  for type in FNCType.allCases {
//    lowerChords.append(FourNoteChord(rootNum: noteNum, type: type))
//  }
//}

//print(String(repeating: "-", count: 40))
//let triadNames = triads.map { $0.name }
//print(triadNames)

 

let matchmaker = Matchmaker(resultChord: ResultChord(baseChord: FourNoteChord(), upStrctTriad: Triad()))
//var chords: [ResultChord] = matchmaker.isTensionEqualsTension(root: .c)

var chords: [ResultChord] = []

let csh: RootGen = RootGen(.f, .sharp)

let fsh7 = ResultChord(baseChord: FourNoteChord(csh, .dom7, inversion: .root), upStrctTriad: Triad())

let allRCChords = matchmaker.allRC_Chords()

fsh7.noteNames
fsh7.name

let roots: [RootGen] = [.c, .dB, .d, .eB, .fB, .f, .gB, .g, .aB, .a, .bB, .cB]
roots.forEach { root in
  chords += matchmaker.isTensionEqualsTension(root: root)
}

let c = Triad()
var chordsWithC = chords.filter { $0.degSetUnconverted.isSuperset(of: c.degrees) }
//  .filter { $0.chordCategory.verdict == .goodToGo /*&& $0.root == $0.lowerRoot */}

var chordsWithCFiltered: [ResultChord] = []

//for (index, chord) in chordsWithC.enumerated() {
//  if let firstChordIndex = chordsWithC.firstIndex(where: { $0.name == chord.name }) {
//    if index == firstChordIndex {
//      chordsWithCFiltered.append(chord)
//      let slashName = "\(chord.upStrctTriad.name)/\(chord.baseChord.name)"
//      var noteNames = Set(chord.noteNames).sorted(by: { KeyName(rawValue: $0)!.noteNum.rawValue < KeyName(rawValue: $1)!.noteNum.rawValue })
////      print(chord.name, "\(noteNames)", separator: String(repeating: "\t", count: 10))
//      if chord.root.noteNum != .zero {
//        for (index, root) in noteNames.enumerated() {
//          if KeyName(rawValue: root)!.noteNum != chord.root.noteNum {
//            noteNames.append(noteNames[0])
////            print("adding \(noteNames[0])", String(repeating: "\t", count: 10), noteNames)
////            print("removing \(noteNames[0])", String(repeating: "\t", count: 10), noteNames)
//            noteNames.remove(at: 0)
//          } else {
//            break
//          }
//        }
//      }
////      if chord.root.noteNum != .zero {
////        print(String(repeating: "\t", count: 10), "new notes: \(noteNames)", separator: "")
////      }
////      print(chord.name, "\(noteNames)", separator: String(repeating: "\t", count: 10))
////      print(chord.name)
//    }
//  }
//}
//

//let chordsWithCUST = chordsWithCFiltered.filter {
//  let triadDegs = Triad().degrees
//  return $0.upperDegs == triadDegs && !$0.lowerDegs.includes(triadDegs)
//}

allRCChords.forEach {
  let slashName = "\($0.upStrctTriad.name)/\($0.baseChord.name)"
  print($0.name, slashName, separator: String(repeating: "\t", count: 10))
}

//chordsWithC.forEach {
//  let slashName = "\($0.upStrctTriad.name)/\($0.baseChord.name)"
//  print($0.name, slashName, separator: String(repeating: "\t", count: 10))
//}

//let chordsWithCUST = chordsWithCFiltered.filter {
//  let triadDegs = Triad().degrees
//  return $0.upperDegs == triadDegs && !$0.lowerDegs.includes(triadDegs)
//}

//chordsWithCUST.forEach { print($0.name) }


//let chordsWithCBaseIsC = chordsWithCFiltered.filter { $0.lowerDegs.includes(c.degrees)
//}

//chordsWithCBaseIsC.forEach {
//  print($0.name, "\($0.upStrctTriad.name)/\($0.baseChord.name)", separator: String(repeating: "\t", count: 10))
//}
