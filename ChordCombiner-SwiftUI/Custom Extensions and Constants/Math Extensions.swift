//
//  Int Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import SwiftUI

/// for comparing chord/scale degreeNumbers
enum ComparisonOutcome {
  case equal
  case greater
  case less
}

// Protocols to add basic math operations to any Swift type.
protocol Summable { static func + (lhs: Self, rhs: Self) -> Self }
protocol Subtractable { static func - (lhs: Self, rhs: Self) -> Self }
protocol Multiplicable { static func * (lhs: Self, rhs: Self) -> Self }
protocol Divisible { static func / (lhs: Self, rhs: Self) -> Self }

protocol Mathable: Summable, Subtractable, Multiplicable, Divisible { }

extension Int: Mathable {
  /// takes mod 12 of an Int
  var mod12: Int { self % 12 }

  /// uses mod12 to determine if two pitch integers are the same note
  func isSameNote(as pitch: Int) -> Bool { self.mod12 == pitch.mod12 }

  /// Takes an Integer value and brings it into the range of an octave **(0-11)**
  var degreeNumberInOctave: Int {
    let mod12 = self.mod12
    return mod12 >= 0 ? mod12 : mod12 + 12
  }

  /// Takes an Integer value and brings it into the range of an octave **(0-11)**
  ///
  /// - Parameter modeLength: The Integer length of the mode, i.e. the number of modes that are available in the scale.
  func degreeNumberInMode(modeLength: Int) -> Int {
    let modulo = self % modeLength
    return modulo >= 0 ? modulo : modulo + modeLength
  }

  /// a function for returning ``ComparisonOutcome`` enum cases from a two Ints
  func compare(to otherInt: Int) -> ComparisonOutcome {
    if self < otherInt {
      return.less
    } else if self > otherInt {
      return .greater
    } else {
      return .equal
    }
  }

  /// adds the supplied `degreeNumber` integer to `self` and returns the converted octave value of the sum.
  func plusDegreeNumber(_ degreeNumber: Int) -> Int { (self + degreeNumber).degreeNumberInOctave }

  /// subtracts the supplied `degreeNumber` integer from `self` and returns the converted octave value of the sum.
  func minusDegreeNumber(_ degreeNumber: Int) -> Int { (self - degreeNumber).degreeNumberInOctave }

  func isIntervalUpOrDown(of degree: Degree, from otherDegreeNumber: Int) -> Bool {
    let firstMinusSecondIsInterval = self.minusDegreeNumber(otherDegreeNumber) == degree.size
    let secondMinusFirstIsInterval = otherDegreeNumber.minusDegreeNumber(self) == degree.size

    return firstMinusSecondIsInterval || secondMinusFirstIsInterval
  }

  /// Calculates whether the interval distance between two `Ints` is a tritone **(6)**
  ///
  /// - Remark: Calculates in either direction.
  func isTritone(from otherDegreeNumber: Int) -> Bool {
    return abs(otherDegreeNumber - self) == 6 ? true : false
  }

  // [0, 2, 4, 6, 7, 10]

  /// Calculates whether the interval distance between two `Ints` is a half step **(1)**
  ///
  /// - Remark: Calculates in either direction.
  func isHalfStep(from otherDegreeNumber: Int) -> Bool { abs(otherDegreeNumber - self) == 1 ? true : false }

  /// Converts an integer to a raised pitch value *(within the piano MIDI pitch range **21-108**)*
  ///
  /// - Parameter startingOctave: Integer value from **0-8**.
  /// - Remark: The lowest pitch on the piano is **A0**
  ///   - **A0** has a ``NoteNumber`` value of **9** & `startingOctave` value of **0**)
  ///   - This function the base pitch of A0 to a raised pitch of **21**.
  func toPitch(startingOctave: Int) -> Int { self + (startingOctave + 1) * 12 }

  func raiseAboveDegreesIfAbsent(_ degreeNumbers: [Int]) -> Int {
    return degreeNumbers.contains(self) ? self : self + 12
  }

  func raiseAboveRoot(rootKeyNote: RootKeyNote) -> Int {
    return self < rootKeyNote.keyName.noteNumber.rawValue ? self + 12 : self
  }

  mutating func raiseAbove(pitch: Int) {
    while self < pitch { self += 12 }
  }

  mutating func lowerBelow(pitch: Int) {
    while self > pitch { self -= 12 }
  }

  func raiseAbove(pitch: Int, degreeNumbers: [Int]?) -> Int {
    if let degreeNumbers = degreeNumbers {
      if self < pitch && !degreeNumbers.contains(self) {
        // self < pitch and not in degreeNumbers
        return self + 12
      } else {
        // self < pitch and is in degreeNumbers
        return self
      }
    } else {
      // no degreeNumbers
      if self >= pitch {
        // self >= pitch
        return self
      } else {
        // pitch > self
        var raisedPitch = self

        while raisedPitch < pitch {
          // \(raisedPitch) < \(pitch)
          raisedPitch += 12
          // raised pitch is \(raisedPitch)
        }

        return raisedPitch
      }
    }
  }

  func indexFromKeys(keys: inout [Key]) -> Array<Key>.Index? {
    if let index = keys.firstIndex(where: { $0.pitch == self }) {
      return index
    } else {
      return nil
    }
  }
}

extension CGFloat {
  func getKeyPosition(keyType: KeyType, position: CGFloat, widthDivisor: CGFloat) -> CGFloat {
    return self * position / widthDivisor
  }
}
