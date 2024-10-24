//
//  KeyboardDisplayScrollView.swift
//  ComboTests
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayScrollView: View {
  let section: ChordTypeSection
  @Binding var rootKeyNote: RootKeyNote
  @Binding var kbDisplay: Bool

  let rows = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
    var body: some View {
      ScrollView(.horizontal) {
        LazyHGrid(rows: rows, spacing: 20) {
          ForEach(section.chordTypes) { chordType in
            let chord = Chord(rootKeyNote, chordType)
            
            if kbDisplay {
              KeyboardDisplayView(
                chord: chord,
                keyboard:
                  Keyboard(
                    geoWidth: 250,
                    initialKeyType: .C,
                    startingOctave: 4,
                    octaves: 3,
                    glowColor: .clear,
                    glowRadius: 0,
                    chord: chord,
                    color: .lowerChordHighlight
                  ),
                color: .lowerChordHighlight
              )
            } else {
              Text(chord.preciseName)
                .roundRectTagView(
                  font: .title2,
                  horizontalPadding: 8,
                  verticalPadding: 5,
                  cornerRadius: 12
                )
            }
          }
        }
      }
      .frame(maxHeight: .infinity)
    }
}

#Preview {
    KeyboardDisplayScrollView(
      section: ChordType.chordTypeSections[5],
      rootKeyNote: Binding.constant(.c),
      kbDisplay: Binding.constant(true)
    )
}
