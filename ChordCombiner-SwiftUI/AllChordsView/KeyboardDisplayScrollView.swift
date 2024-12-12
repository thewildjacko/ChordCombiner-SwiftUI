//
//  KeyboardDisplayScrollView.swift
//  ComboTests
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct NonBinding_KeyboardDisplayScrollView: View {
  let section: ChordTypeSection
  var rootKeyNote: RootKeyNote
  @Binding var keyboardDisplay: Bool
  
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
          
          ChordDisplayView(chord: chord, keyboardDisplay: keyboardDisplay)
        }
      }
    }
    .frame(maxHeight: .infinity)
  }
}

struct KeyboardDisplayScrollView: View {
  let section: ChordTypeSection
  @Binding var rootKeyNote: RootKeyNote
  @Binding var keyboardDisplay: Bool
  
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
          
          ChordDisplayView(chord: chord, keyboardDisplay: keyboardDisplay)
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
      keyboardDisplay: Binding.constant(true)
    )
}
