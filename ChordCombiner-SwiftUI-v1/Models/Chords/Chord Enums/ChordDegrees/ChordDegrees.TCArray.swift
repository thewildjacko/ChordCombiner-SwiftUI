//
//  ChordDegrees.TCArray.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

extension ChordDegrees {
  /// An array of "tension chords," i.e. chords that don't fit in their respective chord categories and should be displayed as slash chords
  enum TCArray {
    case ma7, dom7, mi7, mi7_b5, dim7, ma6
    
    var tcArray: [[Int]] {
      switch self {
      case .ma7: // 1 3 5 8 10
        return [
          [0, 3, 4, 7, 11], // Cmi E♭aug Gaug Baug
          [0, 4, 7, 8, 11], // Caug Eaug A♭aug
          [0, 4, 5, 7, 11], // Csus4, Fsus2
          [0, 1, 4, 5, 7, 8, 11], // D♭ma
          [0, 1, 4, 7, 8, 11], // D♭mi
          [0, 1, 4, 5, 7, 9, 11], // D♭aug Faug Aaug
          [0, 1, 4, 7, 11], // D♭dim
          [0, 1, 4, 6, 7, 8, 11], // D♭sus4, G♭sus2
          [0, 2, 4, 5, 7, 9, 11], // Dmi
          [0, 2, 4, 6, 7, 10, 11], // Daug G♭aug B♭aug
          [0, 2, 4, 5, 7, 8, 11], // Ddim
          [0, 3, 4, 7, 10, 11], // E♭ma
          [0, 3, 4, 6, 7, 10, 11], // E♭mi
          [0, 3, 4, 6, 7, 9, 11], // E♭dim
          [0, 3, 4, 7, 8, 10, 11], // E♭sus4, A♭sus2
          [0, 4, 7, 10, 11], // Edim
          [0, 4, 5, 7, 9, 11], // Fma
          [0, 4, 5, 7, 8, 11], // Fmi, Fdim
          [0, 4, 5, 7, 10, 11], // Fsus4, B♭sus2
          [0, 1, 4, 6, 7, 10, 11], // G♭ma
          [0, 1, 4, 6, 7, 9, 11], // G♭mi
          [0, 1, 4, 6, 7, 11], // G♭sus4, Bsus2
          [0, 2, 4, 7, 10, 11], // Gmi
          [0, 1, 4, 7, 10, 11], // Gdim B♭dim
          [0, 3, 4, 7, 8, 11], // A♭mi
          [0, 2, 4, 7, 8, 11], // A♭dim
          [0, 1, 3, 4, 7, 8, 11], // A♭sus4, D♭sus2
          [0, 1, 4, 7, 9, 11], // Ama
          [0, 3, 4, 7, 9, 11], // Adim
          [0, 2, 4, 5, 7, 10, 11], // B♭ma
          [0, 1, 4, 5, 7, 10, 11], // B♭mi
          [0, 3, 4, 5, 7, 10, 11], // B♭sus4, E♭sus2
          [0, 3, 4, 6, 7, 11], // Bma
          [0, 2, 4, 5, 7, 11] // Bdim
          /* FIX: these seem impossible
           //          [0, 4, 7, 8, 9, 11],
           //          [0, 4, 5, 7, 8, 9, 11],
           //          [0, 3, 4, 7, 8, 9, 11],
           //          [0, 2, 4, 7, 8, 9, 11],
           */
        ]
      case .dom7: // 5 11
        return [
          [0, 4, 5, 7, 10], // Csus4, Fsus2, Fsus4, B♭sus2
          [0, 1, 4, 5, 7, 8, 10], // D♭ma
          [0, 1, 4, 5, 7, 9, 10], // D♭aug Faug Aaug
          [0, 2, 4, 5, 7, 8, 10], // Ddim
          [0, 2, 4, 5, 7, 9, 10], // Dmi
          [0, 3, 4, 7, 10, 11], // E♭aug Gaug Baug
          [0, 4, 7, 8, 10, 11], // Ema
          [0, 4, 7, 10, 11], // Emi
          [0, 4, 7, 9, 10, 11], // Esus4 Asus2
          [0, 4, 5, 7, 9, 10], // Fma
          [0, 4, 5, 7, 8, 10], // Fmi
          [0, 4, 5, 7, 8, 10, 11], // Fdim
          [0, 1, 4, 6, 7, 8, 10], // G♭mi
          [0, 1, 4, 6, 7, 10, 11], // G♭sus4, Bsus2
          [0, 2, 4, 7, 10, 11], // Gma
          [0, 3, 4, 7, 8, 10, 11], // A♭mi
          [0, 2, 4, 7, 8, 10, 11], // A♭dim
          [0, 2, 4, 5, 7, 10], // B♭ma
          [0, 1, 4, 5, 7, 10], // B♭mi
          [0, 3, 4, 5, 7, 10], // B♭sus4, E♭sus2
          [0, 3, 4, 6, 7, 10, 11], // Bma
          [0, 2, 4, 6, 7, 10, 11], // Bmi
          [0, 2, 4, 5, 7, 10, 11], // Bdim
          [0, 4, 6, 7, 10, 11] // Bsus4, Esus2
          /* FIX: these seem impossible
           //          [0, 1, 4, 5, 7, 8, 11],
           //          [0, 3, 4, 5, 7, 9, 10],
           //          [0, 3, 4, 7, 8, 9, 10],
           //          [0, 4, 7, 8, 9, 11],
           //          [0, 3, 4, 5, 7, 10, 11],
           //          [0, 1, 4, 6, 7, 11],
           //          [0, 1, 3, 4, 7, 8, 11],
           //          [0, 4, 5, 7, 10, 11],
           //          [0, 1, 4, 7, 10, 11],
           //          [0, 1, 4, 5, 7, 10, 11],
           //          [0, 4, 7, 8, 11],
           //          [0, 4, 5, 7, 9, 11],
           //          [0, 3, 4, 7, 8, 11],
           //          [0, 1, 4, 7, 9, 11],
           //          [0, 3, 4, 6, 7, 11],
           //          [0, 3, 4, 7, 11],
           //          [0, 1, 4, 7, 8, 11],
           //          [0, 2, 4, 5, 7, 9, 11],
           //          [0, 4, 5, 7, 8, 11],
           //          [0, 1, 4, 6, 7, 9, 11],
           //          [0, 1, 4, 5, 7, 9, 11],
           //          [0, 1, 4, 7, 11],
           //          [0, 2, 4, 5, 7, 8, 11],
           //          [0, 3, 4, 6, 7, 9, 11],
           //          [0, 2, 4, 7, 8, 11],
           //          [0, 3, 4, 7, 9, 11],
           //          [0, 2, 4, 5, 7, 11],
           //          [0, 4, 5, 7, 11],
           //          [0, 1, 4, 6, 7, 8, 11],
           //          [0, 4, 5, 7, 8, 9, 11],
           //          [0, 3, 4, 7, 8, 9, 11],
           //          [0, 2, 4, 7, 8, 9, 11],
           */
        ]
      case .mi7: // 4 6 11
        return [
          [0, 3, 4, 7, 10],
          [0, 2, 3, 6, 7, 9, 10],
          [0, 3, 4, 7, 8, 10, 11],
          [0, 1, 3, 6, 7, 10],
          [0, 2, 3, 7, 10, 11],
          [0, 1, 3, 4, 7, 9, 10],
          [0, 3, 6, 7, 10, 11],
          [0, 1, 3, 4, 7, 8, 10],
          [0, 3, 6, 7, 10],
          [0, 3, 4, 7, 10, 11],
          [0, 1, 3, 6, 7, 9, 10],
          [0, 3, 7, 8, 10, 11],
          [0, 3, 4, 7, 9, 10],
          [0, 2, 3, 6, 7, 10, 11],
          [0, 3, 4, 7, 8, 10],
          [0, 1, 3, 7, 9, 10],
          [0, 2, 3, 6, 7, 10],
          [0, 3, 7, 10, 11],
          [0, 1, 3, 4, 7, 10],
          [0, 3, 6, 7, 9, 10],
          [0, 3, 5, 7, 8, 10, 11],
          [0, 2, 3, 7, 8, 10, 11],
          [0, 2, 3, 5, 7, 10, 11],
          [0, 1, 3, 6, 7, 8, 10],
          [0, 3, 4, 7, 9, 10, 11],
          [0, 1, 3, 6, 7, 10, 11],
          [0, 2, 3, 4, 7, 9, 10],
          [0, 3, 4, 6, 7, 10, 11]
        ]
      case .mi7_b5: // 4 7 11
        return [
          [0, 3, 4, 6, 7, 10],
          [0, 2, 3, 6, 9, 10],
          [0, 3, 6, 7, 10],
          [0, 3, 4, 6, 8, 10, 11],
          [0, 3, 5, 6, 9, 10],
          [0, 2, 3, 6, 7, 10, 11],
          [0, 1, 3, 4, 6, 9, 10],
          [0, 3, 6, 10, 11],
          [0, 1, 3, 4, 6, 8, 10],
          [0, 2, 3, 5, 6, 9, 10],
          [0, 3, 4, 6, 7, 10, 11],
          [0, 1, 3, 6, 9, 10],
          [0, 2, 3, 6, 7, 10],
          [0, 3, 6, 8, 10, 11],
          [0, 3, 4, 6, 9, 10],
          [0, 2, 3, 6, 10, 11],
          [0, 3, 4, 6, 8, 10],
          [0, 1, 3, 5, 6, 9, 10],
          [0, 3, 6, 7, 10, 11],
          [0, 1, 3, 4, 6, 7, 10],
          [0, 3, 6, 9, 10],
          [0, 3, 5, 6, 8, 10, 11],
          [0, 1, 3, 6, 7, 10],
          [0, 2, 3, 6, 8, 10, 11],
          [0, 1, 3, 4, 6, 10],
          [0, 2, 3, 5, 6, 10, 11],
          [0, 3, 5, 6, 7, 10],
          [0, 2, 3, 6, 7, 9, 10],
          [0, 3, 4, 6, 9, 10, 11],
          [0, 1, 3, 6, 10, 11],
          [0, 2, 3, 4, 6, 9, 10],
          [0, 3, 4, 6, 10, 11]
        ]
      case .dim7: // 1 4 7 10
        return [
          [0, 3, 4, 6, 7, 9],
          [0, 3, 6, 7, 9, 10],
          [0, 3, 4, 6, 8, 9, 11],
          [0, 1, 3, 6, 9, 10],
          [0, 2, 3, 6, 7, 9, 11],
          [0, 1, 3, 4, 6, 9],
          [0, 2, 3, 5, 6, 9, 10],
          [0, 3, 6, 7, 9],
          [0, 1, 3, 4, 6, 8, 9],
          [0, 3, 6, 9, 10],
          [0, 3, 4, 6, 7, 9, 11],
          [0, 2, 3, 6, 7, 9, 10],
          [0, 3, 4, 6, 9],
          [0, 1, 3, 5, 6, 9, 10],
          [0, 3, 4, 6, 8, 9],
          [0, 2, 3, 6, 9, 10],
          [0, 3, 6, 7, 9, 11],
          [0, 1, 3, 4, 6, 7, 9],
          [0, 3, 4, 6, 7, 9, 10],
          [0, 1, 3, 6, 7, 9, 10],
          [0, 1, 3, 4, 6, 9, 10],
          [0, 3, 5, 6, 7, 9],
          [0, 2, 3, 6, 7, 9],
          [0, 3, 6, 8, 9, 10],
          [0, 3, 4, 6, 9, 11],
          [0, 3, 5, 6, 9, 10],
          [0, 2, 3, 4, 6, 9],
          [0, 1, 3, 6, 9, 11]
        ]
      case .ma6: // 5 8
        return [
          [0, 4, 7, 8, 9],
          [0, 1, 4, 5, 7, 8, 9],
          [0, 1, 4, 7, 8, 9],
          [0, 1, 4, 6, 7, 8, 9],
          [0, 1, 3, 4, 7, 8, 9],
          [0, 2, 4, 5, 7, 8, 9],
          [0, 4, 5, 7, 8, 9],
          [0, 3, 4, 7, 8, 9]
        ]
      }
    }
    
  }
}
