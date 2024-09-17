//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MultiChordKeyboardView()
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
