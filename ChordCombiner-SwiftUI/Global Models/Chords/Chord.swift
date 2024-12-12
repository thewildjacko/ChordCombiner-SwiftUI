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
  
  var rootNote: Root = Root(.c) { didSet { setRootProperties() } }
  var root: Note = Note(.c)
  var rootKeyNote: RootKeyNote = .c
  var keyName: KeyName = .c
  
  var startingOctave: Int = 4
  
  var chordType: ChordType = .ma { didSet { refresh() } }
  var enharmonic: EnharmonicSymbol = .flat
  var accidental: RootAccidental = .natural { didSet { refresh() } }
  var letter: Letter = .c { didSet { refresh() } }
  
  var commonName: String { root.noteName + chordType.commonName }  
  var preciseName: String { root.noteName + chordType.preciseName }
  
  var notes: [Note] = [] { didSet { setNoteProperties() } }
  var rootKeyNotes: [RootKeyNote] = []
  var noteNumbers: [NoteNumber] = []
  var notesByNoteNumber: NotesByNoteNumber = [:]

  // DegreeNumbers conformance
  var degreeNumbers: [Int] = [] { didSet { degreeNumberSet = Set(degreeNumbers) } }
  var degreeNumberSet: Set<Int> = []
  
  var noteNames: [String] = []
  
  var degreeNames: DegreeNames = (names: [], numeric: [], long: [])
  
  var voicingCalculator: VoicingCalculator = VoicingCalculator(
    degreeNumbers: [],
    rootNote: Root(.c),
    chordType: .ma,
    startingOctave: 4,
    keyName: .c,
    notesByNoteNumber: [:],
    isSlashChord: false,
    slashChordBassNote: .c
  )
  
  var keySwitcher: KeySwitcher {
    return KeySwitcher(enharmonic: enharmonic)
  }
  
  //  MARK: initializers
  init(rootNumber: NoteNumber = .zero, chordType: ChordType, enharmonic: EnharmonicSymbol = .flat, startingOctave: Int = 4, isSlashChord: Bool = false, slashChordBassNote: RootKeyNote? = nil) {
    self.chordType = chordType
    self.enharmonic = enharmonic
    self.startingOctave = startingOctave
    
    rootNote = Root(Note(rootNumber: rootNumber, enharmonic: enharmonic, degree: .root))
    setRootProperties()
    
    letter = root.keyName.letter
    accidental = RootAccidental(root.keyName.accidental)
    
    self.notes = Degree.setNotesByDegrees(rootKeyNote: rootKeyNote, degreeTags: chordType.degreeTags)
    
    setNoteProperties()

    voicingCalculator = VoicingCalculator(
      degreeNumbers: degreeNumbers,
      rootNote: rootNote,
      chordType: chordType,
      startingOctave: startingOctave,
      keyName: root.keyName,
      notesByNoteNumber: notesByNoteNumber,
      isSlashChord: isSlashChord,
      slashChordBassNote: slashChordBassNote
    )
  }
  
  init(_ rootKeyNote: RootKeyNote, _ chordType: ChordType, startingOctave: Int = 4, isSlashChord: Bool = false, slashChordBassNote: RootKeyNote? = nil) {
    self.init(
      rootNumber: rootKeyNote.keyName.noteNumber,
      chordType: chordType,
      enharmonic: rootKeyNote.keyName.enharmonic,
      startingOctave: startingOctave,
      isSlashChord: isSlashChord,
      slashChordBassNote: slashChordBassNote
    )    
  }
  
  //  MARK: initializer helper methods
  mutating func setRootProperties() {
    root = rootNote.note
    rootKeyNote = rootNote.rootKeyNote
    keyName = rootKeyNote.keyName
  }
  
  mutating func setNoteProperties() {
    setNotesByNoteNumber(notes.keyed { $0.noteNumber })
    rootKeyNotes = notes.map { RootKeyNote($0.keyName) }
    noteNames = notes.map { $0.noteName }
    noteNumbers = notes.map { $0.noteNumber }
    degreeNumbers = notes.map { $0.noteNumber.rawValue }
    degreeNumberSet = Set(degreeNumbers)
    
    degreeNames = (
      names: notes.map { $0.degreeName.name },
      numeric: notes.map { $0.degreeName.numeric },
      long: notes.map { $0.degreeName.long }
    )
  }
  
  //  MARK: instance methods
  mutating func refresh() {
    self = Chord(RootKeyNote(letter, accidental), chordType)
  }
  
  func getBaseChord() -> Chord {
    return Chord(rootKeyNote, chordType.baseChordType)
  }
  
  func variantCombinesWith<T: ChordAndScaleProperty>(chordFrom chordProperty: T, chordToMatch: Chord) -> Bool {
    var newChord: Chord
//    print("chordProperty: \(chordProperty.rawValue)")
    switch chordProperty {
    case is Letter:
      newChord = Chord(RootKeyNote(chordProperty as! Letter, accidental), chordType)
    case is RootAccidental:
      newChord = Chord(RootKeyNote(letter, chordProperty as! RootAccidental), chordType)
    case is ChordType:
      newChord = Chord(RootKeyNote(letter, accidental), chordProperty as! ChordType)
    default:
      print("Incompatible chord property!")
      return false
    }
    
    let result = ChordCombiner.combineChords(firstChord: chordToMatch, secondChord: newChord)
    
    if chordProperty is Letter {
//      if let result = result { print((chordProperty as! Letter).rawValue, result.preciseName) }
    }
        
//    print("newChord \(newChord.preciseName) and chordToMatch \(chordToMatch.preciseName) combine to create \(result?.preciseName ?? "no chord")")
    
    return result != nil ? true : false
  }
  
  func contains(_ chord: Chord) -> Bool {
    chord.preciseName != preciseName && degreeNumbers.includes(chord.degreeNumbers) && chord.degreeNumbers.count < degreeNumbers.count
  }
  
  func contains(_ note: Note) -> Bool {
    notes.contains(note)
  }
  
  func containingChords(callingMethod: String = #function) -> [Chord] {
    print("In `\(#function)`, called by `\(callingMethod)`")
    
    var chordMatches: [Chord] = []
    
    let clock = ContinuousClock()
    let elapsed = clock.measure {
      for chord in ChordFactory.allSimpleChords where self.contains(chord) {
        if let noteNumber = notesByNoteNumber.first(where: { $0.key == chord.root.noteNumber }) {
          chordMatches.append(Chord(rootNumber: chord.root.noteNumber, chordType: chord.chordType, enharmonic: noteNumber.value.keyName.enharmonic))
        }
      }
    }
    
    print("It took \(elapsed) to find all chords contained in \(preciseName).")
    
    return chordMatches
  }
}

extension Chord {
  init?(firstChord: Chord, secondChord: Chord) {
    if let chord = ChordCombiner.combineChords(firstChord: firstChord, secondChord: secondChord) {
      self = chord
    } else {
      return nil
    }
  }
}

extension Chord {
  /// All ``RootKeyNotes`` from `self` and parameter `secondChord` sorted in order of the two chords' combined ``notes`` arrays, filtering out duplicate values and `lowerRootKeyNote`.
  func combinedRootKeyNotes(with secondChord: Chord) -> [RootKeyNote] {
    /// All ``RootKeyNotes`` in `self` minus  own `rootKeyNote`
    let firstChordRemainingRootKeyNotes = rootKeyNotes.filter { $0 != rootKeyNote }
    
    /// All ``RootKeyNotes`` in `secondChord` not present in `self`
    let secondChordUniqueRootKeyNotes = secondChord.rootKeyNotes.filter { !rootKeyNotes.contains($0) }

    /// All ``RootKeyNotes`` sorted in order of both chords' combined ``notes`` arrays, filtering out duplicate values and own `rootKeyNote`.
    return firstChordRemainingRootKeyNotes + secondChordUniqueRootKeyNotes
  }
  
  func getEquivalentChords() -> [Chord] {
    EquivalentChordFinder.checkForEquivalentChords(
      degreeNumbers: degreeNumbers,
      rootKeyNotes: rootKeyNotes.filter { $0 != rootKeyNote }
    )
  }
}

extension Chord {
  enum DetailType {
    case commonName,
         preciseName,
         noteNames,
         degreeNames
  }
  
  func displayDetails(detailType: DetailType) -> String {
    switch detailType {
    case .commonName:
      return commonName
    case .preciseName:
      return preciseName
    case .noteNames:
      return noteNames.joined(separator: ", ")
    case .degreeNames:
      return degreeNames.numeric.joined(separator: ", ")
    }
  }
}

extension Chord: Equatable {
  static func == (lhs: Chord, rhs: Chord) -> Bool {
    return lhs.chordType == rhs.chordType && lhs.root == rhs.root
  }
}

extension Chord: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(chordType)
    hasher.combine(root)
  }
}

extension Chord {
  func getDotNotationName() -> String {
    return preciseName.toDotNotation()
  }
}

/// ChordType Identity tests
extension Chord {
  func isTriad() -> Bool { chordType.isTriad }
  func isFourNoteSimpleChord() -> Bool { chordType.isFourNoteSimpleChord }
  func isExtended() -> Bool { chordType.isExtendedChord }
}
