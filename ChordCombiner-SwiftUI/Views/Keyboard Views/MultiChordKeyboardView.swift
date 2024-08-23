//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
  @State var multiChord: MultiChord
  @State var oldMultiChord: MultiChord
  @State var keyboard: Keyboard
  
  var color: Color = .yellow
  var secondColor: Color = .cyan
  
  var body: some View {
    VStack() {
      
      ForEach((1...10), id: \.self ) { _ in
        Spacer()
      }
      
      HStack {
        LowerChordKeyboardView(
          text: "Lower Chord",
          multiChord: $multiChord,
          oldMultiChord: $oldMultiChord,
          keyboard: Keyboard(geoWidth: 160, initialKey: .C,  startingOctave: 4, octaves: 2),
          color: color
        )
        
        Spacer()
        
        Text("+")
          .font(.title2)
          .fontWeight(.heavy)
          .foregroundStyle(Color("titleColor"))
          .zIndex(1.0)
        
        Spacer()
        
        UpperChordKeyboardView(
          text: "Upper Chord",
          multiChord: $multiChord,
          oldMultiChord: $oldMultiChord,
          keyboard: Keyboard(geoWidth: 160, initialKey: .C,  startingOctave: 4, octaves: 2),
          color: secondColor
        )
      }
      Spacer()
      
      Text("=")
        .font(.title2)
        .fontWeight(.heavy)
        .foregroundStyle(Color("titleColor"))
      
      Spacer()
      
      DualChordKeyboardView(
        text: "Combined Chord",
        multiChord: $multiChord,
        oldMultiChord: $oldMultiChord,
        keyboard: $keyboard,
        color: color,
        secondColor: secondColor
      )
      
      ForEach((1...10), id: \.self ) { _ in
        Spacer()
      }
      
    }
    .padding()
    .onAppear(perform: {
      multiChord.setAndHighlightChords(initial: true, keyboard: &keyboard, oldMultiChord: &oldMultiChord, color: color, secondColor: secondColor)
    })
    .onChange(of: multiChord.lowerChord) {
      multiChord.setAndHighlightChords(initial: false, keyboard: &keyboard, oldMultiChord: &oldMultiChord, color: color, secondColor: secondColor)
    }
    .onChange(of: multiChord.upperChord) {
      multiChord.setAndHighlightChords(initial: false, keyboard: &keyboard, oldMultiChord: &oldMultiChord, color: color, secondColor: secondColor)
    }
  }
}

#Preview {
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
