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
  @State var kb3: Keyboard = Keyboard(title: "Combined Chord", geoWidth: 351, keyCount: 36, initialKey: .F, startingOctave: 4)
  
  var body: some View {
    VStack(spacing: 75) {
      
      Spacer()
      
      HStack(spacing: 90) {
        ChordMenu(text: "Lower Chord", chord: $lowerChord)
        ChordMenu(text: "Upper Chord", chord: $upperChord)
      }
      .padding()
      
      List {
        Section(header: Text("Combined Chord")) {
          VStack {
//            if let resultChord = resultChord {
//              Text(resultChord.name)
//            } else {
//              Text("\(upperChord.name)/\(lowerChord.name)")
//            }
            
            kb3
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
      
      let degs1 = [0, 4, 7, 10].map { $0.toPitch(startingOctave: kb3.startingOctave) }
      let degs2 = [2, 6, 9].map { $0.toPitch(startingOctave: kb3.startingOctave) }
      
      kb3.highlightKeys(degs: degs1, degs2: degs2.map({ $0 + 12 }), color: .cyan, color2: .orange)
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
