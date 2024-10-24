//
//  CustomChordMenuKeyboardDisplayScrollView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/14/24.
//

import SwiftUI

struct CustomChordMenuKeyboardDisplayScrollView: View {
  @EnvironmentObject var multiChord: MultiChord
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
        ForEach(chordTypes, id: \.rawValue) { chordType in
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
              keyboard: Keyboard(
                geoWidth: 150,
                initialKeyType: .C,
                startingOctave: 4,
                octaves: 2,
                glowColor: matchingChordTypes.contains(chordType) ? .glow : .clear,
                glowRadius: matchingChordTypes.contains(chordType) ? 5 : 0,
                chord: chord,
                color: color
              )
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
              keyboard: Keyboard(
                geoWidth: 150,
                initialKeyType: .C,
                startingOctave: 4,
                octaves: 2
              )
            )
          }
        }
        .onAppear {
          if let selectedChordType = selectedChordType {
            proxy.scrollTo(selectedChordType, anchor: .center)
          }
        }
      }
      .environmentObject(multiChord)
      .listStyle(.plain)
      .frame(maxHeight: .infinity)
      .padding(.horizontal)
    }
  }
}

#Preview {
  CustomChordMenuKeyboardDisplayScrollView(
    selectedChordType: .constant(.ma7),
    matchingChordTypes: .constant([.mi, .ma, .ma6]),
    chordTypes: ChordType.allSimpleChordTypes,
    rootKeyNote: .c,
    color: .lowerChordHighlight
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil),
      upperChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil)
    )
  )
}
