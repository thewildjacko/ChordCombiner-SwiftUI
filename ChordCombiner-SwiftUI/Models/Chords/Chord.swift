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
  var root: Root
  var type: ChordType {
    didSet {
      refresh()
    }
  }
  
  var enharm: Enharmonic
  
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
    return type.name
  }
  
  var name: String {
    root.noteName + chordName
  }
  
  var qualSuffix: QualProtocol {
    get {
      return type
    }
    set {
      type = newValue as! ChordType
      refresh()
    }
  }
  
  var allNotes: [Note] = []
  var noteCount: Int = 0
  
  var degrees: [Int] {
    return allNotes.map {$0.num}
  }
  
  var degSet: Set<Int> {
    return Set(degrees)
  }
  
  var convertedDegrees: [Int] = []
  
  var noteNums: [NoteNum] {
    return degrees.map { NoteNum($0) }
  }
  
  //  MARK: initializers
  init(rootNum: NoteNum = .zero, type: ChordType, enharm: Enharmonic = .flat) {
    self.type = type
    self.enharm = enharm
    self.root = Root(noteNum: rootNum, enharm: enharm)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    
    setNotesAndEnharms()
  }
  
  init(_ rootKey: RootGen, _ type: ChordType) {
    self.type = type
    self.enharm = rootKey.r.enharm
    self.root = Root(rootKey)
    
    self.letter = root.key.letter
    self.accidental = RootAcc(root.key.accidental)
    
    setNotesAndEnharms()
  }
  
  //  MARK: instance methods
  func translated(by offset: Int) -> any ChordProtocol {
    return Chord(rootNum: NoteNum(root.num.plusDeg(offset)), type: type, enharm: enharm)
  }
  
  mutating func setNotesAndEnharms() {
    self.allNotes = type.setNotesAndEnharms(root: root, rootKey: rootKey)
    self.noteCount = allNotes.count
  }
  
  mutating func refresh() {
    self = Chord(RootGen(letter, accidental), type)
  }
  
  func containingChords() -> [Chord] {
    var chordMatches: [Chord] = []
    
    let notesbyNoteNum = self.notesByNoteNum
    
    for chord in ChordFactory.allChords {
      let chordNum = chord.root.noteNum
      
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
    
    return Chord(rootNum: root.noteNum, type: type, enharm: newEnharm)
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
