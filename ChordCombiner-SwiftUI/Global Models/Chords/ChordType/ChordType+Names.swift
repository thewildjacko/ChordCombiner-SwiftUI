//
//  ChordType+Names.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

extension ChordType {
  var preciseName: String { self == .ma ? "ma" : self.rawValue }

  // MARK: commonName
  var commonName: String {
    switch self {
    case .ma13omit9:
      return "ma13"
    case .ma13b5omit9:
      return "ma13(♭5)"
    case .ma13sh11omit9:
      return "ma13(♯11)"
    case .ma13sh5omit9:
      return "ma13(♯5)"
    case .ma13sh5sh11omit9:
      return "ma13(♯5♯11)"
    case .ma13sus4omit9:
      return "ma13sus4"
    case .dominant13omit9:
      return "13"
    case .dominant7altb9sh9sh11, .dominant7altb9sh9b5, .dominant7altb9sh5sh11,
        .dominant7altb9sh9sh5sh11, .dominant7altsh9sh5sh11:
      return "7alt"
    case .dominant13sh11omit9:
      return "13(♯11)"
    case .dominant13b5omit9:
      return "13(♭5)"
    case .dominant13sus4omit9:
      return "13sus4"
    case .mi11omit9:
      return "mi11"
    case .mi13omit9, .mi13omit11:
      return "mi13"
    case .mi11b13omit9:
      return "mi11(♭13)"
    case .mi13b5omit9, .mi13b5omit11:
      return "mi13(♭5)"
    case .dim11b13omit9:
      return "˚11(♭13)"
    case .dim11addMa7omit9:
      return "˚11(add∆7)"
    case .dim11b13addMa7omit9:
      return "˚11(♭13 add∆7)"
    case .dimMa11b13omit9:
      return "˚ma11(♭13)"
    case .miMa11omit9:
      return "mi(∆11)"
    case .miMa13omit9:
      return "mi(∆13)"
    default:
      return rawValue
    }
  }
}
