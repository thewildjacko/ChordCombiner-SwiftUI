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
  @State var equivalentChords: [Chord] = []
  @State var deltaChords: [Chord] = []
  
  var body: some View {
    VStack(spacing: 75) {
      Spacer()
      Spacer()
      Spacer()
      
      HStack(spacing: 90) {
        ChordMenu(text: "Lower Chord", chord: $lowerChord)
        ChordMenu(text: "Upper Chord", chord: $upperChord)
      }
      .padding()
      
      List {
        Section(header: Text("Combined Chord")) {
          if let resultChord = resultChord {
            Text(resultChord.name)
          } else {
            Text("\(upperChord.name)/\(lowerChord.name)")
          }
        }
        
        if !equivalentChords.isEmpty {
          Section(header: Text("Equivalent Chords")) {
            ForEach(equivalentChords, id: \.id) { chord in
              Text(chord.name)
            }
          }
        }
      }
      .scrollContentBackground(.hidden)
      Spacer()
    }
    .onAppear(perform: {
      resultChord = ChordFactory.combineChords(lowerChord, upperChord).resultChord
      equivalentChords = ChordFactory.combineChords(lowerChord, upperChord).equivalentChords
      
      if let resultChord = resultChord {
        deltaChords = ChordFactory.deltaChords(resultChord, delta: 1)
//        print(deltaChords.map { $0.name} )
      }
    })
    .onChange(of: lowerChord) { oldValue, newValue in
      resultChord = ChordFactory.combineChords(lowerChord, upperChord).resultChord
      equivalentChords = ChordFactory.combineChords(lowerChord, upperChord).equivalentChords
      if let resultChord = resultChord {
        deltaChords = ChordFactory.deltaChords(resultChord, delta: 1)
//        print(deltaChords.map { $0.name} )
      }
//      print(equivalentChords)
    }
    .onChange(of: upperChord) { oldValue, newValue in
      resultChord = ChordFactory.combineChords(lowerChord, upperChord).resultChord
      equivalentChords = ChordFactory.combineChords(lowerChord, upperChord).equivalentChords
      if let resultChord = resultChord {
        deltaChords = ChordFactory.deltaChords(resultChord, delta: 1)
//        print(deltaChords.map { $0.name} )
      }
//      print(equivalentChords)
    }
  }
}


#Preview {
  ChordTestView()
}
