//
//  Int Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation
import SwiftUI

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
  
  func plusDeg(_ deg: Int) -> Int { (self + deg).degreeInOctave }
  
  func minusDeg(_ deg: Int) -> Int { (self - deg).degreeInOctave }
  
  func isTritone(from otherDeg: Int) -> Bool {
//    return otherDeg - self == 6 ? true : false // why is this not abs?
    return abs(otherDeg - self) == 6 ? true : false
  }
  
  func isHalfStep(from otherDeg: Int) -> Bool { abs(otherDeg - self) == 1 ? true : false }
  
  func toPitch(startingOctave: Int) -> Int { self + (startingOctave + 1) * 12 }
  
  func raiseAboveDegreesIfAbsent(_ degs: [Int]) -> Int {
    // print("raiseAboveDegreesIfAbsent: degs = \(degs)")
    return degs.contains(self) ? self : self + 12
  }
  
  func raiseAbove(pitch: Int, degs: [Int]?) -> Int {
    // print("raise above: \(self) above \(pitch)")
    if let degs = degs {
      // print("degs: \(degs)")
      if self < pitch && !degs.contains(self) {
        // print("self < pitch and not in degs")
        return self + 12
      } else {
        // print("self < pitch and is in degs")
        return self
      }
    } else {
      // print("no degs")
      if self >= pitch {
        // print("self >= pitch")
        return self
      } else {
        // print("pitch > self")
        var raisedPitch = self
        
        while raisedPitch < pitch {
          // print("\(raisedPitch) < \(pitch)")
          raisedPitch += 12
          // print("raised pitch is \(raisedPitch)")
        }
        
        return raisedPitch
      }
    }
  }
}

/// for comparing chord/scale degrees
enum ComparisonOutcome {
  case equal
  case greater
  case less
}

extension Array where Element == Int {
  func toggleHighlightIfSelected<T: ShapeStyle>(keys: inout [Key], color: T) {
    for deg in self {
      if let index = keys.firstIndex(where: { $0.pitch == deg }) {
        keys[index].toggleHighlight(color: color)
      }
    }
  }
}

extension CGFloat {
  func getKeyPosition(position: CGFloat, widthMod: CGFloat) -> CGFloat {
    return self * position / widthMod
  }
}
