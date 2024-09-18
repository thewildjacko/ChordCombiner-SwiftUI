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
      HStack {
        VStack(spacing: 5) {
          if let resultChord = multiChord.resultChord {
            Text(resultChord.commonName)
              .font(.title)
              .fontWeight(.heavy)
              .fixedSize()
              .foregroundStyle(Color("titleColor"))
            if resultChord.commonName != resultChord.preciseName {
              Text("(\(resultChord.preciseName))")
                .font(.caption)
              //            .fontWeight(.heavy)
                .fixedSize()
                .foregroundStyle(Color("titleColor"))
            }
          } else {
            Text("\(multiChord.upperChord.preciseName)/\(multiChord.lowerChord.preciseName)")
              .font(.title)
              .fontWeight(.heavy)
              .fixedSize()
              .foregroundStyle(Color("titleColor"))
          }
        }
        NavigationLink(destination: ChordDetailView(keyboard: $keyboard)) {
          Image(systemName: "info.circle")
            .font(.title3)
            .foregroundStyle(Color("titleColor"))
        }
      }
      keyboard
    }
  }
}

#Preview {
  DualChordKeyboardView(
    text: "Combined Chord:",
    keyboard: Binding.constant(Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)))
  .environmentObject(
    MultiChord(
      lowerChord: Chord(.c, .ma7, startingOctave: 4),
      upperChord: Chord(.d, .ma, startingOctave: 4)
    ))
}
