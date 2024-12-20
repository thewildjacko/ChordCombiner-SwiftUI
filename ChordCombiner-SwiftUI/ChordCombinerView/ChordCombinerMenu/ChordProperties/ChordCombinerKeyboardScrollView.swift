//
//  ChordCombinerKeyboardScrollView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/14/24.
//

import SwiftUI

struct ChordCombinerKeyboardScrollView: View {
  @Binding var selectedChordType: ChordType?
  @Binding var matchingChordTypes: Set<ChordType>
  
  var chordTypes: [ChordType]
  var rootKeyNote: RootKeyNote?
  var color: Color
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    ScrollViewReader { proxy in
      List {
        ForEach(chordTypes) { chordType in
          if let rootKeyNote = rootKeyNote {
            let chord = Chord(rootKeyNote, chordType)
            
            CustomChordMenuKeyboardDisplayRow(
              selectedChordType: $selectedChordType,
              matchingChordTypes: $matchingChordTypes,
              chordType: chordType,
              titleText: chord.preciseName,
              titleColor: chordType == selectedChordType ?
                .tagTitleHighlighted :
                matchingChordTypes.contains(chordType) ? .glowText : .title,
              glowColor: matchingChordTypes.contains(chordType) ? .glow : .clear,
              glowRadius: matchingChordTypes.contains(chordType) ? 5 : 0,
              chord: chord,
              keyboardColor: color
            )
          } else {
            CustomChordMenuKeyboardDisplayRow(
              selectedChordType: $selectedChordType,
              matchingChordTypes: $matchingChordTypes,
              chordType: chordType,
              titleText: chordType.preciseName,
              titleColor: selectedChordType != nil && chordType == selectedChordType! ?
                .tagTitleHighlighted :
                matchingChordTypes.contains(chordType) ? .glowText : .title,
              glowColor: matchingChordTypes.contains(chordType) ? .glow : .clear,
              glowRadius: matchingChordTypes.contains(chordType) ? 5 : 0,
              chord: nil,
              keyboardColor: nil
            )
          }
        }
        .onAppear {
          if let selectedChordType = selectedChordType {
            proxy.scrollTo(selectedChordType, anchor: .center)
          }
        }
      }
      .listStyle(.plain)
      .frame(maxHeight: .infinity)
      .padding(.horizontal)
    }
  }
}

#Preview {
  ChordCombinerKeyboardScrollView(
    selectedChordType: .constant(.ma7),
    matchingChordTypes: .constant([.mi, .ma, .ma6]),
    chordTypes: ChordType.allSimpleChordTypes,
    rootKeyNote: .c,
    color: .lowerChordHighlight
  )
}
