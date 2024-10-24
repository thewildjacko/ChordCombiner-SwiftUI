//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI

class MultiChord: ObservableObject {
  @Published var lowerChordProperties: ChordProperties
  @Published var oldLowerChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: nil, chordType: nil)
  
  @Published var upperChordProperties: ChordProperties
  @Published var oldUpperChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: nil, chordType: nil)
  
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
    
    return ChordFactory.combineChords(firstChord: lowerChord, secondChord: upperChord).resultChord    
  }
  
  var equivalentChords: [Chord] {
    guard let lowerChord = lowerChord, let upperChord = upperChord else {
      return []
    }
    
    return ChordFactory.combineChords(firstChord: lowerChord, secondChord: upperChord).equivalentChords
  }
  
  let color: Color = .lowerChordHighlight
  let secondColor: Color = .lowerChordHighlight
  
  var multiChordVoicingCalculator: MultiChordVoicingCalculator? {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord,
          let resultChord = resultChord else {
      return nil
    }
    
    return MultiChordVoicingCalculator(
      lowerChordVoicingCalculator: lowerChord.voicingCalculator,
      upperChordVoicingCalculator: upperChord.voicingCalculator,
      resultChordVoicingCalculator: resultChord.voicingCalculator)
  }
  
  init(lowerChordProperties: ChordProperties, upperChordProperties: ChordProperties) {
    self.lowerChordProperties = lowerChordProperties
    self.upperChordProperties = upperChordProperties
  }
    
  func singleChordTitle(forLowerChord: Bool) -> String {
    let chordPrompt = "Please select a chord"
    
    if forLowerChord {
      guard let chordName = lowerChord?.commonName else {
        return chordPrompt
      }
      
      return chordName
    } else {
      guard let chordName = upperChord?.commonName else {
        return chordPrompt
      }
      
      return chordName
    }
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
