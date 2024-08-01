//
//  Chord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 7/29/24.
//

import Foundation

struct Chord: ChordProtocol {
  //  MARK: instance properties
  var root: Root
  var type: ChordType
  var enharm: Enharmonic
  var accidental: RootAcc
  var letter: Letter
  
  
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
    switch type {
      // MARK: Triads
    case .ma:
      self.allNotes = [root, Maj3(rootKey), P5(rootKey)]
    case .mi:
      self.allNotes = [root, Min3(rootKey), P5(rootKey)]
    case .aug:
      self.allNotes = [root, Maj3(rootKey), Sh_5(rootKey)]
    case .dim:
      self.allNotes = [root, Min3(rootKey), Dim5(rootKey)]
    case .sus4:
      self.allNotes = [root, P4(rootKey), P5(rootKey)]
    case .sus2:
      self.allNotes = [root, Maj2(rootKey), P5(rootKey)]
      
      // MARK: Major Lydian 7th Chords
    case .ma7:
      self.allNotes = [root, Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9:
      self.allNotes = [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13:
      self.allNotes = [root, Maj2(rootKey), Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_no9:
      self.allNotes = [root, Maj3(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma7_sh11:
      self.allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma9_sh11:
      self.allNotes = [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj7(rootKey)]
    case .ma13_sh11:
      self.allNotes = [root, Maj2(rootKey), Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
    case .ma13_sh11_no9:
      self.allNotes = [root, Maj3(rootKey), Sh_4(rootKey), P5(rootKey), Maj6(rootKey), Maj7(rootKey)]
      
      // MARK: Minor Dorian 7th Chords
    case .mi7:
      self.allNotes = [root, Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi9:
      self.allNotes = [root, Maj2(rootKey), Min3(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11:
      self.allNotes = [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi11_no9:
      self.allNotes = [root, Min3(rootKey), P4(rootKey), P5(rootKey), Min7(rootKey)]
    case .mi13:
      self.allNotes = [root, Maj2(rootKey), Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no9:
      self.allNotes = [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no11:
      self.allNotes = [root, Min3(rootKey), P4(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    case .mi13_no9_no11:
      self.allNotes = [root, Min3(rootKey), P5(rootKey), Maj6(rootKey), Min7(rootKey)]
    }
    self.noteCount = allNotes.count
  }
  
  func containingChords() -> [Chord] {
    var chordMatches: [Chord] = []
    
    let notesbyNoteNum = self.notesByNoteNum
    
    for chord in Chord.allChords {
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

  //  MARK: static properties
  static var allChords: [Chord] {
    var chords: [Chord] = []
    let roots: [RootGen] = [.c, .dB, .d, .eB, .e, .f, .gB, .g, .aB, .a, .bB, .b]


    for root in roots {
      for type in ChordType.allCases {
        chords.append(Chord(root, type))
      }
    }
    
    return chords
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
  
  static func chordsIn(_ testChord: Chord) -> [Chord] {
    return testChord.containingChords()
  }

  
}

extension Chord: Equatable {
  static func == (lhs: Chord, rhs: Chord) -> Bool {
    return lhs.type == rhs.type && lhs.root == rhs.root
  }
}
