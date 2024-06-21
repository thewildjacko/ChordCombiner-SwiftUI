//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct ContentView: View {
  @State private var lowerChord = FourNoteChord(.c, .dom7, inversion: .root)
  @State private var upperStructureTriad = Triad(.d, .ma, inversion: .root)
  @State private var resultChord = ResultChord(baseChord: FourNoteChord(), upStrctTriad: Triad(.d, .ma, inversion: .root))
  
  var result: ResultChord {
    ResultChord(baseChord: lowerChord, upStrctTriad: upperStructureTriad)
  }
  
  var body: some View {
    VStack(spacing: 175) {
      HStack(spacing: 40) {
        BaseChordMenu(lowerChord: $lowerChord)
        USTMenu(upperStructureTriad: $upperStructureTriad)
      }
      .padding()
      
      Text(result.name)
    }
  }
}

#Preview {
  ContentView()
}
