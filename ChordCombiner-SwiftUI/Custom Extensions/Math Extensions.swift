//
//  Int Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

protocol Summable { static func +(lhs: Self, rhs: Self) -> Self }
protocol Subtractable { static func -(lhs: Self, rhs: Self) -> Self }
protocol Multiplicable { static func *(lhs: Self, rhs: Self) -> Self }
protocol Divisible { static func /(lhs: Self, rhs: Self) -> Self }

protocol Mathable: Summable, Subtractable, Multiplicable, Divisible { }

extension Int: Mathable {
  var degreeInOctave: Int {
    let mod12 = self % 12
    return mod12 >= 0 ? mod12 : mod12 + 12
  }
  
  func degreeInMode(modeLength: Int) -> Int {
    let mod = self % modeLength
    return mod >= 0 ? mod : mod + modeLength
  }
  
  func compare(to otherInt: Int) -> ComparisonOutcome {
    if self < otherInt {
      return.less
    } else if self > otherInt {
      return .greater
    } else {
      return .equal
    }
  }
  
  func plusDeg(_ deg: Int) -> Int {
    return (self + deg).degreeInOctave
  }
  
  func minusDeg(_ deg: Int) -> Int {
    return (self - deg).degreeInOctave
  }
  
  func isTritone(from otherDeg: Int) -> Bool {
    return otherDeg - self == 6 ? true : false
  }
  
  func isHalfStep(from otherDeg: Int) -> Bool {
    return abs(otherDeg - self) == 1 ? true : false
  }
}

/// for comparing chord/scale degrees
enum ComparisonOutcome {
  case equal
  case greater
  case less
}
