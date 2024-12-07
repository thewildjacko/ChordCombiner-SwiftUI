//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI
import Observation

@Observable
final class MultiChord: ObservableObject {
  enum ChordSelectionStatus {
    case neitherChordIsSelected
    case lowerChordIsSelected
    case upperChordIsSelected
    case bothChordsAreSelected
  }
  
  enum ResultChordStatus {
    case combinedChord, slashChord, notFound
  }
  
  var lowerChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil)
  var upperChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil)
  
  var lowerKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2)
  var upperKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2)
  var combinedKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  
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
  
  var resultChord: Chord? {
    guard let lowerChord = lowerChord, let upperChord = upperChord else {
      return nil
    }
    
    return ChordFactory.combineChords(firstChord: lowerChord, secondChord: upperChord)
  }
  
  var resultChordStatus: ResultChordStatus {
    guard let lowerChord = lowerChord,
          let resultChord = resultChord else {
      return .notFound
    }
    
    return resultChord.rootKeyNote == lowerChord.rootKeyNote ? .combinedChord : .slashChord
  }
  
  var multiChordVoicingCalculator: MultiChordVoicingCalculator? {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord else {
      return nil
    }
    
    return MultiChordVoicingCalculator(
      lowerChordVoicingCalculator: lowerChord.voicingCalculator,
      upperChordVoicingCalculator: upperChord.voicingCalculator,
      resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
  }
  
  init(
    lowerChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    upperChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    lowerKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    upperKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    combinedKeyboard: Keyboard = Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  ) {
    self.lowerChordProperties = lowerChordProperties
    self.upperChordProperties = upperChordProperties
    self.lowerKeyboard = lowerKeyboard
    self.upperKeyboard = upperKeyboard
    self.combinedKeyboard = combinedKeyboard
  }    
}

extension MultiChord: Equatable {
  static func == (lhs: MultiChord, rhs: MultiChord) -> Bool {
    return lhs.lowerChord == rhs.lowerChord && lhs.upperChord == rhs.upperChord && lhs.resultChord == rhs.resultChord
  }
}

extension MultiChord {
  enum DetailType {
    case commonName,
         preciseName,
         lowerChordName,
         upperChordName,
         noteNames,
         degreeNames
    
  }
  
  func displayDetails(detailType: DetailType) -> String {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord else {
      return "please select upper and lower chords"
    }
    
    guard let resultChord = resultChord,
          let multiChordVoicingCalculator = multiChordVoicingCalculator else {
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
        guard let multiChordVoicingCalculator = multiChordVoicingCalculator else {
          return (lowerChord.degreeNames.numeric + upperChord.degreeNames.numeric)
            .joined(separator: ", ")
        }
        
        return (lowerChord.degreeNames.numeric + multiChordVoicingCalculator.upperDegreeNamesInLowerKey)
          .joined(separator: ", ")
      }
    }
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
      return multiChordVoicingCalculator.resultChordNoteNames.map { $0.noteName }
        .joined(separator: ", ")
    case .degreeNames:
      return multiChordVoicingCalculator.resultChordDegreeNames.joined(separator: ", ")
    }
  }
}
