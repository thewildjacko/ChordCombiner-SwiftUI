//
//  ChordGrapherNavigationView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct ChordGrapherNavigationView: View {
  @Binding var chordGrapher: ChordGrapher?
  @Binding var disabled: Bool
  var text: String {
    disabled ? "loading Chord Graph..." : "view Chord Graph"
  }

  @ViewBuilder
  var body: some View {
    if let chordGrapher = chordGrapher {
      Group {
        NavigationLink(
          destination:
            ChordGraphImageView(chordGrapher: chordGrapher)
        ) {
          Text(text)
        }
        .disabled(disabled)
      }
    }
  }
}
