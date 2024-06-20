//
//  DetailChord.Maj7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Maj7: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = Maj_Lydian_Chord.validCombos
    
    static let validCombos: [[[Int]]] = [Maj_Lydian_Chord.validCombos]
    
    static let tcArray = TCArray.ma7.tcArray
    
    static let tensionTones = TensionTones.ma7.tensionTones
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      default:
        chord = Maj_Lydian_Chord(degSet)
        scale = MajorScale(root, mode: .four)
      }
    }
    
    var chord: ComboChord = Maj_Lydian_Chord(zeroSet)
    var scale: ScaleDetails = MajorScale(.c)
  }
}
