//
//  DualChordKeyboardChordTitleModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/16/24.
//

import SwiftUI

struct DualChordKeyboardChordTitleModel {
  let chordCombinerViewModel = ChordCombinerViewModel.singleton()

  var resultChordSymbol: String {
    guard let resultChord = chordCombinerViewModel.resultChord,
          let lowerChord = chordCombinerViewModel.lowerChord else { return "" }

    return chordCombinerViewModel.resultChordStatus ==
      .combinedChord ?
    resultChord.commonName :
    "\(resultChord.commonName)/\(lowerChord.root.noteName)"
  }

  var titleFont: Font {
    if chordCombinerViewModel.resultChord != nil {
      return .title
    } else {
      switch chordCombinerViewModel.chordSelectionStatus {
      case .lowerChordIsSelected, .upperChordIsSelected:
        return .title
      default:
        return .headline
      }
    }
  }

  var chordSymbolText: String {
    guard chordCombinerViewModel.resultChord != nil else {
      switch chordCombinerViewModel.chordSelectionStatus {
      case .neitherChordIsSelected:
        return "waiting for chord selection..."
      case .lowerChordIsSelected:
        return chordCombinerViewModel.lowerChord?
          .displayDetails(detailType: .commonName)
        ?? "Please select a lower chord"
      case .upperChordIsSelected:
        return chordCombinerViewModel.upperChord?
          .displayDetails(detailType: .commonName)
        ?? "Please select an upper chord"
      case .bothChordsAreSelected:
        return chordCombinerViewModel.displayDetails(detailType: .preciseName)
      }
    }

    return resultChordSymbol
  }

  var chordSymbolCaptionText: String {
    guard let resultChord = chordCombinerViewModel.resultChord else { return "" }

    return "(\(resultChord.preciseName))"
  }
}
