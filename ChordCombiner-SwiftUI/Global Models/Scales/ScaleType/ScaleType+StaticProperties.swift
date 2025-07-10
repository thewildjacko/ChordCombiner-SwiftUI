//
//  ScaleType+StaticProperties.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

extension ScaleType {
  static var allScaleDegreeNumbers: [[Int]] {
    ScaleType.allCases.map { $0.degreeNumbers }}

  static var typeByDegreeNumbers: [[Int]: ScaleType] = Dictionary(
    uniqueKeysWithValues: zip(allScaleDegreeNumbers, allCases)
  )

  static func typeByDegreeNumbersInCFiltered(degreeNumberCount: Int) -> [[Int]: ScaleType] {
    typeByDegreeNumbers.filter { $0.key.count == degreeNumberCount }
  }
}

extension ScaleType: MusicalBuildingBlock {
  init?(fromDegreeNumbersToMatch degreeNumbers: [Int]) {
    let count = degreeNumbers.count

    if let scaleType = ScaleType.typeByDegreeNumbersInCFiltered(degreeNumberCount: count)[degreeNumbers] {
      self = scaleType
    } else {
      return nil
    }
  }
}
