//
//  ChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct ChordDetailView: View {
  var chord: Chord
  
  var body: some View {
    VStack {
      Text("\(chord.commonName)")
        .font(.largeTitle)
        .fontWeight(.heavy)
        .foregroundStyle(Color("titleColor"))
      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview {
    ChordDetailView(
      chord: Chord(.c, .ma))
}
