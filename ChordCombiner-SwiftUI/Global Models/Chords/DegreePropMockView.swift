//
//  DegreePropMockView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/25/25.
//

import SwiftUI

struct DegreePropMockView: View {
  let degreeNumbers = [0, 3, 4, 7, 8, 10]
  let pitchNumbers = [60, 64, 67, 70, 75, 80]
  var chord = Chord(.b, .dim11b13addMa7)
  var tensionCalculator: TensionCalculator {
    TensionCalculator(
      chordType: chord.chordType,
      degrees: chord.details.degrees,
      degreeNumbers: degreeNumbers,
      pitchNumbers: pitchNumbers
      )
  }

  var degrees: [Degree] = [
    .root,
    .minor9th,
    .major9th,
    .sharp9th,
    .minor3rd,
    .major3rd,
    .perfect4th,
    .sharp4th,
    .diminished5th,
    .perfect5th,
    .sharp5th,
    .minor6th,
    .major6th,
    .diminished7th,
    .minor7th,
    .major7th,
    .octave
  ]

  var textNumber: Int {
    let num1 = 1
    let num2 = 0

    let diff = num2.minusDegreeNumber(num1)

    return diff
  }

  var body: some View {
    Text(degreeNumbers.description)
    Text(pitchNumbers.description)
    Text("Base Tension Score: \(tensionCalculator.degreeTensionScore())")
    Text("Tension Score: \(tensionCalculator.voicingTensionScore())")
    Text("Potential Half Steps: \(tensionCalculator.potentialHalfSteps())")
    Text("Half Steps: \(tensionCalculator.halfSteps())")
    Text("Tritones: \(tensionCalculator.tritones())")
    Text("Minor 9ths: \(tensionCalculator.minor9ths().count)")
    Text("Minor 9th Score: \(tensionCalculator.minor9ths().score)")
    Text("Longest Run Score: \(tensionCalculator.longestRunScore())")
    List {
      ForEach(degrees, id: \.self) { degree in
        VStack(alignment: .leading) {
          Text("\(degree.name):")
          Text("\(degree.tritones().map { $0.name }))")
        }
      }
    }
  }
}

#Preview {
  DegreePropMockView()
}
