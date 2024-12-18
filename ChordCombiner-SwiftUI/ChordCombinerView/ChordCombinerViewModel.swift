//
//  ChordCombinerViewModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI
import Observation

@Observable
final class ChordCombinerViewModel: ObservableObject {
  // MARK: Instance properties
  var lowerChordProperties: ChordProperties = ChordProperties.initial
  var upperChordProperties: ChordProperties = ChordProperties.initial

  var lowerKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard
  var upperKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard
  var combinedKeyboard: Keyboard = Keyboard.initialDualChordKeyboard

  var lowerChord: Chord? {
    guard let letter = lowerChordProperties.letter,
          let accidental = lowerChordProperties.accidental,
          let chordType = lowerChordProperties.chordType else {
      return nil
    }

    return Chord(RootKeyNote(letter, accidental), chordType)
  }

  var upperChord: Chord? {
    guard let letter = upperChordProperties.letter,
          let accidental = upperChordProperties.accidental,
          let chordType = upperChordProperties.chordType else {
      return nil
    }

    return Chord(RootKeyNote(letter, accidental), chordType)
  }

  var resultChord: Chord? {
    guard let lowerChord = lowerChord, let upperChord = upperChord else {
      return nil
    }

    return ChordCombiner.combineChords(firstChord: lowerChord, secondChord: upperChord)
  }

  var chordCombinerVoicingCalculator: ChordCombinerVoicingCalculator? {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord else {
      return nil
    }

    return ChordCombinerVoicingCalculator(
      lowerChordVoicingCalculator: lowerChord.voicingCalculator,
      upperChordVoicingCalculator: upperChord.voicingCalculator,
      resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
  }

  // MARK: Initializer
  init(
    lowerChordProperties: ChordProperties = ChordProperties.initial,
    upperChordProperties: ChordProperties = ChordProperties.initial,
    lowerKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard,
    upperKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard,
    combinedKeyboard: Keyboard = Keyboard.initialDualChordKeyboard
  ) {
    self.lowerChordProperties = lowerChordProperties
    self.upperChordProperties = upperChordProperties
    self.lowerKeyboard = lowerKeyboard
    self.upperKeyboard = upperKeyboard
    self.combinedKeyboard = combinedKeyboard
  }
}

// MARK: Equatable
extension ChordCombinerViewModel: Equatable {
  static func == (lhs: ChordCombinerViewModel, rhs: ChordCombinerViewModel) -> Bool {
    return lhs.lowerChord == rhs.lowerChord && lhs.upperChord == rhs.upperChord && lhs.resultChord == rhs.resultChord
  }
}

// MARK: ChordSelectionStatus
extension ChordCombinerViewModel {
  enum ChordSelectionStatus {
    case neitherChordIsSelected
    case lowerChordIsSelected
    case upperChordIsSelected
    case bothChordsAreSelected
  }

  var chordSelectionStatus: ChordSelectionStatus {
    switch (lowerChord != nil, upperChord != nil) {
    case (false, false):
        .neitherChordIsSelected
    case (true, false):
        .lowerChordIsSelected
    case (false, true):
        .upperChordIsSelected
    case (true, true):
        .bothChordsAreSelected
    }
  }
}

// MARK: ResultChordStatus
extension ChordCombinerViewModel {
  enum ResultChordStatus {
    case combinedChord, slashChord, notFound
  }

  var resultChordStatus: ResultChordStatus {
    guard let lowerChord = lowerChord,
          let resultChord = resultChord else {
      return .notFound
    }

    return resultChord.rootKeyNote == lowerChord.rootKeyNote ? .combinedChord : .slashChord
  }
}

extension ChordCombinerViewModel {
  func getPitchesToHighlight(
    startingPitch: Int,
    lowerTones: [Int],
    upperTones: [Int],
    commonTones: [Int])
  -> CombinedChordHighlightPitches {
      var pitchesToHighlight = CombinedChordHighlightPitches(
        startingPitch: startingPitch,
        lower: lowerTones,
        upper: upperTones,
        common: commonTones)

      if let resultChord = resultChord {
        if let slashChordBassNote = resultChord.slashChordBassNote,
           let degree = resultChord.notes.first(where: { note in
             note.noteNumber.rawValue.isSameNote(
              as: slashChordBassNote.keyName.noteNumber.rawValue)
           })?.degree {
          let slashChordBassNoteBasePitch = slashChordBassNote.keyName.noteNumber.rawValue

          let basePitch = resultChord.root.rootNumber.rawValue

          if let slashChordBassNoteRaisedPitch = pitchesToHighlight.combined.first(
            where: { pitch in
              pitch.isSameNote(as: slashChordBassNoteBasePitch)
            }),
             let rootRaisedPitch = pitchesToHighlight.combined.first(where: { pitch in
               pitch.isSameNote(as: basePitch) }) {

            pitchesToHighlight.pivotCombinedPitchesAround(
              degreeSize: degree.size,
              slashChordBassNoteRaisedPitch: slashChordBassNoteRaisedPitch,
              rootRaisedPitch: rootRaisedPitch)

            pitchesToHighlight.raiseAbove()
          }
        }
      }

      return pitchesToHighlight
  }

  func getPitchesByNote(combinedTones: [Int]) -> PitchesByNote {
    guard let resultChord = resultChord else { return [:] }

    var pitchesByNote: PitchesByNote = [:]
    pitchesByNote.reserveCapacity(12)
    pitchesByNote = resultChord.voicingCalculator.stackedPitchesByNote

    var combinedNotes: [Note] = []

    for pitch in combinedTones {
      if let note = resultChord.notes.first(where: { note in
        note.noteNumber.rawValue.isSameNote(as: pitch)
      }) {
        combinedNotes.append(note)
      }
    }

    pitchesByNote = combinedNotes.toPitchesByNote(pitches: combinedTones)

    return pitchesByNote
  }
}

// MARK: DetailType & displayDetails
extension ChordCombinerViewModel {
  enum DetailType {
    case commonName,
         preciseName,
         lowerChordName,
         upperChordName,
         noteNames,
         degreeNames
  }

  func displayDetailsSplit(
    lowerChord: Chord,
    upperChord: Chord,
    detailType: DetailType)
  -> String {
    switch detailType {
    case .commonName:
      return "\(upperChord.commonName)/\(lowerChord.commonName)"
    case .preciseName:
      return "\(upperChord.preciseName)/\(lowerChord.preciseName)"
    case .lowerChordName:
      return lowerChord.preciseName
    case .upperChordName:
      return upperChord.preciseName
    case .noteNames:
      return (lowerChord.noteNames + upperChord.noteNames)
        .joined(separator: ", ")
    case .degreeNames:
      guard let chordCombinerVoicingCalculator = chordCombinerVoicingCalculator else {
        return (lowerChord.degreeNames.numeric + upperChord.degreeNames.numeric)
          .joined(separator: ", ")
      }

      return (lowerChord.degreeNames.numeric + chordCombinerVoicingCalculator.upperDegreeNamesInLowerKey)
        .joined(separator: ", ")
    }
  }

  func displayDetailsCombined(
    lowerChord: Chord,
    upperChord: Chord,
    resultChord: Chord,
    chordCombinerVoicingCalculator: ChordCombinerVoicingCalculator,
    detailType: DetailType)
  -> String {
    switch detailType {
    case .commonName:
      return resultChord.commonName
    case .preciseName:
      return resultChord.preciseName
    case .lowerChordName:
      return lowerChord.preciseName
    case .upperChordName:
      return upperChord.preciseName
    case .noteNames:
      return chordCombinerVoicingCalculator.resultChordNoteNames.map { $0.noteName }
        .joined(separator: ", ")
    case .degreeNames:
      return chordCombinerVoicingCalculator.resultChordDegreeNames.joined(separator: ", ")
    }
  }

  func displayDetails(detailType: DetailType) -> String {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord else {
      return "please select upper and lower chords"
    }

    guard let resultChord = resultChord,
          let chordCombinerVoicingCalculator = chordCombinerVoicingCalculator else {
      return displayDetailsSplit(
        lowerChord: lowerChord,
        upperChord: upperChord,
        detailType: detailType)
    }

    return displayDetailsCombined(
      lowerChord: lowerChord,
      upperChord: upperChord,
      resultChord: resultChord,
      chordCombinerVoicingCalculator: chordCombinerVoicingCalculator,
      detailType: detailType)
  }
}
