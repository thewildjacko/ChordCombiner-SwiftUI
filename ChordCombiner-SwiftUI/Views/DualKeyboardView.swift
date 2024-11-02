//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  
  var chordSymbolText: String {
    guard let resultChord = multiChord.resultChord,
          let multiChordVoicingCalculator = multiChord.multiChordVoicingCalculator else {
      switch (multiChord.lowerChord == nil, multiChord.upperChord == nil) {
      case (true, true):
        return "waiting for chord selection..."
      case (true, false):
        return multiChord.upperChord?.displayDetails(detailType: .commonName) ?? "Please select an upper chord"
      case (false, true):
        return  multiChord.lowerChord?.displayDetails(detailType: .commonName) ?? "Please select a lower Chord chord"
      case (false, false):
        guard let lowerChordName = multiChord.lowerChord?.preciseName, let upperChordName = multiChord.upperChord?.preciseName else {
          return "No chords selected!"
        }
        return "\(upperChordName)/\(lowerChordName)"
      }
    }
    
    return resultChord.root == multiChordVoicingCalculator.lowerRoot ?
    resultChord.commonName :
    "\(resultChord.commonName)/\(multiChordVoicingCalculator.lowerRoot.noteName)"
  }
  
  var chordSymbolCaptionText: String {
    guard let resultChord = multiChord.resultChord else { return "" }
    
    return "(\(resultChord.preciseName))"
  }
    
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        VStack(spacing: 5) {
          if let resultChord = multiChord.resultChord {
            TitleView(
              text: chordSymbolText,
              font: .title,
              weight: .heavy
            )
            if resultChord.commonName != resultChord.preciseName && resultChord.chordType != .ma {
              TitleView(
                text: chordSymbolCaptionText,
                font: .caption
              )
            }
          } else {
            TitleView(
              text: chordSymbolText,
              font: multiChord.lowerChord != nil || multiChord.upperChord != nil ? .title : .headline,
              weight: .heavy
            )
          }
        }
        
        if multiChord.lowerChord != nil || multiChord.upperChord != nil {
          NavigationLink(
            destination:
              DualChordDetailView(multiChord: multiChord, keyboard: keyboard)
          ) {
            Image(systemName: "info.circle")
              .font(.title3)
              .foregroundStyle(.title)
          }
        }
      }
      keyboard
    }
  }
}

#Preview {
  DualChordKeyboardView(
    multiChord: MultiChord(),
    keyboard: .constant(
      Keyboard(
        geoWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    )
  )
  
}
