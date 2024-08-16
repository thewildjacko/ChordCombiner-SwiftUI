//
//  Matchmaker.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/30/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

struct Matchmaker {
  var resultChords: [ResultChord] = []
  
  var resultChord: ResultChord
  
  let roots: [RootGen] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]
  
  init(resultChord: ResultChord) {
    self.resultChord = resultChord
  }
  
  func getScale() {
    let root = resultChord.root.rootKey
    switch resultChord.type {
    case .dom7:
      let domScales: [ScaleDetails] = [MajorScale(root, mode: .five), MelodicMinorScale(root, mode: .four), DiminishedScale(root, shadowMode: .one), HarmonicMajorScale(root, mode: .three), MelodicMinorScale(root, mode: .five), HexatonicSharp9Sharp11Scale(root, shadowMode: .one)]
      let rcNums = Set(resultChord.noteNums)
      for scale in domScales {
        let scaleNums = Set(scale.noteNums)
        //                print(scaleNums, rcNums)
        if scaleNums.isSuperset(of: rcNums) {
          print("rc belongs to \(scale.name)")
        }
      }
    default:
      print("couldn't find scale!")
    }
  }
  
  mutating func popResultChords() {
    let lRootNum = resultChord.lowerRoot.num
    let lowerChordDegs = [[0, 4, 7, 11], [0, 4, 7, 10], [0, 3, 7, 10], [0, 3, 6, 10], [0, 3, 6, 9], [0, 4, 7, 9]]
    let triadDegs = [[0, 4, 7], [0, 3, 7], [0, 4, 8], [0, 3, 6], [0, 5, 7]]
    
    let resultMajScale = MajorScale(resultChord.root.rootKey)
    let resultChordDegs = resultChord.degsUnconvertedSortedFiltered
    //        print(resultChordDegs)
    let rcDegSet = Set(resultChordDegs)
    let rcDegsConverted = resultChordDegs.map {$0.plusDeg(lRootNum)}
    //        print(rcDegsConverted)
    
    for i in rcDegsConverted {
      for (index, degs) in lowerChordDegs.enumerated() {
        let lowerDegs = degs.map { $0.plusDeg(i).minusDeg(lRootNum) }
        if rcDegSet.isSuperset(of: lowerDegs) {
          //                    print(i, lowerDegs)
          for j in rcDegsConverted {
            for (tIndex, tDegs) in triadDegs.enumerated() {
              let upperDegs = tDegs.map { $0.plusDeg(j).minusDeg(lRootNum) }
              if rcDegSet.isSuperset(of: upperDegs) {
                //                                print(j, upperDegs)
                let resultDegs = lowerDegs.combineSetFilterSort(upperDegs)
                if resultChordDegs == resultDegs {
                  //                                    print(i, lowerDegs, j, upperDegs)
                  var fnc = FourNoteChord(rootNum: NoteNum(i.minusDeg(lRootNum)), type: FNCType.allCases[index], enharm: resultChord.enharm)
                  let fncRoot = fnc.root
                  if resultMajScale.noteNums.contains(fncRoot.noteNum) && !resultMajScale.keys.contains(fncRoot.key) {
                    fnc.swapEnharm()
                  }
                  let triad = Triad(rootNum: NoteNum(j.minusDeg(lRootNum)), type: TriadType.allCases[tIndex], enharm: resultChord.enharm)
                  let result = ResultChord(baseChord: fnc, upStrctTriad: triad)
                  if result.chordCategory.verdict == .goodToGo {
                    resultChords.append(result)
                  }
                }
              } else {
                continue
              }
            }
          }
        } else {
          continue
        }
      }
    }
  }
  
  func equivalentChords() -> [ResultChord] {
    var results: [ResultChord] = []
    let resultChordDegs = resultChord.degsUnconvertedSortedFiltered
    for result in resultChords {
      let resultDegs = result.degsUnconvertedSortedFiltered
      let resultCName = result.root.noteName + result.quality.rawValue
      let resultChordName = resultChord.root.noteName + resultChord.quality.rawValue
      if result != resultChord
          && !results.contains(result)
          && resultChordDegs == resultDegs
          && !(result.slashChord &&
               (resultCName == resultChordName || result.slashRoot != resultChord.slashRoot)) {
        results.append(result)
      }
    }
    return results
  }
  
  func allRC_Chords(roots: [RootGen], enharm: Enharmonic) -> [ResultChord] {
    var rcChords: [ResultChord] = []
    var lowerChords: [FourNoteChord] = []
    var triads: [Triad] = []
    
    roots.forEach { root in
      for type in TriadType.allCases {
        var triad = Triad(root, type)
        triad.switchEnharm(to: enharm)
        triads.append(triad)
      }
      for type in FNCType.allCases {
        var lowerChord = FourNoteChord(root, type)
        lowerChord.switchEnharm(to: enharm)
        lowerChords.append(lowerChord)
      }
    }
    
//    for noteNum in NoteNum.allCases {
//      for type in TriadType.allCases {
//        triads.append(Triad(rootNum: noteNum, type: type))
//      }
//      for type in FNCType.allCases {
//        lowerChords.append(FourNoteChord(rootNum: noteNum, type: type))
//      }
//    }
    
    for lowerChord in lowerChords {
      for triad in triads {
        let result = ResultChord(baseChord: lowerChord, upStrctTriad: triad)
        result.baseChord.switchEnharm(to: enharm)
        result.upStrctTriad.switchEnharm(to: enharm)
        result.enharm = enharm
//        print(result.baseChord.root.key.name)
        rcChords.append(result)
      }
    }
    return rcChords
  }
  
  func allChordsContaining(_ deg1: Int, _ deg2: Int) -> [ResultChord] {
    let allRCChords = allRC_Chords(roots: roots, enharm: resultChord.enharm).filter {$0.root.rootKey == .c && ($0.baseChord.type == .dom7 || ($0.baseChord.type == .ma6 && $0.degrees.contains(10))) && ($0.degrees.contains(deg1) || $0.degrees.contains(deg2) || $0.degSet.isSuperset(of: [5, 11]))}
    return allRCChords
  }
  
  /// runs every UST in all keys against every lower chord in one key, defined by parameter `RootGen`, listing lc name, ust name, verdict, isTension, and whether verdict and isTension match
  func isTensionEqualsTension(root: RootGen) -> [ResultChord] {
    var allRCChords = allRC_Chords(roots: roots, enharm: .blackKeyFlats)
//    allRCChords.forEach { chord in
//      if chord.baseChord.root.rootKey == root {
//        print("\(chord.name)", "root: \(root.r.name)", "base chord root: \(chord.baseChord.root.rootKey.r.name)", "included", separator: String(repeating: "\t", count: 10))
//      } else {
//        print("\(chord.name)", "root: \(root.r.name)", "base chord root: \(chord.baseChord.root.rootKey.r.name)", "EXCLUDED", separator: String(repeating: "\t", count: 10))
//      }
//    }
      
    allRCChords = allRCChords.filter {
      $0.baseChord.root.rootKey == root }
//    for chord in allRCChords {
//      let verdict = chord.chordCategory.verdict
//      let isTension = chord.degSpecs.isTension
//      
//      print(chord.baseChord.name, chord.upStrctTriad.name, chord.name, verdict, isTension, chord.degrees, separator: "\t\t")
//      if (verdict == .goodToGo && isTension == true) || (verdict == .tension && isTension == false) {
//        print("MISMATCH!")
//      }
//    }
    
//    print(String(repeating: "-", count: 40))
    return allRCChords
  }
  
  func suffixEqualsQuality() -> Bool {
    let rcChords = allRC_Chords(roots: roots, enharm: resultChord.enharm)
    
    let okChords = rcChords.filter {$0.type != .ma6 && $0.chordCategory.verdict == .goodToGo}
    return okChords.allSatisfy {
      $0.quality.rawValue == $0.suffix
    }
  }
  
  func ustDegsEqualsUpperStructureNotes() -> Bool {
    let rcChords = allRC_Chords(roots: roots, enharm: resultChord.enharm)
    
    let okChords = rcChords.filter {$0.type != .ma6
      && $0.chordCategory.verdict == .goodToGo
      && $0.lowerRoot.noteName == "C"}
    for result in okChords {
      if result.uprStrNotes != result.chord.uprStrNotes {
        print(Array(result.degSet).sorted(), Array(result.baseChord.degSet).sorted())
        print(result.degSet.subtracting(result.baseChord.degSet))
        print(result.baseChord.name, result.upStrctTriad.name)
        print(result.initialDegSpecs.extensions)
        if let extNum = result.initialDegSpecs.upperExtNum {
          print(extNum)
        }
        print(result.name, result.uprStrNotes, result.chord.uprStrNotes, "\n")
      }
    }
    return okChords.allSatisfy {
      Set($0.uprStrNotes) == Set($0.chord.uprStrNotes)
    }
  }
}
