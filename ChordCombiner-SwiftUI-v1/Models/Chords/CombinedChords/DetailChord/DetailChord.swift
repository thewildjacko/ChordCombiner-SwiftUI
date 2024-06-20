//
//  DetailChord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 5/29/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

struct DetailChord {
  enum DCType {
    case dom7, ma7, mi7, mi7_b5, dim7, ma6, error
  }
  
  static let zeroSet: Set<Int> = Set([0])
  
  var dRC: ResultChord?
  var dct: DCType
  
  var chordCategory: ChordCategory {
    get {
      return ChordCategoryFactory.getChordCategory(resultChord: dRC)
    }
    set {
      ()
    }
  }
  
  init(resultChord: ResultChord?) {
    self.dRC = resultChord
    if let rc = dRC {
      switch rc.baseChord.type {
      case .dom7:
        dct = .dom7
      case .ma7:
        dct = .ma7
      case .mi7:
        dct = .mi7
      case .mi7_b5:
        dct = .mi7_b5
      case .dim7:
        dct = .dim7
      case .ma6:
        switch rc.degSet {
        case let degs where degs.contains(10):
          rc.type = .dom7
          dct = .dom7
        case let degs where degs.contains(11):
          rc.type = .ma7
          dct = .ma7
        default:
          dct = .ma6
        }
      }
    } else {
      dct = .error
    }
  }
  
  var validCombos: [[[Int]]] {
    switch dct {
    case .dom7:
      return Dom7.validCombos
    case .ma7:
      return Maj7.validCombos
    case .mi7:
      return Min7.validCombos
    case .mi7_b5:
      return Min7_b5.validCombos
    case .dim7:
      return Dim7.validCombos
    case .ma6:
      return Maj6.validCombos
    case .error:
      fatalError("DetailChord couldn't find ResultChord! (validCombos)")
    }
  }
  
  var validCombosIndex: Int {
    if let rc = dRC {
      return qualSwitcher(validCombos: validCombos, degrees: rc.degrees)
    } else {
      fatalError("DetailChord couldn't find ResultChord! (validCombosIndex)")
    }
  }
  
  var tension: [[Int]] {
    switch dct {
    case .dom7:
      return TCArray.dom7.tcArray
    case .ma7:
      return TCArray.ma7.tcArray
    case .mi7:
      return TCArray.mi7.tcArray
    case .mi7_b5:
      return TCArray.mi7_b5.tcArray
    case .dim7:
      return TCArray.dim7.tcArray
    case .ma6:
      return TCArray.ma6.tcArray
    default:
      return [[]]
    }
  }
  
  func qualSwitcher(validCombos: [[[Int]]], degrees: [Int]) -> Int {
    var validCombosIndex = Int()
    for (index, combos) in validCombos.enumerated() {
      if combos.contains(degrees) {
        validCombosIndex = index
        break
      }
    }
    
    return validCombosIndex
  }
}
