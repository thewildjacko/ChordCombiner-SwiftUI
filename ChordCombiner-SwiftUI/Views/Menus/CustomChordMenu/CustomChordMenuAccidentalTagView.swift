//
//  CustomChordMenuAccidentalTagView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct CustomChordMenuAccidentalTagsView: View {
  @EnvironmentObject var multiChord: MultiChord
  @Binding var selectedAccidental: RootAccidental?
  @Binding var matchingAccidentals: Set<RootAccidental>
  
  var isHorizontal: Bool = true
  var font: Font = .caption
  var horizontalPadding: CGFloat = 9
  var verticalPadding: CGFloat = 5
  var cornerRadius: CGFloat = 8
  
  var body: some View {
    Group {
      if isHorizontal {
        HStack {
          ForEach(RootAccidental.allCases, id: \.self) { accidental in
            AccidentalTagView(
              accidental: accidental,
              highlightCondition: selectedAccidental == accidental,
              font: font,
              horizontalPadding: horizontalPadding,
              verticalPadding: verticalPadding,
              cornerRadius: cornerRadius,
              glowColor: matchingAccidentals.contains(accidental) ? .glow : .clear,
              glowRadius: matchingAccidentals.contains(accidental) ? 3 : 0
            )
            .onTapGesture { selectedAccidental = accidental }
          }
        }
      } else {
        VStack {
          ForEach(RootAccidental.allCases, id: \.self) { accidental in
            AccidentalTagView(
              accidental: accidental,
              highlightCondition: selectedAccidental == accidental,
              font: font,
              horizontalPadding: horizontalPadding,
              verticalPadding: verticalPadding,
              cornerRadius: cornerRadius,
              glowColor: matchingAccidentals.contains(accidental) ? .glow : .clear,
              glowRadius: matchingAccidentals.contains(accidental) ? 3 : 0
            )
            .onTapGesture { selectedAccidental = accidental }
          }
        }
      }
    }
    .environmentObject(multiChord)
  }
}

#Preview {
  CustomChordMenuAccidentalTagsView(
    selectedAccidental: .constant(.natural),
    matchingAccidentals: .constant([.natural]),
    isHorizontal: false
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil),
      upperChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil)
    )
  )
}
