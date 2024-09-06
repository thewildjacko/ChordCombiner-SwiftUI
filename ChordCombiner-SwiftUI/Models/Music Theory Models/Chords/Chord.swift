//
//  Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/29/24.
//

import Foundation

struct Chord: ChordProtocol, Identifiable {
  var id = UUID()
  
  //  MARK: instance properties
  var root: RootNote
  var type: ChordType {
    didSet {
      refresh()
    }
  }
  
  var enharm: Enharmonic
  
  var startingOctave: Int = 4
  
  var accidental: RootAcc {
    didSet {
      refresh()
    }
  }
  
  var letter: Letter {
    didSet {
      refresh()
    }
  }
  
  var chordName: String {
    return type.rawValue
  }
  
  var name: String {
    root.note.noteName + chordName
  }
  
  var allNotes: [NoteProtocol] = []
  var allNotesByDegree: [NoteProtocol] = []
  var noteCount: Int = 0
  
  var degrees: [Int] {
    return allNotes.map {$0.basePitchNum}
  }
  
  var degSet: Set<Int> {
    return Set(degrees)
  }
  
  var convertedDegrees: [Int] = []
  
  var stackedPitches: [Int] {
    return pitchesRaisedAboveRoot.map {
       $0.raiseAboveDegreesIfAbsent(getBaseChord()
        .pitchesRaisedAboveRoot)
    }
  }
  
  var noteNums: [NoteNum] {
    return degrees.map { NoteNum($0) }
  }
  
  //  MARK: initializers
  init(rootNum: NoteNum = .zero, type: ChordType, enharm: Enharmonic = .flat, startingOctave: Int = 4) {
    self.type = type
    self.enharm = enharm
    self.startingOctave = startingOctave
    self.root = RootNote(Note(rootNum: rootNum, enharm: enharm, degree: .root))
    
    self.letter = root.note.key.letter
    self.accidental = RootAcc(root.note.key.accidental)
    
    setNotesAndNoteCount()
  }
  
  init(_ rootKey: RootNote, _ type: ChordType, startingOctave: Int = 4) {
    self.type = type
    self.enharm = rootKey.note.key.enharm
    self.startingOctave = startingOctave
    self.root = rootKey
    
    self.letter = root.note.key.letter
    self.accidental = RootAcc(root.note.key.accidental)
    
    setNotesAndNoteCount()
  }
  
  //  MARK: instance methods
  func translated(by offset: Int) -> any ChordProtocol {
    return Chord(rootNum: NoteNum(root.note.basePitchNum.plusDeg(offset)), type: type, enharm: enharm)
  }
  
  mutating func setNotesAndNoteCount() {
//    self.allNotes = type.setNotes(root: root, rootKey: rootKey)
//    self.allNotes = type.setNotesByDegree(root: root, rootKey: rootKey)
    self.allNotesByDegree = type.setNotesByDegree(root: RootNote(Note(root.note.key)))
    self.noteCount = allNotes.count
    
//    print("Initializing: \(self.name)")
  }
  
  mutating func setNotesByDegree() {
    self.allNotesByDegree = type.setNotesByDegree(root: RootNote(Note(root.note.key)))
    //    self.allNotesByDegree = type.setNotesByDegree(root: root, rootKey: rootKey)
//    print("notesByDegree: ", allNotesByDegree)
  }
  
  mutating func refresh() {
    self = Chord(RootGen(letter, accidental), type)
  }
  
  func getBaseChord() -> Chord {
    return Chord(root, type.baseChordType)
  }
  
  func containingChords() -> [Chord] {
    var chordMatches: [Chord] = []
    
    let notesbyNoteNum = self.notesByNoteNum
    
    for chord in ChordFactory.allChords {
      let chordNum = chord.root.note.noteNum
      
      if self.degrees.includes(chord.degrees) && chord.name != self.name {
        if let noteNum = notesbyNoteNum.first(where: { $0.key == chordNum }) {
          let enharmByKey = noteNum.value.enharmByKey
          chordMatches.append(Chord(rootNum: chordNum, type: chord.type, enharm: enharmByKey))
        }
      }
    }
    
    return chordMatches
  }
  
  //  MARK: static methods
  func enharmSwapped() -> ChordProtocol {
    var newEnharm: Enharmonic {
      switch enharm {
      case .flat, .sharp:
        return enharm == .flat ? .sharp : .flat
      case .blackKeyFlats, .blackKeySharps:
        return enharm == .blackKeyFlats ? .blackKeySharps : .blackKeyFlats
      }
    }
    
    return Chord(rootNum: root.note.noteNum, type: type, enharm: newEnharm)
  }
  
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
