//
//  ArrayExtensions+ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import Foundation

extension Array where Element == ChordType {
  func filterOmits() -> [Element] {
    self.filter { !$0.rawValue.contains("omit")}
  }

  func filterInTriads() -> [Element] { self.filter { $0.isTriad }}

  func filterInSimple() -> [Element] { self.filter { $0.isSimpleChord }}

  func filterInFourNoteSimple() -> [Element] { self.filter { $0.isFourNoteSimpleChord }}

  func filterInExtended() -> [Element] { self.filter { $0.isExtendedChord }}
}
