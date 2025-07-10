//
//  TensionDetailRow.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/27/25.
//

import SwiftUI

struct TensionDetailRow: View {
  var tensionResult: TensionResult
  var count: LocalizedStringKey { "**\(tensionResult.count)** × " }
  var score: LocalizedStringKey { "\(tensionResult.score)" }

  var body: some View {
    HStack {
      Text(count) +
      Text(tensionResult.tensionType) +
      Text(tensionResult.tensionScore)

      Spacer()

      Text(score)
    }
    .foregroundStyle(.title)
  }
}
