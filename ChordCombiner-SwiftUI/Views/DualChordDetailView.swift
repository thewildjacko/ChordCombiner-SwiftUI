//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
  @EnvironmentObject var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  
  var body: some View {
    VStack(spacing: 20) {
      if multiChord.resultChord != nil {
        VStack(spacing: 5) {
          Text(multiChord.displayDetails(detailType: .commonName))
            .font(.largeTitle)
            .fontWeight(.heavy)
            .fixedSize()
            .foregroundStyle(Color("titleColor"))
          if let resultChord = multiChord.resultChord {
            if resultChord.commonName != resultChord.preciseName {
              Text(multiChord.displayDetails(detailType: .preciseName))
                .font(.caption)
                .fixedSize()
                .foregroundStyle(Color("titleColor"))
            }
          }
        }
      } else {
        Text(multiChord.displayDetails(detailType: .preciseName))
          .font(.title)
          .fontWeight(.heavy)
          .fixedSize()
          .foregroundStyle(Color("titleColor"))
      }
      
      keyboard
      
      Form {
        List {
          
          DetailRow(title: "Notes", text: multiChord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: multiChord.displayDetails(detailType: .degreeNames))
        }
        
        Section(header: Text("Component Chords")) {
          DetailRow(title: "Lower Chord", text: multiChord.displayDetails(detailType: .lowerChordName))
          DetailRow(title: "Upper Chord", text: multiChord.displayDetails(detailType: .upperChordName))
        }
      }
      
//      .headerProminence(.increased)
      
      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview {
  DualChordDetailView(keyboard: Binding.constant(Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)))
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    ))
}
