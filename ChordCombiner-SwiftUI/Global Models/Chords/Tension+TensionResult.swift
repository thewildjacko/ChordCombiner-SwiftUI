//
//  Tension.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/27/25.
//

import SwiftUI

// MARK: Tension
enum Tension: CaseIterable {
  case potentialHalfSteps
  case potentialWholeSteps
  case potentialMinor3rds
  case potentialMajor3rds
  case potentialPerfect4ths
  case halfSteps
  case wholeSteps
  case minor3rds
  case major3rds
  case perfect4ths
  case tritones
  case perfect5ths
  case minor6ths
  case major6ths
  case minor7ths
  case major7ths
  case minor9ths
  case major9ths
}

// MARK: TensionResult
struct TensionResult {
  var count: Int
  var doubleScore: Double
  var tensionType: LocalizedStringKey
  var doubleTensionScore: Double

  var score: String { String(format: "%.2f", doubleScore) }
  var stringTensionScore: String { String(format: "%.2f", doubleTensionScore) }
  var tensionScore: LocalizedStringKey { " × **\(stringTensionScore)**" }

  init(
    count: Int,
    score: Double,
    tensionType: LocalizedStringKey,
    tensionScore: Double) {
      self.count = count
      self.doubleScore = score
      self.tensionType = tensionType
      self.doubleTensionScore = tensionScore
  }
}

struct TensionPreview: View {
  var body: some View {
    List {
      ForEach(ChordFactory.allChordsInC.sorted(by: { $0.tensionCalculator.voicingTensionScore() <
        $1.tensionCalculator.voicingTensionScore() })) { chord in

        let dTS = String(format: "%.2f", chord.tensionCalculator.degreeTensionScore())
        let vTS = String(format: "%.2f", chord.tensionCalculator.voicingTensionScore())
          VStack(alignment: .leading) {
            Text("\(chord.details.preciseName):")
            HStack {
              Spacer()
              Text("dTS: \(dTS)")
              Text("vTS: \(vTS)")
            }
          }
      }
    }
  }
}

#Preview {
  TensionPreview()
}
