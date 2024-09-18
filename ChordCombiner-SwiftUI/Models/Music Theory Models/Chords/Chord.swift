//
//  Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/29/24.
//

import Foundation

struct Chord: ChordsAndScales, KeySwitch, Identifiable {
  //  MARK: instance properties
  var id = UUID()
  
  var rootNote: Root
  var root: Note
  var rootKeyNote: RootKeyNote { rootNote.rootKeyNote }
  
  var startingOctave: Int = 4
  
  var type: ChordType { didSet { refresh() } }
  var enharmonic: EnharmonicSymbol
  var accidental: RootAccidental { didSet { refresh() } }
  var letter: Letter { didSet { refresh() } }
  
  var commonName: String { root.noteName + type.commonName }
  var preciseName: String { root.noteName + type.rawValue }
  
  var allNotes: [Note] = []
  var noteCount: Int = 0
    
  var convertedDegrees: [Int] = []
  
//  var noteNums: [NoteNum] { degrees.map { NoteNum($0) } }
  
  var noteNums: [NoteNum] { allNotes.map { $0.noteNum } }
  
  var voicingCalculator: VoicingCalculator
  
  //  MARK: initializers
  init(rootNum: NoteNum = .zero, type: ChordType, enharmonic: EnharmonicSymbol = .flat, startingOctave: Int = 4) {
    self.type = type
    self.enharmonic = enharmonic
    self.startingOctave = startingOctave
    
    rootNote = Root(Note(rootNum: rootNum, enharmonic: enharmonic, degree: .root))
    root = rootNote.note
    
    letter = root.keyName.letter
    accidental = RootAccidental(root.keyName.accidental)
    
    voicingCalculator = VoicingCalculator(
      degrees: [],
      rootNote: rootNote,
      type: type,
      startingOctave: startingOctave,
      keyName: root.keyName,
      notesByNoteNum: [:])
    
    setNotesAndNoteCount()
    voicingCalculator.degrees = degrees
    voicingCalculator.notesByNoteNum = notesByNoteNum
  }
  
  init(_ rootKeyNote: RootKeyNote, _ type: ChordType, startingOctave: Int = 4) {
    self.type = type
    self.startingOctave = startingOctave
    
    enharmonic = rootKeyNote.keyName.enharmonic
    
    rootNote = Root(rootKeyNote)
    root = rootNote.note
    
    letter = root.keyName.letter
    accidental = RootAccidental(root.keyName.accidental)
    
    voicingCalculator = VoicingCalculator(
      degrees: [],
      rootNote: rootNote,
      type: type,
      startingOctave: startingOctave,
      keyName: root.keyName,
      notesByNoteNum: [:])
    
    setNotesAndNoteCount()
    voicingCalculator.degrees = degrees
    voicingCalculator.notesByNoteNum = notesByNoteNum
  }
  
  //  MARK: instance methods
  func translated(by offset: Int) -> Chord {
    return Chord(rootNum: NoteNum(root.noteNum.rawValue.plusDeg(offset)), type: type, enharmonic: enharmonic)
  }
  
  mutating func setNotesAndNoteCount() {
    setNotesByDegree()
    self.noteCount = allNotes.count
  }
  
  mutating func setNotesByDegree() {
    self.allNotes = Degree.setNotesByDegrees(rootKeyNote: rootKeyNote, degreeTags: type.degreeTags)
  }
  
  mutating func convertDegrees(to rootNum: NoteNum) {
    convertedDegrees = degrees.map { $0.minusDeg(rootNum.rawValue)}
  }
  
  mutating func convertDegsToOwnRoot() {
    convertedDegrees = degrees.map { $0.minusDeg(root.noteNum.rawValue) }
  }
  
  mutating func refresh() {
    self = Chord(RootKeyNote(letter, accidental), type)
  }
  
  func getBaseChord() -> Chord {
    return Chord(rootKeyNote, type.baseChordType)
  }
  
  func containingChords() -> [Chord] {
    var chordMatches: [Chord] = []
    
    for chord in ChordFactory.allChords where chord.preciseName != preciseName && degrees.includes(chord.degrees){
      if let noteNum = notesByNoteNum.first(where: { $0.key == chord.root.noteNum }) {
        chordMatches.append(Chord(rootNum: chord.root.noteNum, type: chord.type, enharmonic: noteNum.value.keyName.enharmonic))
      }
    }
    
    return chordMatches
  }
  
  // TODO: Fix this MARK
  //  MARK: static methods
  func enharmSwapped() -> Chord {
    var newEnharm: EnharmonicSymbol {
      switch enharmonic {
      case .flat, .sharp:
        return enharmonic == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharmonic == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Chord(rootNum: root.noteNum, type: type, enharmonic: newEnharm)
  }
  
}

extension Chord: Degrees {
  var degrees: [Int] { 
    get { allNotes.map { $0.noteNum.rawValue } }
    set { }
  }

  var degSet: Set<Int> { Set(degrees) }
}

extension Chord: Equatable {
  static func == (lhs: Chord, rhs: Chord) -> Bool {
    return lhs.type == rhs.type && lhs.root == rhs.root
  }
}

extension Chord: Hashable {
  func hash(into hasher: inout Hasher) {
      hasher.combine(type)
      hasher.combine(root)
  }
}
