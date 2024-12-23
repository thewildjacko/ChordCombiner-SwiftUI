//
//  ChordAndScaleProperty.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/19/24.
//

import SwiftUI

enum PropertyStatus {
  case selected, matches, selectedAndMatches, neither
}

protocol ChordAndScaleProperty: CaseIterable,
                                Identifiable,
                                  Codable,
                                  Hashable,
                                  RawRepresentable where RawValue == String {

  func insertMatching<T: ChordAndScaleProperty>(matchingProperties: inout Set<T>)
}

extension ChordAndScaleProperty {
  func insertMatching<T>(matchingProperties: inout Set<T>) where T: ChordAndScaleProperty {
    if let property = self as? T {
      matchingProperties.insert(property)
    }

//    matchingProperties.insert(self as! T)
  }
}
