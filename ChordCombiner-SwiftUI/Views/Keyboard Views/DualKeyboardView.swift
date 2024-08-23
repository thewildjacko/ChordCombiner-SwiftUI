//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var text: String
  @Binding var multiChord: MultiChord
  @Binding var oldMultiChord: MultiChord
  @Binding var keyboard: Keyboard
  var color: Color
  var secondColor: Color
  
  var body: some View {
    VStack(spacing: 20) {
//      Button {
//        ChordHighlighter.highlightStackedCombined(multiChord: &multiChord, keyboard: &keyboard, initial: true, color: color, secondColor: secondColor)
//      } label: {
//        Text("Highlight Stacked")
//      }
//
//      Button {
//        ChordHighlighter.highlightStackedSplit(multiChord: &multiChord, keyboard: &keyboard, initial: true, color: color, secondColor: secondColor)
//      } label: {
//        Text("Highlight Split")
//      }
      
      Text(text)
        .font(.headline)
        .fontWeight(.heavy)
        .fixedSize()
        .foregroundStyle(Color("titleColor"))
      
      if let resultChord = multiChord.resultChord {
        Text(resultChord.name)
          .font(.title)
          .fontWeight(.heavy)
          .fixedSize()
          .foregroundStyle(Color("titleColor"))
      } else {
        Text("\(multiChord.upperChord.name)/\(multiChord.lowerChord.name)")
          .font(.title)
          .fontWeight(.heavy)
          .fixedSize()
          .foregroundStyle(Color("titleColor"))
      }
      
      keyboard
    }
  }
}

#Preview {
  DualChordKeyboardView(
    text: "Combined Chord:",
    multiChord: Binding.constant(
      MultiChord(
        lowerChord: Chord(.d, .ma7, startingOctave: 4),
        upperChord: Chord(.e, .ma, startingOctave: 4),
        resultChord: ChordFactory.combineChords(Chord(.d, .ma7, startingOctave: 4), Chord(.e, .ma, startingOctave: 4)).resultChord
      )
    ),
    oldMultiChord: Binding.constant(
      MultiChord(
        lowerChord: Chord(.d, .ma7, startingOctave: 4),
        upperChord: Chord(.e, .ma, startingOctave: 4),
        resultChord: ChordFactory.combineChords(Chord(.d, .ma7, startingOctave: 4), Chord(.e, .ma, startingOctave: 4)).resultChord
      )
    ),
    keyboard: Binding.constant(Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)),
    color: .yellow,
    secondColor: .cyan
  )
}
