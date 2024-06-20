//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct ContentView: View {
  var triad = Triad()
  
  var body: some View {
    VStack {
      Text(triad.description)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
