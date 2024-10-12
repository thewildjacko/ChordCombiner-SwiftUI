//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  @EnvironmentObject var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        VStack(spacing: 5) {
          if let resultChord = multiChord.resultChord {
              TitleView(
                text: resultChord.root == multiChord.multiChordVoicingCalculator.lowerRoot ?
                resultChord.commonName :
                  "\(resultChord.commonName)/\(multiChord.multiChordVoicingCalculator.lowerRoot.noteName)",
                font: .title,
                weight: .heavy
              )
            if resultChord.commonName != resultChord.preciseName {
              TitleView(
                text: "(\(resultChord.preciseName))",
                font: .caption
              )
            }
          } else {
            TitleView(
              text: "\(multiChord.upperChord.preciseName)/\(multiChord.lowerChord.preciseName)",
              font: .title,
              weight: .heavy
            )
          }
        }
        NavigationLink(destination: DualChordDetailView(keyboard: $keyboard)) {
          Image(systemName: "info.circle")
            .font(.title3)
            .foregroundStyle(.title)
        }
      }
      keyboard
    }
  }
}

#Preview {
  DualChordKeyboardView(
    keyboard: Binding.constant(Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)))
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    ))
}
