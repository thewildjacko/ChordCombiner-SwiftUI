//
//  ScaleFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/25/24.
//

import Foundation

struct ScaleFactory {
  static func containsTriad(triad: Triad) { // } -> [ScaleDetails] {
    var results: [ScaleDetails] = []
    var romanNums: [MajorScale.RomanNum] = []
    
    MajorScale.inAllKeys.forEach {
      if $0.degrees.includes(triad.degrees) {
        results.append($0)
        for index in MajorScale.RomanNum.allCases.indices {
          if triad.root.noteNum == $0.allNotes[index].noteNum {
            romanNums.append(MajorScale.RomanNum(deg: index))
          }
        }
      }
    }
    
    print("\(triad.name) is in the following Major scales:")
    
    for (index, result) in results.enumerated() {
      print("\t\(result.name). \(triad.name) is the \(romanNums[index]) of \(result.name)")
//      print(triad.enharmSwapped().name)
    }
//    return results
  }
}
