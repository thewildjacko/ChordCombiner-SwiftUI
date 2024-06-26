//
//  ScaleFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/25/24.
//

import Foundation

struct ScaleFactory {
  static let roots = RootGen.allCases
  static let cMa = Triad()
  
  static var allMajorScales: [ScaleDetails] {
    roots.map { MajorScale($0) }
  }
  
  static var majorScaleNames: [String] {
    allMajorScales.map {
      $0.name
    }
  }
  
  static func containsTriad(triad: Triad) -> [ScaleDetails] {
    var results: [ScaleDetails] = []
    var romanNums: [MajorScale.RomanNum] = []
    let triadDegSet = triad.degrees.toSet()
    
    allMajorScales.forEach {
      let degSet = $0.degrees.toSet()
      if degSet.isSuperset(of: triadDegSet) {
        results.append($0)
        for index in MajorScale.RomanNum.allCases.indices {
          if triad.root.noteNum == $0.allNotes[index].noteNum {
            romanNums.append(MajorScale.RomanNum(deg: index))
          }
        }
      }
    }
    
    print("\(triad.name) is in the following major scales:")
    
    for (index, result) in results.enumerated() {
      print("\(result.name). \(triad.name) is the \(romanNums[index]) of \(result.name)")
//      for index in MajorScale.RomanNum.allCases.indices {
//        if triad.root.key == result.allNotes[index].key {
//          print("\(triad.name) is the \(MajorScale.RomanNum(deg: index))")
//        }
//      }
    }
    
//    allMajorScales.forEach {
//      let scaleDegSet = $0.degrees.toSet()
//      print("\($0.name) contains \(triad.name) contains: \(scaleDegSet.isSuperset(of: triadDegSet))") // contains(triad.degrees))")
//    }

    
    
    return results
  }
}
