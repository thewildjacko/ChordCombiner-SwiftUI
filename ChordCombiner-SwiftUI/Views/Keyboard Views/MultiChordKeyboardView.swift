//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
//  MARK: @State and instance variables
  @State var multiChord: MultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  @State var oldMultiChord: MultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  @State var lowerKeyboard: Keyboard = Keyboard(geoWidth: 160, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var upperKeyboard: Keyboard = Keyboard(geoWidth: 160, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var combinedKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
//  @State var lowerKeyboard: Keyboard = Keyboard(geoWidth: 350, initialKey: .C,  startingOctave: 4, octaves: 2)
//  @State var upperKeyboard: Keyboard = Keyboard(geoWidth: 350, initialKey: .C,  startingOctave: 4, octaves: 2)
//  @State var combinedKeyboard: Keyboard = Keyboard(geoWidth: 900, initialKey: .C,  startingOctave: 4, octaves: 5)
  
  var color: Color = .yellow
  var secondColor: Color = .cyan
  
//  MARK: instance methods
  func setAndHighlightChords(initial: Bool) {
    multiChord.resultChord = ChordFactory.combineChords(multiChord.lowerChord, multiChord.upperChord).resultChord
    
    if initial {
      multiChord.resultChord = ChordFactory.combineChords(multiChord.lowerChord, multiChord.upperChord).resultChord
      ChordHighlighter.highlightStacked(
        multiChord: multiChord,
        keyboard: &lowerKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: true
      )
      ChordHighlighter.highlightStacked(
        multiChord: multiChord,
        keyboard: &upperKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: false
      )
      
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: multiChord,
        keyboard: &combinedKeyboard,
        color: color,
        secondColor: secondColor
      )
    } else {
      ChordHighlighter.highlightStacked(
        multiChord: oldMultiChord,
        keyboard: &lowerKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: true
      )
      ChordHighlighter.highlightStacked(
        multiChord: oldMultiChord,
        keyboard: &upperKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: false
      )
      
      ChordHighlighter.highlightStacked(
        multiChord: multiChord,
        keyboard: &lowerKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: true
      )
      ChordHighlighter.highlightStacked(
        multiChord: multiChord,
        keyboard: &upperKeyboard,
        color: color,
        secondColor: secondColor,
        isLower: false
      )
      
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: oldMultiChord,
        keyboard: &combinedKeyboard,
        color: color,
        secondColor: secondColor
      )
      ChordHighlighter.highlightStackedCombinedOrSplit(
        multiChord: multiChord,
        keyboard: &combinedKeyboard,
        color: color,
        secondColor: secondColor
      )
    }
    
    oldMultiChord = multiChord
  }
  
  var body: some View {
    VStack() {
      
      ForEach((1...7), id: \.self ) { _ in
        Spacer()
      }
      
      HStack {
        Spacer()
        
        SingleChordKeyboardView(
          text: "Lower Chord",
          multiChord: $multiChord,
          keyboard: $lowerKeyboard,
          color: color,
          isLower: true
        )
                
        Spacer()
        
        Text("+")
          .font(.title2)
          .fontWeight(.heavy)
          .foregroundStyle(Color("titleColor"))
          .zIndex(1.0)
        
        Spacer()
        
        SingleChordKeyboardView(
          text: "Upper Chord",
          multiChord: $multiChord,
          keyboard: $upperKeyboard,
          color: secondColor,
          isLower: false
        )
    
        Spacer()
      }

      ForEach((1...8), id: \.self ) { _ in
        Spacer()
      }
      
      Text("=")
        .font(.title2)
        .fontWeight(.heavy)
        .foregroundStyle(Color("titleColor"))
      
      Spacer()
      
      DualChordKeyboardView(
        text: "Combined Chord",
        multiChord: $multiChord,
        keyboard: $combinedKeyboard
      )
      
      ForEach((1...6), id: \.self ) { _ in
        Spacer()
      }
      
    }
    // MARK: modifiers
    .padding()
    .onAppear(perform: {
      setAndHighlightChords(initial: true)
    })
    .onChange(of: multiChord.lowerChord) {
      setAndHighlightChords(initial: false)
    }
    .onChange(of: multiChord.upperChord) {
      setAndHighlightChords(initial: false)
    }
  }
}

//  MARK: Preview
#Preview {
  MultiChordKeyboardView()
}
