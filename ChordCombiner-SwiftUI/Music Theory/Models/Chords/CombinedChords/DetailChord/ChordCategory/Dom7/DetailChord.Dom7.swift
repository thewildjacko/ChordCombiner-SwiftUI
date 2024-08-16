//
//  DetailChord.Dom7.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension DetailChord {
  struct Dom7: ChordCategory {
    var dRC: ResultChord?
    var detailChord: DetailChord?
    
    var slashRoot: Root?
    var verdict: Verdict = .goodToGo
    
    init(resultChord: ResultChord?, detailChord: DetailChord?) {
      self.dRC = resultChord
      self.detailChord = detailChord
      tensionOrGoodToGo()
    }
    
    static let matches = Mixolydian.validCombos + LydianDom.validCombos + HalfWholeDim.validCombos + AltP5.validCombos + MelodicMinor_Chord.validCombos + HexatonicSh9Sh11_Chord.validCombos
    
    static let validCombos: [[[Int]]] = [Mixolydian.validCombos, LydianDom.validCombos, HalfWholeDim.validCombos, AltP5.validCombos, MelodicMinor_Chord.validCombos, HexatonicSh9Sh11_Chord.validCombos]
    
    static let tcArray: [[Int]] = TCArray.dom7.tcArray
    
    static let tensionTones: Set<Int> = TensionTones.dom7.tensionTones
    
    mutating func getComboChordAndScale(root: RootGen, degSet: Set<Int>, validCombosIndex: Int) {
      switch validCombosIndex {
      case 0:
        chord = Mixolydian(degSet)
        scale = MajorScale(root, mode: .five)
      case 1:
        chord = LydianDom(degSet)
        scale = MelodicMinorScale(root, mode: .four)
      case 2:
        chord = HalfWholeDim(degSet)
        scale = DiminishedScale(root, shadowMode: .one)
      case 3:
        chord = AltP5(degSet)
        scale = HarmonicMajorScale(root, mode: .three)
      case 4:
        chord = MelodicMinor_Chord(degSet)
        scale = MelodicMinorScale(root, mode: .five)
      default:
        chord = HexatonicSh9Sh11_Chord(degSet)
        scale = HexatonicSharp9Sharp11Scale(root, shadowMode: .one)
      }
    }
    
    var chord: ComboChord = Mixolydian(zeroSet)
    var scale: ScaleDetails = MajorScale(.c)
  }
}

