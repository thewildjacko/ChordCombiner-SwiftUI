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
  var degreeNumberInOctave: Int {
    let mod12 = self % 12
    return mod12 >= 0 ? mod12 : mod12 + 12
  }
  
  func degreeNumberInMode(modeLength: Int) -> Int {
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
  
  func plusDegreeNumber(_ degreeNumber: Int) -> Int { (self + degreeNumber).degreeNumberInOctave }
  
  func minusDegreeNumber(_ degreeNumber: Int) -> Int { (self - degreeNumber).degreeNumberInOctave }
  
  func isTritone(from otherDegreeNumber: Int) -> Bool {
    return abs(otherDegreeNumber - self) == 6 ? true : false
  }
  
  func isHalfStep(from otherDegreeNumber: Int) -> Bool { abs(otherDegreeNumber - self) == 1 ? true : false }
  
  func toPitch(startingOctave: Int) -> Int { self + (startingOctave + 1) * 12 }
  
  func raiseAboveDegreesIfAbsent(_ degreeNumbers: [Int]) -> Int {
    return degreeNumbers.contains(self) ? self : self + 12
  }
  
  func raiseAbove(pitch: Int, degreeNumbers: [Int]?) -> Int {
    if let degreeNumbers = degreeNumbers {
      if self < pitch && !degreeNumbers.contains(self) {
        // print("self < pitch and not in degreeNumbers")
        return self + 12
      } else {
        // print("self < pitch and is in degreeNumbers")
        return self
      }
    } else {
      // print("no degreeNumbers")
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

/// for comparing chord/scale degreeNumbers
enum ComparisonOutcome {
  case equal
  case greater
  case less
}

extension CGFloat {
  func getKeyPosition(position: CGFloat, widthMod: CGFloat) -> CGFloat {
    return self * position / widthMod
  }
}
