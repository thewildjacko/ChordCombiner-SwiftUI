//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import Foundation
import SwiftUI

struct MultiChordProperties: Equatable {
  var id: UUID = UUID()
  var letter: Letter?
  var accidental: RootAccidental?
  var type: ChordType?
  
  init(letter: Letter? = nil, accidental: RootAccidental? = nil, type: ChordType? = nil) {
    self.letter = letter
    self.accidental = accidental
    self.type = type
  }
}

class MultiChord: ObservableObject {
  @Published var lowerChordProperties: MultiChordProperties
  @Published var upperChordProperties: MultiChordProperties
  
  //  @Published var lowerChord: Chord {
  //    didSet { setResultChord() }
  //  }
  
  //  @Published var upperChord: Chord {
  //    didSet { setResultChord() }
  //  }
  
  //  @Published var resultChord: Chord? = nil {
  //    didSet { multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches() }
  //  }
  
  //  var multiChordVoicingCalculator: MultiChordVoicingCalculator? {
  //    get {
  //      MultiChordVoicingCalculator(
  //        lowerChordVoicingCalculator: lowerChord.voicingCalculator,
  //        upperChordVoicingCalculator: upperChord.voicingCalculator,
  //        resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
  //    }
  //    set { }
  //  }
  
  var lowerChord: Chord? {
    guard let letter = lowerChordProperties.letter,
          let accidental = lowerChordProperties.accidental,
          let type = lowerChordProperties.type else {
      return nil
    }
    
    return Chord(RootKeyNote(letter, accidental), type)
  }
  
  var upperChord: Chord? {
    guard let letter = upperChordProperties.letter,
          let accidental = upperChordProperties.accidental,
          let type = upperChordProperties.type else {
      return nil
    }
    
    return Chord(RootKeyNote(letter, accidental), type)
  }
  
  var resultChord: Chord? {
    guard let lowerChord = lowerChord, let upperChord = upperChord else {
      return nil
    }
    
    return ChordFactory.combineChordDegrees(
      degrees: lowerChord.degrees,
      otherDegrees: upperChord.degrees,
      root: lowerChord.root,
      otherRoot: upperChord.root
    )
  }
  
  let color: Color = .yellow
  let secondColor: Color = .cyan
  
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
  
  init(lowerChordProperties: MultiChordProperties, upperChordProperties: MultiChordProperties) {
    self.lowerChordProperties = lowerChordProperties
    self.upperChordProperties = upperChordProperties
    //    setResultChord()
  }
  
  //  init(lowerChord: Chord, upperChord: Chord) {
  //    self.lowerChord = lowerChord
  //    self.upperChord = upperChord
  //    setResultChord()
  //  }
  
  //  func setResultChord() {
  //    guard let lowerChord = lowerChord,
  //            let upperChord = upperChord else {
  //      return
  //    }
  //
  //    resultChord = ChordFactory.combineChordDegrees(
  //      degrees: lowerChord.degrees,
  //      otherDegrees: upperChord.degrees,
  //      root: lowerChord.root,
  //      otherRoot: upperChord.root)
  //
  //    multiChordVoicingCalculator.resultChordVoicingCalculator = resultChord?.voicingCalculator ?? nil
  //  }
  
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
