//
//  DetailChord.Min7.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Min7: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = Min_Dorian_Chord.validCombos + Min_Slash_LydianMaj3rdDown.validCombos + Min_Slash_DorianP5Down.validCombos + Min_Slash_LydianDom_Maj6thDown.validCombos + Min_Phrygian.validCombos
    
    static let tcArray = TCArray.mi7.tcArray
    
    static let tensionTones = TensionTones.mi7.tensionTones
    
    static let validCombos: [[[Int]]] = [Min_Dorian_Chord.validCombos, Min_Slash_LydianMaj3rdDown.validCombos, Min_Slash_DorianP5Down.validCombos, Min_Slash_LydianDom_Maj6thDown.validCombos, Min_Phrygian.validCombos]
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      case 0:
        chord = Min_Dorian_Chord(degSet)
        scale = MajorScale(root, mode: .two)
      case 1:
        getSlashRoot(offset: 4)
        setRCType(.ma7)
        let slashKey = slashRoot!.rootKey
        chord = Min_Slash_LydianMaj3rdDown(degSet)
        scale = MajorScale(slashKey, mode: .four)
      case 2:
        getSlashRoot(offset: 7)
        let slashKey = slashRoot!.rootKey
        chord = Min_Slash_DorianP5Down(degSet)
        scale = MajorScale(slashKey, mode: .two)
      case 3:
        getSlashRoot(offset: 9)
        setRCType(.dom7)
        let slashKey = slashRoot!.rootKey
        chord = Min_Slash_LydianDom_Maj6thDown(degSet)
        scale = MelodicMinorScale(slashKey, mode: .four)
      default:
        chord = Min_Phrygian(degSet)
        scale = MajorScale(root, mode: .three)
      }
    }
    
    var chord: ComboChord = Min_Dorian_Chord(zeroSet)
    var scale: ScaleDetails = MajorScale(.c, mode: .two)
  }
}
