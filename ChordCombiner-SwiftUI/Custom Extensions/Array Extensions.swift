//
//  Array Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

extension Array where Element == Int {
  func combineSetFilterSort(_ otherArray: [Int]) -> [Int] {
    return Set(self).union(otherArray).sorted()
  }
  
  func combineSetFilter(_ otherArray: [Int]) -> Set<Int> {
    return Set(self).union(otherArray)
  }
  
  func combineAndFilter(_ otherArray: [Int]) -> [Int] {
    return self + otherArray.filter { !self.contains($0) }
  }
  
  func easyFilter(_ otherArray: [Int]) -> [Int] {
    return self.filter { !otherArray.contains($0) }
  }
  
  func includeIfSameNote(_ otherArray: [Int]) -> [Int] {
    var result: [Int] = []
    
    for raisedPitch in self {
      for pitch in otherArray {
        if (raisedPitch - pitch) % 12 == 0 {
          result.append(raisedPitch)
        }
      }
    }
    
    return result
  }
  
  func subtracting(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().subtracting(otherArray))
  }
  
  func intersection(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().intersection(otherArray))
  }
  
  mutating func appendIfDoesNotContain(_ value: Int) {
    if !self.contains(value) {
      self.append(value)
    }
  }
  
  func includes(_ otherArray: [Int]) -> Bool {
    self.toSet().isSuperset(of: otherArray)
  }
  
  func convert(to rootNum: NoteNum) -> [Int] {
    self.map { $0.minusDeg(rootNum.rawValue)}
  }
}

extension Array where Element: Hashable {
  func toSet() -> Set<Element> {
    return Set(self)
  }
}

extension Array where Element == Note {
  func isEnharmonicEquivalent(to otherNoteArray: [Note]) -> Bool {
    if self.count != otherNoteArray.count {
      return false
    } else {
      let firstArray = self.sorted(by: { $0.noteNum.rawValue < $1.noteNum.rawValue } )
      let secondArray = otherNoteArray.sorted(by: { $0.noteNum.rawValue < $1.noteNum.rawValue } )
      
      var isEnharmonicEquivalent = true
      
      for i in (0...firstArray.count - 1) {
        if !firstArray[i].isEnharmonicEquivalent(to: secondArray[i]) {
          isEnharmonicEquivalent = false
        }
      }
      
      return isEnharmonicEquivalent
    }
  }
}

extension Array where Element == ChordType {
  func filterOmits() -> [Element] {
    self.filter { !$0.rawValue.contains("omit")}
  }
}


