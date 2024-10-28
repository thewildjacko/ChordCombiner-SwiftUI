//
//  VoicingCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/12/24.
//

import Foundation

struct VoicingCalculator: GettableKeyName {
  var degreeNumbers: [Int]
  var rootNote: Root
  var chordType: ChordType
  var startingOctave: Int
  var keyName: KeyName
  
  var notesByNoteNumber: [NoteNumber: Note]
  var allNotes: [Note] { Array(notesByNoteNumber.values).sorted { $0.degree.size < $1.degree.size } }
  
  var root: Note { rootNote.note }
  var rootKeyNote: RootKeyNote { rootNote.rootKeyNote }
  var baseChord: Chord { Chord(rootKeyNote, chordType.baseChordType) }
  
  var isSlashChord: Bool = false
  var slashChordBassNote: RootKeyNote? = nil
  
  var allChordNotesInKeyFiltered: [Note] {
    var allChordNotesInKey = rootKeyNote.allChordNotesInKey()
    
    for note in allNotes {
      allChordNotesInKey.removeAll(where: { note.noteName == $0.noteName && note.degree != $0.degree })
    }

    return allChordNotesInKey
  }
  
  init(degreeNumbers: [Int], rootNote: Root, chordType: ChordType, startingOctave: Int, keyName: KeyName, notesByNoteNumber: [NoteNumber: Note], isSlashChord: Bool = false, slashChordBassNote: RootKeyNote? = nil) {
    
    self.degreeNumbers = degreeNumbers
    self.rootNote = rootNote
    self.chordType = chordType
    self.startingOctave = startingOctave
    self.keyName = keyName
    self.notesByNoteNumber = notesByNoteNumber
    self.isSlashChord = isSlashChord
    self.slashChordBassNote = slashChordBassNote
  }
}

extension VoicingCalculator: DegreeAndPitchNumberOperator {
  var noteNumbers: [NoteNumber] { degreeNumbers.map { NoteNumber($0) } }
  
  var degreeNumbersRaisedAboveRoot: [Int] {
    degreeNumbers.map { $0.raiseAboveRoot(rootKeyNote: rootKeyNote) }
  }
  
  var raisedPitches: [Int] {
    return degreeNumbers.map { $0.toPitch(startingOctave: startingOctave) }
  }
  
  var pitchesRaisedAboveRoot: [Int] {
    return raisedPitches.map {
      $0.raiseAbove(pitch: raisedRoot, degreeNumbers: nil)
    }
  }
  
  var stackedPitches: [Int] {
    return pitchesRaisedAboveRoot.map {
      $0.raiseAboveDegreesIfAbsent(baseChord.voicingCalculator.pitchesRaisedAboveRoot)
    }
  }
  
  
  var stackedPitchesByNote: [Note: Int] {
    Dictionary(uniqueKeysWithValues: zip(allNotes, stackedPitches))
  }
  
  var stackedPitchesByDegree: [Int] {
    return allNotes.map { $0.toStackedPitch(startingOctave: startingOctave, chordType: chordType) }
  }
}

extension VoicingCalculator: OctaveAndPitch {
  var startingPitch: Int {
    keyName.noteNumber.rawValue.toPitch(startingOctave: startingOctave)
  }
}
