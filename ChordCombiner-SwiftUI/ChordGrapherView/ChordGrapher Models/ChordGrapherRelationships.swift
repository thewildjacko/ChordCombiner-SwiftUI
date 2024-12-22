//
//  ChordGrapherRelationships.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/6/24.
//

import Foundation

struct ChordGrapherRelationships {
  // MARK: stored properties
  var parentChord: ChordGrapherParentChord = ChordGrapherParentChord(
    chord: .initial)

  /// returns an appropriate dot-notation string for the initial children, based on `parentChord.elementsContained`
  private var nextLevelDownString: String = ""

  /// a dot-notation string describing the relationship between the parent chord and initial children
  var parentToFirstChildLevelString: String = ""

  /// a 2-dimensional array of groups of 4-note simple chords that contain each triad of the parent chord
  private var fourNoteChordsByTriad: [[Chord]] = [[]]

  /// a  dot-notation string array of parent-child relationships between 4-note chord groups and their containing triads
  ///
  /// - Remark:parent-child strings are sorted in ascending degree order of ``parentChord``'s notes.
  /// - SeeAlso: ``fourNoteSimpleChordsByTriad``
  var fourNoteChordsToTriadStrings: [String] = []

  /// a 2-dimensional array of 4-note chord groups that don't contain triads
  private var fourNoteChordsWithoutTriadsByNote: [[Chord]] = [[]]

  /// a 2-dimensional array of groups of triads that contain each note of the parent chord
  private var triadsByNote: [[Chord]] = [[]]

  /// a  dot-notation string array describing parent-child relationships between chord groups and their containing notes
  ///
  /// - Remark:parent-child strings are sorted in ascending degree order of ``parentChord``'s notes.
  ///
  /// - SeeAlso: ``triadsByNote``
  var noteToChordsStrings: [String] = []

  /// an array of rankSame strings for 4-note chords, triads and notes, including only those items that aren't empty.
  var rankSameStrings: [String] = []

  // MARK: Computed properties
  var rowElementsMax: Int {
    let rowCounts = [parentChord.fourNoteChords.count, parentChord.triads.count, parentChord.notes.count]

    return rowCounts.max() ?? 0
  }

  // MARK: Initializer
  init(parentChord: ChordGrapherParentChord) {
    self.parentChord = parentChord

    nextLevelDownString = getNextLevelDownString()
    parentToFirstChildLevelString = parentChord.dotName.pointingTo(nextLevelDownString)

    fourNoteChordsByTriad = getFourNoteChordsByTriad()
    fourNoteChordsToTriadStrings = getFourNoteChordsToTriadStrings()

    fourNoteChordsWithoutTriadsByNote = parentChord.notes
      .chordsContainNote(chords: parentChord.fourNoteChordsWithoutTriads)

    triadsByNote = parentChord.notes.chordsContainNote(chords: parentChord.triads)

    noteToChordsStrings = getNoteToChordsStrings()

    rankSameStrings = getRankSameStrings()
  }

  // MARK: private instance methods
  /// build ``nextLevelDownString`` based on ``parentChord.elementsContained``
  private func getNextLevelDownString() -> String {
    var nextLevelDownString: String {
      switch parentChord.elementsContained {
      case .all:
        return parentChord.fourNoteChords.toDotNotationString(bracketed: false)
      case .triadsAndNotes:
        return parentChord.triads.toDotNotationString(bracketed: false)
      case .notes:
        return parentChord.dotNotes
      }
    }

    return nextLevelDownString.bracketedAndPadded()
  }

  /// build ``fourNoteChordsByTriad``
  private func getFourNoteChordsByTriad() -> [[Chord]] {
    return parentChord.triads.map { triad in
      parentChord.fourNoteChords.filter { fourNoteChord in
        fourNoteChord.contains(triad)
      }
    }
  }

  /// build ``fourNoteChordsToTriadStrings`` array
  private func getFourNoteChordsToTriadStrings() -> [String] {
    var fourNoteChordsToTriadStrings: [String] = []

    for index in (0..<parentChord.triads.count) where !fourNoteChordsByTriad[index].isEmpty {
      let fourNoteChordsString = fourNoteChordsByTriad[index].toDotNotationString(bracketed: true)

      let triadString = parentChord.triads[index].getDotNotationName()

      fourNoteChordsToTriadStrings.append(fourNoteChordsString.pointingTo(triadString))
    }

    return fourNoteChordsToTriadStrings
  }

  /// build the ``noteToChordsStrings``
  private func getNoteToChordsStrings() -> [String] {
    var noteToChordsStrings: [String] = []

//    print("FNCWT: \(parentChord.fourNoteChordsWithoutTriads.preciseNames())")

    for index in (0..<parentChord.notes.count) {
      var chords = fourNoteChordsWithoutTriadsByNote[index] + triadsByNote[index]
//      print("FNC: \(chords.preciseNames())")
//      print("triads: \(triadsByNote[index].preciseNames())")
//      print("chord: \(chords.preciseNames())")

      if !parentChord.notesWithoutChords.isEmpty &&
          parentChord.notesWithoutChords.contains(parentChord.notes[index]) &&
          !chords.contains(parentChord.chord) {
        chords.append(parentChord.chord)
      }

      let chordsString = chords.map { $0.getDotNotationName() }
        .joined(separator: " ")
        .bracketedAndPadded()

      let noteString = parentChord.notes[index].getDotNotationName()

//      print(chordsString.pointingTo(noteString))
      noteToChordsStrings.append(chordsString.pointingTo(noteString))
    }

    return noteToChordsStrings
  }

  /// returns a dot-notation string of equal rankings for items on the same level
  ///
  /// - Parameter items: an array of `Strings`, such as chord or note names, to map to dot notation.
  ///
  /// - Remark: Common items include 4-note chords, triads or notes.
  private func rankSame(items: [String]) -> String {
    let rankSame = String.GrapherConstants.rankSame.rawValue
    let dotItems = items.map { $0.toDotNotation() }.joined(separator: " ")

    return (rankSame + dotItems).bracketedAndPadded()
  }

  /// build the ``rankSameStrings``
  private func getRankSameStrings() -> [String] {
    let notes: [String] = parentChord.notes.noteNames()
    let fourNoteChords: [String]? = !parentChord.fourNoteChords.isEmpty ?
    parentChord.fourNoteChords.preciseNames() : nil
    let triads: [String]? = !parentChord.triads.isEmpty ?
    parentChord.triads.preciseNames() : nil

    let rankSameOptionalStrings: [[String]?] = [notes, fourNoteChords, triads]
    let rankSameStringsCompacted = rankSameOptionalStrings.compacted()

    var rankSameStrings: [String] = []

    for items in rankSameStringsCompacted {
      rankSameStrings.append(rankSame(items: items))
    }

    return rankSameStrings
  }

  // MARK: instance methods
  func appendRelationshipStrings(toItems: inout [String], stringsToAppend: [String]) {
    for string in stringsToAppend { toItems.append(string) }
  }
}
