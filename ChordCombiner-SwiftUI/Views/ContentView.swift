//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

enum Tab {
  case singleChord, multiChord
}

struct ContentView: View {
  @State private var selectedTab: Tab = .singleChord
  
  var body: some View {
    TabView(selection: $selectedTab) {
      SingleChordKeyboardDisplayView()
        .tabItem {
          Text("Single Chord")
        }
        .tag(Tab.singleChord)
      MultiChordKeyboardView()
        .tabItem {
          Text("Chord Combiner")
        }
        .tag(Tab.multiChord)
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
