//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

enum Tab {
  case singleChord, multiChord, allChords
}

struct ContentView: View {
  @State private var selectedTab: Tab = .multiChord
  
  var body: some View {
    TabView(selection: $selectedTab) {
      MultiChordKeyboardView()
        .tabItem {
          Text("Chord Combiner")
        }
        .tag(Tab.multiChord)
      SingleChordKeyboardDisplayView()
        .tabItem {
          Text("Single Chord")
        }
        .tag(Tab.singleChord)
      AllChordsView()
        .tabItem {
          Text("All Chords")
        }
        .tag(Tab.allChords)
    }
  }
}

#Preview {
  ContentView()
    .environmentObject(
      MultiChord(
        lowerChord: Chord(.c, .ma7, startingOctave: 4),
        upperChord: Chord(.d, .ma, startingOctave: 4)
      ))
}
