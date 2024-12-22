//
//  ChordGrapherNavigationView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct ChordGrapherNavigationView: View {
  @Binding var chordGrapher: ChordGrapher?
  @Binding var grapherLoaded: Bool
  var text: String {
    grapherLoaded ? "loading graph..." : "view graph"
  }

  @ViewBuilder
  var body: some View {
    Section(header: Text("Chord Graph")) {
      List {
        if let chordGrapher = chordGrapher {
          NavigationLink(
            destination:
              ChordGraphImageView(chordGrapher: chordGrapher)
          ) {
            TitleView(
              text: text,
              font: .body,
              weight: .bold)
          }
        } else {
          TitleView(
            text: text,
            font: .body,
            weight: .regular)
        }
      }
    }
  }
}
