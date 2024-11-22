//
//  SingleChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/16/24.
//


import SwiftUI

struct SingleChordDetailView: View {
  let chord: Chord
  let keyboard: Keyboard
  
  var baseChord: Chord { chord.getBaseChord() }
  
  var body: some View {
    VStack(spacing: 5) {
      TitleView(
        text: chord.displayDetails(detailType: .commonName),
        font: .largeTitle,
        weight: .heavy
      )
      
      ChordSymbolCaptionView(chord: chord)
      
      keyboard
      
      Form {
        List {
          DetailRow(title: "Notes", text: chord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: chord.displayDetails(detailType: .degreeNames))
        }
        
        BaseChordSectionView(chord: chord)
        EquivalentChordsSectionView(chord: chord)
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview {
  SingleChordDetailView(
    chord: Chord(.c, .ma13_sh11),
    keyboard: Keyboard(baseWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  )
}
