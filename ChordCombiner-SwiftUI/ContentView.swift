//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

enum Tab {
  case singleChord, chordCombinerViewModel, allChords
}

struct ContentView: View {
  @State private var selectedTab: Tab = .chordCombinerViewModel
  
  var body: some View {
    NavigationStack {
      List {
        NavigationLink(
          destination:
            ChordCombinerView()
            .navigationTitle("Chord Combiner")
        ) { Text("Chord Combiner") }
        
        NavigationLink(
          destination:
            AllChordsView()
            .navigationTitle("All Chords")
        ) {
          Text("All Chords")
        }
        
        NavigationLink(
          destination:
            ChordGrapherView()
            .navigationTitle("Chord Graph")
        ) {
          Text("Chord Graph")
        }
      }
      .navigationTitle("Harmony Brain")
    }
  }
}

#Preview {
  ContentView()
}
