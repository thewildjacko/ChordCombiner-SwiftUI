//
//  InvertibleChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/26/24.
//

import Foundation

protocol InvertibleChord {
  var inversion: ChordInversion { get set }
  
  mutating func invertTo(inversion: FNCInversion)
  mutating func invert(times: Int, allNotes: inout [Note], noteCount: Int)
  
  mutating func getAndSetInversion()
}

extension InvertibleChord {
  var inversionName: (short: String, long: String) {
    return inversion.name
  }
  
  mutating func invert(times: Int, allNotes: inout [Note], noteCount: Int) {
    switch times {
    case let t where t > 0:
      for _ in 1...times {
        if let _ = allNotes.first {
          allNotes.insert(allNotes.removeFirst(), at: noteCount - 1)
        }
      }
    case let t where t < 0:
      for _ in 1...abs(times) {
        if let _ = allNotes.last {
          allNotes.insert(allNotes.removeLast(), at: 0)
        }
      }
    default:
      ()
    }
    getAndSetInversion()
  }
}
