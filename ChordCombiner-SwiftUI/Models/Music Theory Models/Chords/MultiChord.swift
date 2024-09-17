//
//  MultiChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import Foundation

class MultiChord: ObservableObject {
  @Published var lowerChord: Chord {
    didSet { setResultChord() }
  }
  
  @Published var upperChord: Chord {
    didSet { setResultChord() }
  }
  
  @Published var resultChord: Chord? = nil { 
    didSet { multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches() }
  }
  
  var multiChordVoicingCalculator: MultiChordVoicingCalculator {
    get {
      MultiChordVoicingCalculator(
        lowerChordVoicingCalculator: lowerChord.voicingCalculator,
        upperChordVoicingCalculator: upperChord.voicingCalculator,
        resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
    }
    set { }
  }
  
  init(lowerChord: Chord, upperChord: Chord) {
    self.lowerChord = lowerChord
    self.upperChord = upperChord
    setResultChord()
  }

  func setResultChord() {
    resultChord = ChordFactory.combineChordDegrees(
      lowerDegrees: multiChordVoicingCalculator.lowerDegrees,
      upperDegrees: multiChordVoicingCalculator.upperDegrees,
      lowerRoot: multiChordVoicingCalculator.lowerRoot,
      upperRoot: multiChordVoicingCalculator.upperRoot)
    multiChordVoicingCalculator.resultChordVoicingCalculator = resultChord?.voicingCalculator ?? nil
  }
}

extension MultiChord {
  enum DetailType {
    case commonName,
         preciseName,
         noteNames,
         degreeNames
  }
  
  func displayDetails(detailType: DetailType) -> String {
    if let resultChord = resultChord {
      let nums = resultChord.voicingCalculator.stackedPitches.sorted().map({ $0.degreeInOctave })
      var notes: [Note] {
        var theNotes: [Note?] = []
        for num in nums {
          if let index = resultChord.allNotes.firstIndex(where: { $0.noteNum.rawValue == num }) {
            theNotes.append(resultChord.allNotes[index])
          }
        }
        
        return theNotes.compactMap { $0 }
      }
      
      print(multiChordVoicingCalculator.getResultChordNoteNames(resultChord.allNotes))
      
      switch detailType {
      case .commonName:
        return resultChord.commonName
      case .preciseName:
        return resultChord.preciseName
      case .noteNames:
        return multiChordVoicingCalculator.getResultChordNoteNames(resultChord.allNotes).map { $0.noteName }.joined(separator: ", ")
      case .degreeNames:
        return resultChord.degreeNames.short.joined(separator: ", ")
      }
    } else {
      switch detailType {
      case .commonName:
        return "\(upperChord.commonName)/\(lowerChord.commonName)"
      case .preciseName:
        return "\(upperChord.preciseName)/\(lowerChord.preciseName)"
      case .noteNames:
        return (lowerChord.noteNames + upperChord.noteNames).joined(separator: ", ")
      case .degreeNames:
        return (lowerChord.degreeNames.short + upperChord.degreeNames.short).joined(separator: ", ")
      }
    }
  }
}
