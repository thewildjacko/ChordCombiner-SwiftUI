//
//  Array Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

extension Array where Element == Int {
  // MARK: Set operations
  
  /// Returns an array of the combined elements of two Integer arrays, with no duplicate values, sorted in ascending order
  func combineSetFilterSort(_ otherArray: [Int]) -> [Int] {
    return Set(self).union(otherArray).sorted()
  }
  
  /// Returns a set of the combined elements of two Integer arrays
  func combineSetFilter(_ otherArray: [Int]) -> Set<Int> {
    return Set(self).union(otherArray)
  }
  
  /// Returns an array of the elements in an array not contained in the supplied `otherArray` parameter
  func subtracting(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().subtracting(otherArray))
  }
  
  /// Returns an array of the elements in an array also contained in the supplied `otherArray` parameter
  func intersection(_ otherArray: [Int]) -> [Int] {
    Array(self.toSet().intersection(otherArray))
  }
  
  /// Returns a Boolean value indicating whether the array is a superset of the supplied `otherArray` parameter
  func includes(_ otherArray: [Int]) -> Bool {
    self.toSet().isSuperset(of: otherArray)
  }
  
  /// Takes two Integer arrays and combines them by appending the second array—parameter `otherArray`—to the original array, filtering out elements that the original array already contains
  func combineAndFilter(_ otherArray: [Int]) -> [Int] {
    return self + otherArray.filter { !self.contains($0) }
  }
  
  /// For each element in an Integer array of raised pitch values (pitches that fall within the piano MIDI pitch range **21-108**), checks against each element in a supplied `baseDegrees` array **(0-11)** to see whether they match in key, *i.e. if  `(raisedPitch - pitch) % 12 == 0`*. If so, adds the raised pitch to the returned result array
  ///
  /// - remark: This method is useful for properly calculating ascending pitches and common tones for stacked chord voicings built from multiple chords
  func includeIfSameNote(_ baseDegrees: [Int]) -> [Int] {
    var result: [Int] = []
    
    for raisedPitch in self {
      for pitch in baseDegrees {
        if (raisedPitch - pitch) % 12 == 0 {
          result.append(raisedPitch)
        }
      }
    }
    
    return result
  }
  
  // MARK: currently unused
  
  /// takes in a parameter `rootNum: NoteNum` and operates on an array of Integer degrees **(0-11)**, returning a new array with each element  translated down in pitch by a number of half steps *(half step = 1)* equal to the rawValue of the `rootNum`
  func convert(to rootNum: NoteNum) -> [Int] {
    self.map { $0.minusDeg(rootNum.rawValue)}
  }
  
  /// appends a supplied value to an array if the value is not already present in the array
  mutating func appendIfDoesNotContain(_ value: Int) {
    if !self.contains(value) { self.append(value) }
  }
  
  /// Filters an array by removing elements that are contained in a second array supplied as a parameter
  func easyFilter(_ otherArray: [Int]) -> [Int] {
    return self.filter { !otherArray.contains($0) }
  }
}

extension Array where Element: Hashable {
  /// returns a set from a given array
  func toSet() -> Set<Element> {
    Set(self)
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
  
  func filterInSimple() -> [Element] {
    self.filter { $0.isSimpleChord }
  }
}

extension Array where Element == Degree {
  func intersectsWith(_ otherArray: [Element]) -> Bool {
    !self.toSet().intersection(otherArray).isEmpty
  }
}
