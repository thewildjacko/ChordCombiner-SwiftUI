//
//  ChordCombinerViewModel+Codable.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/18/24.
//
import SwiftUI

// MARK: Equatable
extension ChordCombinerViewModel: Equatable {
  static func == (lhs: ChordCombinerViewModel, rhs: ChordCombinerViewModel) -> Bool {
    return lhs.chordPropertyData.lowerChordProperties == rhs.chordPropertyData.lowerChordProperties
    && lhs.chordPropertyData.upperChordProperties == rhs.chordPropertyData.upperChordProperties
    //    && lhs.resultChord == rhs.resultChord
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

  var resultChordNotesAndDegrees: (notes: String, degrees: String) {
    if let chordCombinerVoicingCalculator = chordCombinerVoicingCalculator {

      let pitchesToHighlight = getPitchesToHighlight(
        startingPitch: combinedKeyboard.startingPitch,
        lowerTones: chordCombinerVoicingCalculator.lowerTonesToHighlight,
        upperTones: chordCombinerVoicingCalculator.upperTonesToHighlight,
        commonTones: chordCombinerVoicingCalculator.commonTonesToHighlight)

      let combinedPitches = pitchesToHighlight.combinedSorted
      let resultChordNotes = chordCombinerVoicingCalculator.resultChordNotes

      var notes: [Note] = []
      var degreeNames: [String] = []

      for pitch in combinedPitches {
        if let index = resultChordNotes.firstIndex(where: { note in
            pitch.isSameNote(as: note.noteNumber.rawValue)}) {
          let resultNote = resultChordNotes[index]
          notes.append(resultNote)
          degreeNames.append(resultNote.degreeName.numeric)
        }
      }

      return (notes.noteNames().joined(separator: ", "),
              degreeNames.joined(separator: ", "))
    } else {
      return ("", "")
    }
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
      return chordCombinerVoicingCalculator.resultChordNotes.noteNames()
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
