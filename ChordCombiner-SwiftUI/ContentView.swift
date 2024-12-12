//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

struct ContentView: View {  
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
