//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var chordStore = ChordStore()
//  @State var lowerChord = FourNoteChord()
//  @State var triad = Triad()
  
  var result: ResultChord {
    ResultChord(baseChord: chordStore.chordData.lowerChord, upStrctTriad: chordStore.chordData.triad)
  }
  
  var body: some View {
    VStack(spacing: 175) {
      HStack(spacing: 30) {
//        LowerChordMenu(lowerChord: $chordStore.lowerChord, chordStore: chordStore)
//        USTMenu(upperStructureTriad: $chordStore.triad, chordStore: chordStore)
        LowerChordMenu(lowerChord: $chordStore.chordData.lowerChord, chordStore: chordStore)
        USTMenu(upperStructureTriad: $chordStore.chordData.triad, chordStore: chordStore)
      }
      .padding()
      
//      NavigationStack {
//        NavigationLink(destination: Text(result.description)) {
          Text(result.name)
//        }
//      }
    }
  }
}

#Preview {
  ContentView()
}
