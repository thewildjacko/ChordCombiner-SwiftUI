//
//  ArrayExtensions+Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/26/25.
//

import Foundation

extension Array where Element == Note {
  func isEnharmonicEquivalent(to otherNoteArray: [Note]) -> Bool {
    if self.count != otherNoteArray.count {
      return false
    } else {
      let firstArray = self.sorted(by: { $0.noteNumber.rawValue < $1.noteNumber.rawValue })
      let secondArray = otherNoteArray.sorted(by: { $0.noteNumber.rawValue < $1.noteNumber.rawValue })

      var isEnharmonicEquivalent = true

      for index in (0...firstArray.count - 1)
      where !firstArray[index].isEnharmonicEquivalent(to: secondArray[index]) {
        isEnharmonicEquivalent = false
      }

      return isEnharmonicEquivalent
    }
  }

  /// Takes a ``[Note]`` array and ``[Chord]`` array, returns an array of ``[Chord]`` arrays containing each ``Note``
  func chordsContainNote(chords: [Chord]) -> [[Chord]] {
    return self.map { note in
      chords.filterInChordsContainingNote(note)
    }
  }

  func toPitchesByNote(pitches: [Int]) -> PitchesByNote {
    return Dictionary(uniqueKeysWithValues: zip(self, pitches))
  }

  func toNotesByNoteNumber() -> NotesByNoteNumber {
    return Dictionary(uniqueKeysWithValues: zip(self.map { $0.noteNumber }, self))
  }

  func rootKeyNotes() -> [RootKeyNote] { self.map { RootKeyNote($0.keyName) } }
  func noteNames() -> [String] { self.map { $0.noteName } }
  func noteNumbers() -> [NoteNumber] { self.map { $0.noteNumber } }
  func degreeNumbers() -> [Int] { self.map { $0.noteNumber.rawValue } }
  func toDegrees() -> [Degree] { self.map { $0.degree } }
  func toDegreeNameGroup() -> DegreeNameGroup {
    DegreeNameGroup(
      names: self.map { $0.degreeName.name },
      numeric: self.map { $0.degreeName.numeric },
      long: self.map { $0.degreeName.long }
    )
  }

  func containsNoteWithSameName(as note: Note) -> Bool {
    self.first(where: { $0.hasSameName(as: note) }) != nil
  }
}
