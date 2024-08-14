//
//  ChordProtocol.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation
import UIKit

protocol ChordProtocol: ChordsAndScales, KSwitch {
  var noteCount: Int { get }
  var chordName: String { get }
//  var qualSuffix: QualProtocol {get set}
  var degSet: Set<Int> { get }
  var convertedDegrees: [Int] {get set}
  
  func enharmSwapped() -> ChordProtocol
  func translated(by offset: Int) -> ChordProtocol
  
  mutating func convertDegrees(to root: NoteNum)
  mutating func convertDegsToOwnRoot()
}

extension ChordProtocol {
  var name: String {
    return root.noteName + chordName
  }
  
  var noteNums: [NoteNum] {
    return allNotes.map { $0.noteNum }
  }
  
  var degSet: Set<Int> {
    return Set(degrees)
  }
  
  mutating func convertDegrees(to root: NoteNum) {
    convertedDegrees = degrees.map { $0.minusDeg(root.num)}
  }
  
  mutating func convertDegsToOwnRoot() {
    convertedDegrees = degrees.map { $0.minusDeg(root.num) }
  }
}
