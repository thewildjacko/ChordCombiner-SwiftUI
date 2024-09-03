//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var text: String
  @EnvironmentObject var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  
  var body: some View {
    VStack(spacing: 20) {
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
    keyboard: Binding.constant(Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5))
  )
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    )
  )
}
