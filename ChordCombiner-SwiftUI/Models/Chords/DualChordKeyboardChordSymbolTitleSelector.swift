//
//  DualChordKeyboardChordSymbolTitleSelector.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/16/24.
//

import SwiftUI

struct DualChordKeyboardChordSymbolTitleSelector {
  let multiChord: MultiChord
  
  var resultChordSymbol: String {
    guard let resultChord = multiChord.resultChord,
          let lowerChord = multiChord.lowerChord else { return "" }
    
    return multiChord.resultChordStatus == .combinedChord ? resultChord.commonName : "\(resultChord.commonName)/\(lowerChord.root.noteName)"
  }
  
  var chordSymbolText: String {
    guard let _ = multiChord.resultChord else {
      switch multiChord.chordSelectionStatus {
      case .neitherChordIsSelected:
        return "waiting for chord selection..."
      case .lowerChordIsSelected:
        return multiChord.lowerChord?.displayDetails(detailType: .commonName) ?? "Please select a lower chord"
      case .upperChordIsSelected:
        return multiChord.upperChord?.displayDetails(detailType: .commonName) ?? "Please select an upper chord"
      case .bothChordsAreSelected:
        return multiChord.displayDetails(detailType: .preciseName)
      }
    }
    
    return resultChordSymbol
  }
  
  var chordSymbolCaptionText: String {
    guard let resultChord = multiChord.resultChord else { return "" }
    
    return "(\(resultChord.preciseName))"
  }
}
