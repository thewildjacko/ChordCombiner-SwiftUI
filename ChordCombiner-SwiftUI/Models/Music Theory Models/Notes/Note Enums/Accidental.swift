//
//  Accidental.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/18/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol SettableAccidental {
  var accidental: RootAccidental { get set }
}

/// the accidental of a note, key, or root, e.g. flat, sharp, natural, double flat or double sharp.
enum Accidental: String, CaseIterable, Identifiable, Codable {
  var id: Self { return self }
  
  case flat = "♭", natural = "♮", sharp = "♯", dblFlat = "𝄫", dblSharp = "𝄪"
  
  /// accidental enum limited to flats, naturals and sharps, specifically for initializing `Roots`
  enum RootAccidental: String, ChordAndScaleProperty {
    var id: Self { return self }
    
    case flat = "♭", natural = "♮", sharp = "♯"
    
    /// get `RootAccidental` from pickerView row or other row-based UI
    init(_ accidentalNum: Int) {
      switch accidentalNum {
      case 0:
        self = .flat
      case 1:
        self = .natural
      case 2:
        self = .sharp
      default:
        self = .natural
      }
    }
    /// get `RootAccidental` from another key's accidental
    init(_ accidental: Accidental) {
      switch accidental {
      case .flat:
        self = .flat
      case .natural:
        self = .natural
      case .sharp:
        self = .sharp
      default:
        self = .natural
      }
    }
    
  }
}
