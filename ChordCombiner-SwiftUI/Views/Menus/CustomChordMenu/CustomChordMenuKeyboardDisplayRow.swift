//
//  CustomChordMenuKeyboardDisplayRow.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/20/24.
//

import SwiftUI

struct CustomChordMenuKeyboardDisplayRow: View {
  @Binding var selectedChordType: ChordType?
  @Binding var matchingChordTypes: Set<ChordType>
  
  var chordType: ChordType
  var titleText: String
  var titleColor: Color
  var glowColor: Color
  var glowRadius: CGFloat
  var chord: Chord?
  var keyboardColor: Color?
  
  var keyboard: Keyboard {
    if let chord = chord, let keyboardColor = keyboardColor {
      Keyboard(
        geoWidth: 150,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 2,
        glowColor: glowColor,
        glowRadius: glowRadius,
        chord: chord,
        color: keyboardColor
      )
    } else {
      Keyboard(
        geoWidth: 150,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 2
      )
    }
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      VStack(alignment: .leading, spacing: 10) {
        TitleView(
          text: titleText,
          font: .title3, weight: .heavy,
          color: titleColor
        )
        
        keyboard
      }
      .onTapGesture { selectedChordType = chordType }
      
      Spacer()
      
      if matchingChordTypes.contains(chordType) {
        TitleView(text: "match found!", font: .caption, weight: .bold, color: .glowText)
      }
    }
  }
}
