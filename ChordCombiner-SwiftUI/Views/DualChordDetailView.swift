//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
  var multiChord: MultiChord
  
  var body: some View {
    VStack(spacing: 20) {
      if multiChord.resultChord != nil {
        VStack(spacing: 5) {
          TitleView(
            text: multiChord.displayDetails(detailType: .commonName),
            weight: .heavy
          )
          if let resultChord = multiChord.resultChord {
            if resultChord.commonName != resultChord.preciseName {
              TitleView(
                text: multiChord.displayDetails(detailType: .preciseName),
                font: .caption
              )
            }
          }
        }
      } else {
        TitleView(
          text: multiChord.displayDetails(detailType: .preciseName),
          font: .title,
          weight: .heavy
        )
      }
      
      multiChord.combinedKeyboard
      
      Form {
        List {
          DetailRow(title: "Notes", text: multiChord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: multiChord.displayDetails(detailType: .degreeNames))
        }
        
        Section(header: Text("Component Chords")) {
          DetailRow(title: "Lower Chord", text: multiChord.displayDetails(detailType: .lowerChordName))
          DetailRow(title: "Upper Chord", text: multiChord.displayDetails(detailType: .upperChordName))
        }
        
        if !multiChord.equivalentChords.isEmpty {
          Section(header: Text("Equivalent Chords")) {
            List {
              ForEach(multiChord.equivalentChords) { chord in
                TitleView(text: chord.preciseName, font: .headline)
              }
            }
          }
        }
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview {
  DualChordDetailView(multiChord: MultiChord())
}
