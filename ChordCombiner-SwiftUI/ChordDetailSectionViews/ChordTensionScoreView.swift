//
//  ChordTensionScoreView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/25/25.
//

import SwiftUI

struct TensionScoreDisclosureGroup: View {
  let title: String
  let tensions: [Tension]
  let chord: Chord
  let score: String

  var resolutionAmbiguityScore: String {
    String(format: "%.2f", chord.tensionCalculator.resolutionAmbiguityScore())
  }

  var longestRunScore: String {
    String(format: "%.2f", chord.tensionCalculator.longestRunScore())
  }

  var body: some View {
    DisclosureGroup {
      ForEach(tensions, id: \.self) { tension in
        if chord.tensionCalculator.result(tension).count != 0 {
          TensionDetailRow(tensionResult: chord.tensionCalculator.result(tension))
        }
      }
      HStack {
        Text("longest ½ step run:")
        Spacer()
        Text(longestRunScore)
      }

      HStack {
        Text("resolution ambiguity:")
        Spacer()
        Text(resolutionAmbiguityScore)
      }
    } label: {
      HStack {
        Text(title)
          .bold()
        Spacer()
        Text(score)
      }
    }
  }
}

struct ChordTensionScoreView: View {
  @State var isExpanded: Bool = false

  let chord: Chord

  var dTS: String { String(format: "%.2f", chord.tensionCalculator.degreeTensionScore()) }
  var vTS: String { String(format: "%.2f", chord.tensionCalculator.voicingTensionScore()) }

  @ViewBuilder
  var body: some View {
    DisclosureGroup(isExpanded: $isExpanded) {
      List {
        TensionScoreDisclosureGroup(
          title: "Degree Score",
          tensions: chord.tensionCalculator.degreeTensions,
          chord: chord,
          score: dTS)

        TensionScoreDisclosureGroup(
          title: "Voicing Score",
          tensions: chord.tensionCalculator.voicingTensions,
          chord: chord,
          score: vTS)
      }
    } label: {
      DetailRow(title: "Tension Scores", text: "\(dTS) / \(vTS)")
    }
  }
}

#Preview {
  ChordTensionScoreView(chord: Chord.initial)
}
