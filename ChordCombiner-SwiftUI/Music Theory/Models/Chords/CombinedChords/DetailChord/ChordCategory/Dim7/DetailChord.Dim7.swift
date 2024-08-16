//
//  DetailChord.Dim7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Dim7: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = WholeHalfDim.validCombos + Sev_Alt_P5Down.validCombos
    
    static let tcArray = TCArray.dim7.tcArray
    
    static let tensionTones = TensionTones.dim7.tensionTones
    
    static let validCombos: [[[Int]]] = [WholeHalfDim.validCombos, Sev_Alt_P5Down.validCombos]
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      case 0:
        chord = WholeHalfDim(degSet)
        scale = DiminishedScale(root, shadowMode: .two)
      default:
        getSlashRoot(offset: 7)
        setRCType(.dom7)
        let slashKey = slashRoot!.rootKey
        chord = Sev_Alt_P5Down(degSet)
        scale = HarmonicMajorScale(slashKey, mode: .three)
      }
    }
    
    var chord: ComboChord = WholeHalfDim(zeroSet)
    var scale: ScaleDetails = DiminishedScale(.c, shadowMode: .two)
  }
}
