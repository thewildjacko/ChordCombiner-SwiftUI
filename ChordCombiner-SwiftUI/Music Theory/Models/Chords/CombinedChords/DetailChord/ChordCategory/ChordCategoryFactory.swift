//
//  ChordCategoryFactory.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

struct ChordCategoryFactory {
  static func getChordCategory(resultChord: ResultChord?) -> ChordCategory {
    if let rc = resultChord {
      let dc = rc.details
      switch dc.dct {
      case .dom7:
        return DetailChord.Dom7(resultChord: rc, detailChord: dc)
      case .ma7:
        return DetailChord.Maj7(resultChord: rc, detailChord: dc)
      case .mi7:
        return DetailChord.Min7(resultChord: rc, detailChord: dc)
      case .mi7_b5:
        return DetailChord.Min7_b5(resultChord: rc, detailChord: dc)
      case .dim7:
        return DetailChord.Dim7(resultChord: rc, detailChord: dc)
      case .ma6:
        switch rc.degSet {
        case let degs where degs.contains(10):
          return DetailChord.Dom7(resultChord: rc, detailChord: dc)
        case let degs where degs.contains(11):
          return DetailChord.Maj7(resultChord: rc, detailChord: dc)
        default:
          return DetailChord.Maj6(resultChord: rc, detailChord: dc)
        }
        
      default:
        fatalError("DetailChord couldn't find ResultChord! (ChordCategoryFactory)")
      }
    } else {
      fatalError("Couldn't get ResultChord!")
    }
  }
}
