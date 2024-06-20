//
//  ComboChord.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ComboChord {
  static var validCombos: [[Int]] { get }
  
  var quality: Suffix { get }
  var uprStrNotes: [Int] { get }
}

protocol ComboChordInit {
  init(_ degSet: Set<Int>)
}
