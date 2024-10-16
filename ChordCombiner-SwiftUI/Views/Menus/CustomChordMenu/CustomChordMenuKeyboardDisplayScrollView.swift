//
//  KeyboardDisplayScrollView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/14/24.
//


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
          ForEach(section.chordTypes) { type in
            let chord = Chord(rootKeyNote, type)
            
            if kbDisplay {
              KeyboardDisplayView(
                chord: chord,
                keyboard: Keyboard(
                  geoWidth: 250,
                  initialKey: .C,
                  startingOctave: 4,
                  octaves: 3),
                color: .yellow
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
      section: /*Binding.constant(*/ChordType.chordTypeSections[5]/*)*/,
      rootKeyNote: Binding.constant(.c),
      kbDisplay: Binding.constant(true)
    )
}
