//
//  ChordType.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/31/24.
//

import Foundation

enum ChordType: String, CaseIterable, QualProtocol, Identifiable, Comparable {
  static func < (lhs: ChordType, rhs: ChordType) -> Bool {
    return lhs.name < rhs.name
  }
  
  var id: Self {
    return self
  }
  
  // MARK: Triads
  case ma
  case mi
  case aug
  case dim
  case sus4
  case sus2
  // MARK: Major Lydian 7th Chords
  case ma7
  case ma9
  case ma13
  case ma13_no9
  case ma7_sh11
  case ma9_sh11
  case ma13_sh11
  case ma13_sh11_no9
  // MARK: Minor Dorian 7th Chords
  case mi7
  case mi9
  case mi11
  case mi11_no9
  case mi13
  case mi13_no9
  case mi13_no11
  case mi13_no9_no11
  
  var degs: [Int] {
    switch self {
      // MARK: Triads
    case .ma:
      [0, 4, 7]
    case .mi:
      [0, 3, 7]
    case .aug:
      [0, 4, 8]
    case .dim:
      [0, 3, 6]
    case .sus4:
      [0, 5, 7]
    case .sus2:
      [0, 2, 7]
      // MARK: Major Lydian 7th Chords
    case .ma7:
      [0, 4, 7, 11]
    case .ma9:
      [0, 2, 4, 7, 11]
    case .ma13:
      [0, 2, 4, 7, 9, 11]
    case .ma13_no9:
      [0, 4, 7, 9, 11]
    case .ma7_sh11:
      [0, 4, 6, 7, 11]
    case .ma9_sh11:
      [0, 2, 4, 6, 7, 11]
    case .ma13_sh11:
      [0, 2, 4, 6, 7, 9, 11]
    case .ma13_sh11_no9:
      [0, 4, 6, 7, 9, 11]
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      [0, 3, 7, 10]
    case .mi9:
      [0, 2, 3, 7, 10]
    case .mi11:
      [0, 2, 3, 5, 7, 10]
    case .mi11_no9:
      [0, 3, 5, 7, 10]
    case .mi13:
      [0, 2, 3, 5, 7, 9, 10]
    case .mi13_no9:
      [0, 3, 5, 7, 9, 10]
    case .mi13_no11:
      [0, 2, 3, 7, 9, 10]
    case .mi13_no9_no11:
      [0, 3, 7, 9, 10]
    }
  }
  
  var quality: Suffix {
    switch self {
      // MARK: Triads
    case .ma:
      return .ma
    case .mi:
      return .mi
    case .aug:
      return .aug
    case .dim:
      return .dim
    case .sus4:
      return .sus4
    case .sus2:
      return .sus2
      // MARK: Major Lydian 7th Chords
    case .ma7:
      return .ma7
    case .ma9:
      return .ma9
    case .ma13:
      return .ma13
    case .ma7_sh11:
      return .ma7_sh11
    case .ma9_sh11:
      return .ma9_sh11
    case .ma13_sh11:
      return .ma13_sh11
    case .ma13_no9:
      return .ma13_no9
    case .ma13_sh11_no9:
      return .ma13_sh11_no9
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      return .mi7
    case .mi9:
      return .mi9
    case .mi11:
      return .mi11
    case .mi13:
      return .mi13
    case .mi11_no9:
      return .mi11_no9
    case .mi13_no9:
      return .mi13_no9
    case .mi13_no11:
      return .mi13_no11
    case .mi13_no9_no11:
      return .mi13_no9_no11
    }
  }
  
  var name: String {
    switch self {
      // MARK: standard cases
      // triads (except diminished)
    case .ma,
        .mi,
        .aug,
        .sus4,
        .sus2,
      // major-lydian 7ths
        .ma7,
        .ma9,
        .ma13,
        .ma7_sh11,
        .ma9_sh11,
        .ma13_sh11,
      // minor-dorian 7ths
        .mi7,
        .mi9,
        .mi11,
        .mi13:
      return qualStr
      // MARK: special or redundant cases
    case .dim:
      return "˚"
    case .ma13_no9:
      return "ma13"
    case .ma13_sh11_no9:
      return "ma13(♯11)"
    case .mi11_no9:
      return "mi11"
    case .mi13_no9, .mi13_no11, .mi13_no9_no11:
      return "mi13"
    }
  }
  
  func setNotesAndEnharms(root: Root, rootKey: RootGen) -> [Note] {
    switch self {
      // MARK: Triads
    case .ma:
      return [root, Maj3(rootKey), P5(rootKey)]
    case .mi:
      return [root, Min3(rootKey), P5(rootKey)]
    case .aug:
      return [root, Maj3(rootKey), Sh_5(rootKey)]
    case .dim:
      return [root, Min3(rootKey), Dim5(rootKey)]
    case .sus4:
      return [root, P4(rootKey), P5(rootKey)]
    case .sus2:
      return [root, Maj2(rootKey), P5(rootKey)]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:
      return [root, Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9:
      return [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13:
      return [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_no9:
      return [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma7_sh11:
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9_sh11:
      return [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13_sh11:
      return [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_sh11_no9:
      return [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      return [root, Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi9:
      return [root, Maj2(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11:
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_no9:
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi13:
      return [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no9:
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no11:
      return [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no9_no11:
      return [root, Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    }
  }
  
  static var qualities: [String] {
    return ChordType.allCases.map {$0.rawValue}
  }
}

