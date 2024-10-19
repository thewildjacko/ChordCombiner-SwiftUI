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
    NavigationStack {
      //    TabView(selection: $selectedTab) {
      List {
        NavigationLink(
          destination:
            MultiChordKeyboardView()
            .navigationTitle("Chord Combiner")
        ) { Text("Chord Combiner") }
        //        .tabItem {
        //          Text("Chord Combiner")
        //        }
        //        .tag(Tab.multiChord)
        NavigationLink(
          destination:
            SingleChordKeyboardMenuView()
            .navigationTitle("Single Chord Picker")
        ) {
          Text("Single Chord Picker")
        }
//        SingleChordKeyboardMenuView()
//          .tabItem {
//            Text("Single Chord")
//          }
//          .tag(Tab.singleChord)
        NavigationLink(
          destination:
            AllChordsView()
            .navigationTitle("All Chords")
        ) {
          Text("All Chords")
        }
        
//        AllChordsView()
//          .tabItem {
//            Text("All Chords")
//          }
//          .tag(Tab.allChords)
      }
      .navigationTitle("Harmony Brain")
    }
  }
}

#Preview {
  ContentView()
}
