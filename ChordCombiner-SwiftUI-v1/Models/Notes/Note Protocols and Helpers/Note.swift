//
//  Note.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

// MARK: - Note Protocol

/// Defines a single note to be used in a scale, mode, chord or pattern
protocol Note {
  var noteNum: NoteNum { get set } // `NoteNum` enum case of the note
  var num: Int { get } // see extension below
  var enharm: Enharmonic { get set } // sets whether note belongs to sharp key or flat key
  var noteName: String { get } // see extension below
  var degName: (name: DegName.Name, short: DegName.Short, long: DegName.Long) { get } // degree of the chord or scale
  var key: KeyName { get } // `KeyName` enum case of the note
  
  func enharmSwapped() -> Note // flips a note enharmonically
}

extension Note {
  /// Returns letter value of the note in raw string form
  var noteName: String {
    return key.name
  }
  /// Returns raw Int value of the note, 0-11
  var num: Int {return noteNum.num}
}

