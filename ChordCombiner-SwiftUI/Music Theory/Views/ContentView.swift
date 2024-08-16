//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

enum Tab {
  case content, test
}

struct ContentView: View {
  @ObservedObject var chordStore = ChordStore()
  @State private var selectedTab: Tab = .content
  
  var result: ResultChord {
    ResultChord(baseChord: chordStore.chordData.lowerChord, upStrctTriad: chordStore.chordData.triad)
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      VStack(spacing: 175) {
        HStack(spacing: 30) {
          LowerChordMenu(lowerChord: $chordStore.chordData.lowerChord, chordStore: chordStore)
          USTMenu(upperStructureTriad: $chordStore.chordData.triad, chordStore: chordStore)
        }
        .padding()
        
        Text(result.name)
      }
      .tabItem {
        Text("Content")
      }
      .tag(Tab.content)
      
      ChordTestView()
        .tabItem {
          Text("ChordTest")
        }
        .tag(Tab.test)
    }
  }
}

#Preview {
  ContentView()
}
