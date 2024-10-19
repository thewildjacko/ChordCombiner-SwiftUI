//
//  KeyboardDisplayView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayView: View {
  var chord: Chord
  @State var keyboard: Keyboard
//  = Keyboard(
//    geoWidth: 250,
//    initialKey: .C,
//    startingOctave: 4,
//    octaves: 2,
//    glowColor: .clear,
//    glowRadius: 0
//  )
  var geoWidth: CGFloat = 150
  var initialKey: KeyType = .C
  var startingOctave: Int = 4
  var octaves: Int = 2
  var color: Color
  var glowColor: Color = .yellow
  var glowRadius: CGFloat = 5
  
  init(
    chord: Chord,
    keyboard: Keyboard,
    geoWidth: CGFloat = 250,
    initialKey: KeyType = .C,
    startingOctave: Int = 4,
    octaves: Int = 2,
    color: Color,
    glowColor: Color = .yellow,
    glowRadius: CGFloat = 10
  ) {
    self.chord = chord
    self.geoWidth = geoWidth
    self.initialKey = initialKey
    self.startingOctave = startingOctave
    self.octaves = octaves
    self.color = color
    self.glowColor = glowColor
    self.glowRadius = glowRadius
    
    self.keyboard = Keyboard(
      geoWidth: geoWidth,
      initialKey: initialKey,
      startingOctave: startingOctave,
      octaves: octaves,
      glowColor: glowColor,
      glowRadius: glowRadius
      )
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      TitleView(text: chord.preciseName, font: .title2, weight: .heavy)
      
      keyboard
//        .border(.red)
    }
    //    .glow(color: glowColor, radius: glowRadius)
    .onAppear {
      print(glowColor)
      print(glowRadius)
      keyboard = Keyboard(
        geoWidth: geoWidth,
        initialKey: initialKey,
        startingOctave: startingOctave,
        octaves: octaves,
        glowColor: glowColor,
        glowRadius: glowRadius,
        chord: chord,
        color: color
      )
//      keyboard.highlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
    }
    .onChange(of: chord) { oldValue, newValue in
      keyboard.toggleHighlightKeysSingle(degs: oldValue.voicingCalculator.stackedPitches, color: color)
      keyboard.toggleHighlightKeysSingle(degs: newValue.voicingCalculator.stackedPitches, color: color)
    }
  }
}

#Preview {
  KeyboardDisplayView(
    chord: Chord(.c, .ma),
    keyboard:
      Keyboard(
        geoWidth: 250,
        initialKey: .C,
        startingOctave: 4,
        octaves: 3),
    color: .yellow)
}
