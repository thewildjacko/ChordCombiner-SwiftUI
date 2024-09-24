//
//  VoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/12/24.
//

import Foundation

struct VoicingCalculator: GettableKeyName {
  var degrees: [Int]
  var rootNote: Root
  var type: ChordType
  var startingOctave: Int
  var keyName: KeyName
  var notesByNoteNum: [NoteNum: Note]
  
  var root: Note { rootNote.note }
  var rootKeyNote: RootKeyNote { rootNote.rootKeyNote }
  var baseChord: Chord { Chord(rootKeyNote, type.baseChordType) }
  
  var isSlashChord: Bool = false
  var slashChordBassNote: Root? = nil
  
  var allChordNotesInKeyFiltered: [Note] {
    let allNotes = notesByNoteNum.values
    var allChordNotesInKey = rootKeyNote.allChordNotesInKey()
    
    for note in allNotes {
      allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
    }

    return allChordNotesInKey
  }
  
  init(degrees: [Int], rootNote: Root, type: ChordType, startingOctave: Int, keyName: KeyName, notesByNoteNum: [NoteNum: Note], isSlashChord: Bool = false, slashChordBassNote: Root? = nil) {
    self.degrees = degrees
    self.rootNote = rootNote
    self.type = type
    self.startingOctave = startingOctave
    self.keyName = keyName
    self.notesByNoteNum = notesByNoteNum
    self.isSlashChord = isSlashChord
    self.slashChordBassNote = slashChordBassNote
  }
}

extension VoicingCalculator: DegreeAndPitchOperator {
  var noteNums: [NoteNum] { degrees.map { NoteNum($0) } }

  var stackedPitches: [Int] {
    return pitchesRaisedAboveRoot.map {
      $0.raiseAboveDegreesIfAbsent(baseChord.voicingCalculator.pitchesRaisedAboveRoot)
    }
  }
}

extension VoicingCalculator: OctaveAndPitch {
  var startingPitch: Int {
    keyName.noteNum.rawValue.toPitch(startingOctave: startingOctave)
  }
}
