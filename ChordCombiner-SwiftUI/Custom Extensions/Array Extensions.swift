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
  
  mutating func appendIfDoesNotContain(_ value: Int) {
    if !self.contains(value) {
      self.append(value)
    }
  }
  
  func includes(_ otherArray: [Int]) -> Bool {
    self.toSet().isSuperset(of: otherArray)
  }
}

extension Array where Element: Hashable {
  func toSet() -> Set<Element> {
    return Set(self)
  }
}
