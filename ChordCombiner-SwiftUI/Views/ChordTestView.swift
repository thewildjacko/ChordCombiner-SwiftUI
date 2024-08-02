//
//  ChordTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordTestView: View {
  @State var lowerChord: Chord = Chord(.c, .ma7)
  @State var upperChord: Chord = Chord(.d, .ma)
  @State var resultChord: Chord?
  
  var body: some View {
    VStack(spacing: 175) {
      HStack(spacing: 90) {
        ChordMenu(text: "Lower Chord", chord: $lowerChord)
        ChordMenu(text: "Upper Chord", chord: $upperChord)
      }
      .padding()
      
      if let resultChord = resultChord {
        Text(resultChord.name)
      } else {
        Text("Couldn't find chord")
      }
    }
    .onAppear(perform: {
      resultChord = ChordFactory.combineChords(lowerChord, upperChord) ?? nil
    })
    .onChange(of: lowerChord) { oldValue, newValue in
      resultChord = ChordFactory.combineChords(lowerChord, upperChord) ?? nil
    }
    .onChange(of: upperChord) { oldValue, newValue in
      resultChord = ChordFactory.combineChords(lowerChord, upperChord) ?? nil
    }
  }
}


#Preview {
  ChordTestView()
}
