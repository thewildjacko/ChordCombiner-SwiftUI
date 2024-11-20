//
// DualChordDetailNavigationLinkView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/18/24.
//

import SwiftUI

struct DualChordDetailNavigationLinkView: View {
  let multiChord: MultiChord
  
  var chord: Chord? {
    if let lowerChord = multiChord.lowerChord {
      return lowerChord
    } else if let upperChord = multiChord.upperChord {
      return upperChord
    } else {
      return nil
    }
  }
  
  var color: Color { multiChord.lowerChord != nil ? .lowerChordHighlight : .upperChordHighlight }
  
  @ViewBuilder
  var body: some View {
    if multiChord.resultChord != nil {
      NavigationLink(destination: DualChordDetailView(multiChord: multiChord)) { InfoLinkImageView() }
    } else {
      SingleChordDetailNavigationLinkView(chord: chord, color: color)
      //        if let chord = chord {
      //          NavigationLink(
      //            destination:
      //              SingleChordDetailView(
      //                chord: chord, keyboard:
      //                  Keyboard(
      //                    baseWidth: 351,
      //                    initialKeyType: .C,
      //                    startingOctave: 4,
      //                    octaves: 2,
      //                    chord: chord,
      //                    color: color
      //                  )
      //              )
      //          ) {
      //            InfoLinkImageView()
      //          }
      //        }
      //      }
    }
  }
}

#Preview {
  DualChordDetailNavigationLinkView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    )
  )
}

