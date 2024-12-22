//
//  String Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/3/24.
//

import Foundation

extension String {
  enum DotAccidentals: String {
    case sharp = "#"
    case doubleSharp = "x"
    case flat = "b"
    case doubleFlat = "bb"
  }

  enum GrapherConstants: String {
    case leftAngle = "<"
    case rightAngle = ">"
    case arrow = " -> "
    case openBracket = "{ "
    case closedBracket = " }"
    case doubleQuote = "\""
    case escapedDoubleQuote = "\\\""
    case rankSame = "rank=same; "
    case digraph = "digraph "
    case diminished = "&#186;"
    case augmented = "&#43;"
    case major = "ma"
    case sixnine = "6/9"
  }

  func quoted() -> String {
    return GrapherConstants.doubleQuote.rawValue + self + GrapherConstants.doubleQuote.rawValue
  }

  func angled() -> String {
    return GrapherConstants.leftAngle.rawValue + self + GrapherConstants.rightAngle.rawValue
  }

  func escapedQuoted() -> String {
    return GrapherConstants.escapedDoubleQuote.rawValue + self + GrapherConstants.escapedDoubleQuote.rawValue
  }

  mutating func escapeQuotes() -> String {
    return self.replacing(/"/, with: "\\\"")
  }

  func bracketedAndPadded() -> String {
    return GrapherConstants.openBracket.rawValue + self + GrapherConstants.closedBracket.rawValue
  }

  func pointingTo(_ otherString: String) -> String {
    return self + GrapherConstants.arrow.rawValue + otherString
  }

  func toDotNotation() -> String {
    var result = self
    result = result.replacing(/♯/, with: "\(String.DotAccidentals.sharp.rawValue)")
    result = result.replacing(/𝄪/, with: "\(String.DotAccidentals.doubleSharp.rawValue)")
    result = result.replacing(/♭/, with: "\(String.DotAccidentals.flat.rawValue)")
    result = result.replacing(/𝄫/, with: "\(String.DotAccidentals.doubleFlat.rawValue)")
    result = result.replacing(/˚/, with: "\(String.GrapherConstants.diminished.rawValue)")
    result = result.replacing(/\+/, with: "\(String.GrapherConstants.augmented.rawValue)")
    result = result.replacing(/∆/, with: "\(String.GrapherConstants.major.rawValue)")
    result = result.replacing(/⁶\/₉/, with: "\(String.GrapherConstants.sixnine.rawValue)")

//    return result.angled()
    return result.quoted()
//    return result.escapedQuoted()
  }

}
