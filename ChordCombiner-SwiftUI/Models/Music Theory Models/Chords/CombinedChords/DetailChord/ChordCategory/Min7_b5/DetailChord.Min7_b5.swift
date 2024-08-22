//
//  Min7_b5.ComboChords.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Min7_b5: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = Min7b5_Locrian_Chord.validCombos + Min7b5_LocrianSharp2_Chord.validCombos
    
    static let tcArray = TCArray.mi7_b5.tcArray
    
    static let tensionTones = TensionTones.mi7_b5.tensionTones
    
    static let validCombos: [[[Int]]] = [Min7b5_Locrian_Chord.validCombos, Min7b5_LocrianSharp2_Chord.validCombos]
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      case 0:
        chord = Min7b5_Locrian_Chord(degSet)
        scale = MajorScale(root, mode: .seven)
      default:
        chord = Min7b5_LocrianSharp2_Chord(degSet)
        scale = MelodicMinorScale(root, mode: .six)
      }
    }
    
    var chord: ComboChord = Min7b5_LocrianSharp2_Chord(zeroSet)
    var scale: ScaleDetails = MelodicMinorScale(.c, mode: .six)
  }
}
