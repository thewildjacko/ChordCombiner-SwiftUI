//
//  DetailChord.Maj6.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Maj6: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = Maj6_MajorScale.validCombos + Maj6_Lydian.validCombos + Maj6_HalfWholeDim.validCombos + Maj6_Slash_AltP5_Min3_Down.validCombos + Maj6_Slash_HalfWholeDim_Min3_Down.validCombos + Maj6_Slash_Lydian_P5_Down.validCombos
    
    static let tcArray = TCArray.ma6.tcArray
    
    static let tensionTones = TensionTones.ma6.tensionTones
    
    static let validCombos: [[[Int]]] = [Maj6_MajorScale.validCombos, Maj6_Lydian.validCombos, Maj6_HalfWholeDim.validCombos, Maj6_Slash_AltP5_Min3_Down.validCombos, Maj6_Slash_HalfWholeDim_Min3_Down.validCombos,  Maj6_Slash_Lydian_P5_Down.validCombos]
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      case 0:
        chord = Maj6_MajorScale(degSet)
        scale = MajorScale(root, mode: .one)
      case 1:
        chord = Maj6_Lydian(degSet)
        scale = MajorScale(root, mode: .four)
      case 2:
        //                setRCType(.dom7)
        chord = Maj6_HalfWholeDim(degSet)
        scale = DiminishedScale(root, shadowMode: .one)
      case 3:
        getSlashRoot(offset: 3)
        setRCType(.dom7)
        let slashKey = slashRoot!.rootKey
        chord = Maj6_Slash_AltP5_Min3_Down(degSet)
        scale = HarmonicMajorScale(slashKey, mode: .three)
      case 4:
        getSlashRoot(offset: 3)
        setRCType(.dom7)
        let slashKey = slashRoot!.rootKey
        chord = Maj6_Slash_HalfWholeDim_Min3_Down(degSet)
        scale = DiminishedScale(slashKey, shadowMode: .one)
      default:
        getSlashRoot(offset: 7)
        setRCType(.ma7)
        let slashKey = slashRoot!.rootKey
        chord = Maj6_Slash_Lydian_P5_Down(degSet)
        scale = MajorScale(slashKey, mode: .four)
      }
    }
    
    var chord: ComboChord = Maj6_MajorScale(zeroSet)
    var scale: ScaleDetails = MajorScale(.c, mode: .one)
  }
}
