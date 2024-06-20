//
//  ScaleDetails.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 5/24/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ScaleDetails: ChordsAndScales {
  var scaleName: String { get }
  var scaleType: ScaleType { get }
  var parentScale: ScaleDetails { get }
  var mode: Mode.SevenDeg { get }
  var romanNum: String { get }
  var intervallicFormula: [ScaleInterval] { get }
  
  mutating func shiftMode(by offset: Int)
  
  mutating func switchMode(mode: Mode.SevenDeg)
  
  func translated(by offset: Int) -> ScaleDetails
  
  func enharmSwapped() -> ScaleDetails
  
  func getParallelModes(root: RootGen) -> [ScaleDetails]
  
  func getParentModes() -> [ScaleDetails]
}

extension ScaleDetails {    
  var noteNums: [NoteNum] {
    return allNotes.map {NoteNum($0.noteNum.num.minusDeg(root.noteNum.num))}
  }
  
  var intervallicFormula: [ScaleInterval] {
    var intervals = [ScaleInterval]()
    var octave = [Note]()
    octave.append(contentsOf: allNotes)
    octave.append(root)
    for i in 0..<(octave.count - 1) {
      let lower: Int = octave[i].num
      let upper: Int = i != octave.count - 2 ? octave[i + 1].num : octave[i + 1].num + 12
      let interval: Int = upper - lower
      if interval == 1 {
        intervals.append(.halfStep)
      } else {
        intervals.append(.wholeStep)
      }
    }
    return intervals
  }
}
