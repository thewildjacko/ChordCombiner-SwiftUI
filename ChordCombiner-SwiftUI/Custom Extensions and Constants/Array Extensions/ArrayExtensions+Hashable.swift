//
//  ArrayExtensions+Hashable.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

extension Array where Element: Hashable {
  /// returns a set from a given array
  func toSet() -> Set<Element> { Set(self) }

  func intersectsWith(_ otherArray: [Element]) -> Bool {
    !self.toSet().isDisjoint(with: otherArray)
  }
}
