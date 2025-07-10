//
//  Scale.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import Foundation

struct Scale: ChordsAndScales, KeySwitch, Identifiable {
  static let initial = Scale(.c, .major)

  // MARK: instance properties
  var id = UUID()

  var rootNote: Root = Root(.c) { didSet { setRootProperties() } }
  var root: Note = Note(.c)
  var rootKeyNote: RootKeyNote = .c
  var keyName: KeyName = .c

  var startingOctave: Int = 4

  var scaleType: ScaleType = .major { didSet { refresh() } }
  var enharmonic: EnharmonicSymbol = .flat
  var accidental: RootAccidental = .natural { didSet { refresh() } }
  var letter: Letter = .c { didSet { refresh() } }

  var notes: [Note] = [] { didSet { setNoteProperties() } }

  var rootKeyNotes: [RootKeyNote] = []
  var noteNumbers: [NoteNumber] = []

  var details: ScaleDetails = ScaleDetails.initial

  var scalePitchCalculator: ScalePitchCalculator = ScalePitchCalculator.initialPC

  var keySwitcher: KeySwitcher { return KeySwitcher(enharmonic: enharmonic) }

  // MARK: initializers
  init(rootNumber: NoteNumber = .zero,
       scaleType: ScaleType,
       enharmonic: EnharmonicSymbol = .flat,
       startingOctave: Int = 4) {
    self.scaleType = scaleType
    self.enharmonic = enharmonic
    self.startingOctave = startingOctave

    rootNote = Root(Note(rootNumber: rootNumber, enharmonic: enharmonic, degree: .root))
    setRootProperties()

    letter = root.keyName.letter
    accidental = RootAccidental(root.keyName.accidental)

    self.notes = Degree.setNotesByDegrees(rootKeyNote: rootKeyNote, degreeTags: scaleType.degreeTags)

    setNoteProperties()

    scalePitchCalculator = ScalePitchCalculator(
      notes: notes,
      rootNote: rootNote,
      scaleType: scaleType,
      startingOctave: startingOctave,
      keyName: root.keyName)

    details = ScaleDetails(
      root: root,
      scaleType: scaleType,
      notes: notes)
  }

  init(_ rootKeyNote: RootKeyNote,
       _ scaleType: ScaleType,
       startingOctave: Int = 4) {
    self.init(
      rootNumber: rootKeyNote.keyName.noteNumber,
      scaleType: scaleType,
      enharmonic: rootKeyNote.keyName.enharmonic,
      startingOctave: startingOctave
    )
  }

  // MARK: initializer helper methods
  mutating func setRootProperties() {
    root = rootNote.note
    rootKeyNote = rootNote.rootKeyNote
    keyName = rootKeyNote.keyName
  }

  mutating func setNoteProperties() {
    rootKeyNotes = notes.rootKeyNotes()
    noteNumbers = notes.noteNumbers()
  }

  // MARK: instance methods
  mutating func refresh() {
    self = Scale(RootKeyNote(letter, accidental), scaleType)
  }

  func contains(_ note: Note) -> Bool {
    notes.contains(note)
  }

  func contains(_ chord: Chord) -> Bool {
    return scalePitchCalculator.degreeNumbers.includes(chord.voicingCalculator.degreeNumbers) &&
    chord.voicingCalculator.degreeNumbers.count <= scalePitchCalculator.degreeNumbers.count
  }

  func getEquivalentScales() -> [Scale] {
    var scales: [Scale] = []

    for scale in ScaleFactory.allScales
    where scale.scalePitchCalculator.degreeNumberSet ==
    scalePitchCalculator.degreeNumberSet && scale.details.name != details.name {
      if scale.notes.first(where: { $0.hasSameName(as: root)
      }) != nil {
        scales.append(scale)
      }
    }

    return scales.sorted { $0.root.noteNumber.rawValue < $1.root.noteNumber.rawValue }
  }

  func getModes() async -> [Scale] {
    let task = Task {
      let scalefamily = ScaleFactory.allScales.filter({
        $0.scaleType.parentScaleType == scaleType.parentScaleType
      })

      let keyAgnosticScales = scalefamily.filter({
        $0.scalePitchCalculator.degreeNumberSet.contains(root.noteNumber.rawValue)
      })

      let batch = 5
      let scalesInBatch = keyAgnosticScales.elementsInBatch(batch: Double(batch))
      var tempScales: [[Scale]] = Array(repeating: [], count: batch)

      var lock = os_unfair_lock()

      DispatchQueue.concurrentPerform(iterations: batch) { iteration in
        let startPoint = keyAgnosticScales.calculateStartPoint(
          batch: batch,
          iteration: iteration,
          elementsInBatch: scalesInBatch)
        let endPoint = keyAgnosticScales.calculateEndPoint(startPoint: startPoint, elementsInBatch: scalesInBatch)
        let subScaleArray = Array(keyAgnosticScales[startPoint..<endPoint])

        var scaleMatches: [Scale] = []

        for scale in subScaleArray where scale.scalePitchCalculator.degreeNumberSet ==
        scalePitchCalculator.degreeNumberSet {
          print(scale.details.name)
          if let note = scale.notes.first(where: { $0.noteNumber == root.noteNumber }) {
            if note.hasSameName(as: root) {
              scaleMatches.append(scale)
            } else {
              if let scaleNote = notes.first(where: { $0.noteNumber == scale.root.noteNumber}),
                 scaleNote.keyName.accidental == .dblFlat || scaleNote.keyName.accidental == .dblSharp {
                scaleMatches.append(scale)

              }
            }
          }
        }

        os_unfair_lock_lock(&lock)
        tempScales[iteration] = scaleMatches
        os_unfair_lock_unlock(&lock)
      }

      let finalScaleMatches = tempScales.flatMap { $0 }

      return finalScaleMatches.sorted { $0.scaleType.modeNumber < $1.scaleType.modeNumber }
    }

    return await task.value
  }
  /*

   func getBaseChord() -> Chord { return Chord(rootKeyNote, ChordType(chordType.baseChordType)) }

   func getExtensions() -> [Note] { notes.filter { !getBaseChord().notes.contains($0) } }

   func getExtensionDegreeNames() -> DegreeNameGroup {
   DegreeNameGroup(
   names: getExtensions().map { $0.degreeName.name },
   numeric: getExtensions().map { $0.degreeName.numeric },
   long: getExtensions().map { $0.degreeName.long }
   )
   }

   func variantCombinesWith<T: ChordAndScaleProperty>(chordFrom chordProperty: T, chordToMatch: Chord) -> Bool {
   var newChord: Chord = Chord.initial

   switch chordProperty {
   case is Letter:
   if let letter = chordProperty as? Letter {
   newChord = Chord(RootKeyNote(letter, accidental), chordType)
   }
   case is RootAccidental:
   if let accidental = chordProperty as? RootAccidental {
   newChord = Chord(RootKeyNote(letter, accidental), chordType)
   }
   case is ChordType:
   if let chordType = chordProperty as? ChordType {
   newChord = Chord(RootKeyNote(letter, accidental), chordType)
   }
   default:
   return false
   }

   let result = ChordCombiner.combineChords(firstChord: chordToMatch, secondChord: newChord)

   return result != nil ? true : false
   }
   }

   //  func containingChords() -> [Chord] {
   //    guard !self.isTriad() else { return [] }
   //
   //    let keyAgnosticChords = ChordFactory.allSimpleChords
   //    let batch = 10
   //    let chordsInBatch = keyAgnosticChords.elementsInBatch(batch: Double(batch))
   //    var tempChords: [[Chord]] = Array(repeating: [], count: batch)
   //
   //    var lock = os_unfair_lock()
   //
   //    DispatchQueue.concurrentPerform(iterations: batch) { iteration in
   //      let startPoint = keyAgnosticChords.calculateStartPoint(
   //        batch: batch,
   //        iteration: iteration,
   //        elementsInBatch: chordsInBatch)
   //      let endPoint = keyAgnosticChords.calculateEndPoint(startPoint: startPoint, elementsInBatch: chordsInBatch)
   //      let subChordArray = Array(keyAgnosticChords[startPoint..<endPoint])
   //
   //      var chordMatches: [Chord] = []
   //
   //      for chord in subChordArray where self.contains(chord) {
   //        if let noteNumber = voicingCalculator.notesByNoteNumber.first(where: {
   //          $0.key == chord.root.noteNumber }) {
   //          chordMatches.append(
   //            Chord(
   //              rootNumber: chord.root.noteNumber,
   //              chordType: chord.chordType,
   //              enharmonic: noteNumber.value.keyName.enharmonic))
   //        }
   //      }
   //
   //      os_unfair_lock_lock(&lock)
   //      tempChords[iteration] = chordMatches
   //      os_unfair_lock_unlock(&lock)
   //    }
   //
   //    let finalChordMatches = tempChords.flatMap { $0 }
   //
   //    return finalChordMatches
   //  }
   */
}

extension Scale: Equatable {
  static func == (lhs: Scale, rhs: Scale) -> Bool {
    return lhs.scaleType == rhs.scaleType && lhs.root == rhs.root
  }
}

/*
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
 /// All ``RootKeyNotes`` from `self` and parameter `secondChord` sorted in order of their combined ``notes``
 /// - Filters out duplicate values and `lowerRootKeyNote`.
 func combinedRootKeyNotes(with secondChord: Chord) -> [RootKeyNote] {
 /// All ``RootKeyNotes`` in `self` minus  own `rootKeyNote`
 let firstChordRemainingRootKeyNotes = rootKeyNotes.filter { $0 != rootKeyNote }

 /// All ``RootKeyNotes`` in `secondChord` not present in `self`
 let secondChordUniqueRootKeyNotes = secondChord.rootKeyNotes.filter { !rootKeyNotes.contains($0) }

 /// All ``RootKeyNotes`` from both chords, sorted in order of their combined ``notes``
 /// - Filters out duplicate values and own `rootKeyNote`.
 return firstChordRemainingRootKeyNotes + secondChordUniqueRootKeyNotes
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
 return details.preciseName.toDotNotation()
 }
 }

 /// ChordType Identity tests
 extension Chord {
 func rootMatchesNoteNumber(_ note: Note) -> Bool {
 root.noteNumber == note.noteNumber
 }

 func hasDifferentCommonName() -> Bool { details.preciseName != details.commonName }
 }

 */
