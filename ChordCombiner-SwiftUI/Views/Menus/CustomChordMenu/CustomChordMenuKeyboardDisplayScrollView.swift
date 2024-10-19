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
        ForEach(chordTypes, id: \.self) { type in
          if let rootKeyNote = rootKeyNote {
            let chord = Chord(rootKeyNote, type)
            
            HStack(alignment: .firstTextBaseline) {
              VStack(alignment: .leading, spacing: 10) {
                TitleView(
                  text: chord.preciseName,
                  font: .title3, weight: .heavy,
                  color: type == selectedChordType ?
                    .tagTitleHighlighted :
                    matchingChordTypes.contains(type) ? .glowText : .title
                )
                
                Keyboard(
                  geoWidth: 150,
                  initialKey: .C,
                  startingOctave: 4,
                  octaves: 2,
                  glowColor: matchingChordTypes.contains(type) ? .glow : .clear,
                  glowRadius: matchingChordTypes.contains(type) ? 5 : 0,
                  chord: chord,
                  color: color
                )
              }
              .onTapGesture { selectedChordType = type }
              
              Spacer()
              
              if matchingChordTypes.contains(type) {
                TitleView(text: "match found!", font: .caption, weight: .bold, color: .glowText)
              }
            }
          } else {
            HStack(alignment: .firstTextBaseline) {
              VStack(alignment: .leading, spacing: 10) {
                TitleView(
                  text: type.preciseName,
                  font: .title3, weight: .heavy,
                  color: selectedChordType != nil && type == selectedChordType! ?
                    .tagTitleHighlighted :
                    matchingChordTypes.contains(type) ? .glowText : .title
                )
                
                Keyboard(
                  geoWidth: 150,
                  initialKey: .C,
                  startingOctave: 4,
                  octaves: 2,
                  glowColor: matchingChordTypes.contains(type) ? .glow : .clear,
                  glowRadius: matchingChordTypes.contains(type) ? 5 : 0
                )
              }
              .onTapGesture { selectedChordType = type }
              
              Spacer()
              
              if matchingChordTypes.contains(type) {
                TitleView(text: "match found!", font: .caption, weight: .bold, color: .glowText)
              }
            }
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
    color: .yellow
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil),
      upperChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil)
    )
  )
}
