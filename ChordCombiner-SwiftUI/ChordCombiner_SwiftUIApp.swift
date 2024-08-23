//
//  ChordCombiner_SwiftUIApp.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

@main
struct ChordCombiner_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
          MultiChordKeyboardView(
            multiChord: MultiChord(
              lowerChord: Chord(.c, .ma7, startingOctave: 4),
              upperChord: Chord(.d, .ma, startingOctave: 4)
            ),
            oldMultiChord: MultiChord(
              lowerChord: Chord(.c, .ma7, startingOctave: 4),
              upperChord: Chord(.d, .ma, startingOctave: 4)
            ),
            keyboard: Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
          )
        }
    }
}
