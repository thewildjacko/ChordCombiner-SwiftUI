//
//  TensionCalculator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/24/25.
//

import SwiftUI
import Algorithms

// MARK: PitchIntervalStats
struct PitchIntervalStats: Hashable {
  var count: Int
  var score: Double
  var degree: Degree
}

// MARK: TensionCalculator
struct TensionCalculator: DegreeNumbers {
  static let initial: TensionCalculator = TensionCalculator(
    chordType: .ma,
    degrees: [],
    degreeNumbers: [],
    pitchNumbers: [])

  let degreeTensions: [Tension] = [
    .potentialHalfSteps,
    .potentialWholeSteps,
    .potentialMinor3rds,
    .potentialMajor3rds,
    .potentialPerfect4ths,
    .tritones
  ]

  let voicingTensions: [Tension] = [
    .halfSteps,
    .wholeSteps,
    .minor3rds,
    .major3rds,
    .perfect4ths,
    .tritones,
    .perfect5ths,
    .minor6ths,
    .major6ths,
    .minor7ths,
    .major7ths,
    .minor9ths,
    .major9ths
  ]

  var chordType: ChordType
  var degrees: [Degree]
  var degreeNumbers: [Int]
  var pitchNumbers: [Int]
}

extension TensionCalculator {
  // MARK: Potential intervals
  func potentialHalfSteps() -> PitchIntervalStats {
    degreeNumbersPlusOctave.pitchIntervalStats(degree: .minor2nd)
  }

  func potentialWholeSteps() -> PitchIntervalStats {
    degreeNumbersSorted.potentialPitchIntervalStats(degree: .major2nd)
  }

  func potentialMinor3rds() -> PitchIntervalStats {
    degreeNumbersSorted.potentialPitchIntervalStats(degree: .minor3rd)
  }

  func potentialMajor3rds() -> PitchIntervalStats {
    degreeNumbersSorted.potentialPitchIntervalStats(degree: .major3rd)
  }

  func potentialPerfect4ths() -> PitchIntervalStats {
    degreeNumbersSorted.potentialPitchIntervalStats(degree: .perfect4th)
  }

  // MARK: Voicing intervals
  func halfSteps() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .minor2nd)
  }

  func wholeSteps() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .major2nd)
  }

  func minor3rds() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .minor3rd)
  }

  func major3rds() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .major3rd)
  }

  func perfect4ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .perfect4th)
  }

  func tritones() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .diminished5th)
  }
  func perfect5ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .perfect5th)
  }

  func minor6ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .minor6th)
  }

  func major6ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .major6th)
  }

  func minor7ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .minor7th)
  }

  func major7ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .major7th)
  }

  func minor9ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .minor9th)
  }

  func major9ths() -> PitchIntervalStats {
    pitchNumbers.pitchIntervalStats(degree: .major9th)
  }

  // MARK: Interval Score
  func intervalScore(of degree: Degree, with count: Int) -> Double {
    degree.tensionScore * Double(count)
  }

  func pitchIntervalScore(of pitchIntervalStats: [PitchIntervalStats]) -> Double {
    let intervalScore: Double = pitchIntervalStats.map { $0.score }
      .reduce(0, +)

    return intervalScore + longestRunScore() + resolutionAmbiguityScore()
  }

  // MARK: Longest Run
  func longestRun(degreeNumbers: [Int]) -> Int {
    let count = degreeNumbers.count
    if count < 2 {
      return count
    }
    // https://developer.apple.com/forums/thread/128496?login=true
    // look through the array starting from the beginning for the first
    // element that breaks a sequential run.  that is, find the first
    // index with a = x[index] and b = x[index+1] where b != a + 1.
    // if found, the array has an opening run of length index + 1, and
    // we can recursively find the longest run among elements starting at b.
    // simply report the larger of the two.
    for index in 0...(count - 2)
    where degreeNumbers[index] + 1 != degreeNumbers[index + 1] {
      let degreeNumbersRemainder = Array(degreeNumbers[(index + 1)...(count - 1)])
      let longest = longestRun(degreeNumbers: degreeNumbersRemainder)
      return max(index + 1, longest)
    }
    // if no such sequential break was found, the array is already a sequential run
    return count
  }

  func longestRunScore() -> Double {
    let longest = Double(longestRun(degreeNumbers: degreeNumbersPlusOctave))
    return longest > 2 ? longest: 0
  }

  // MARK: Degree & Voicing Scores
  func degreeTensionScore() -> Double {
    let pitchIntervalStats = [
      potentialHalfSteps(),
      potentialWholeSteps(),
      potentialMinor3rds(),
      potentialMajor3rds(),
      potentialPerfect4ths(),
      tritones()
    ]

    return pitchIntervalScore(of: pitchIntervalStats)
  }

  func voicingTensionScore() -> Double {
    let pitchIntervalStats = [
      halfSteps(),
      wholeSteps(),
      minor3rds(),
      major3rds(),
      perfect4ths(),
      tritones(),
      perfect5ths(),
      minor6ths(),
      major6ths(),
      minor7ths(),
      major7ths(),
      minor9ths(),
      major9ths()
    ]

    return pitchIntervalScore(of: pitchIntervalStats)
  }

  // MARK: Result
  func result(_ tension: Tension) -> TensionResult {
    let pitchIntervalStats = [
      potentialHalfSteps(),
      potentialWholeSteps(),
      potentialMinor3rds(),
      potentialMajor3rds(),
      potentialPerfect4ths(),
      halfSteps(),
      wholeSteps(),
      minor3rds(),
      major3rds(),
      perfect4ths(),
      tritones(),
      perfect5ths(),
      minor6ths(),
      major6ths(),
      minor7ths(),
      major7ths(),
      minor9ths(),
      major9ths()
    ]

    let tensionDictionary: [Tension: PitchIntervalStats] = Dictionary(
      uniqueKeysWithValues: zip(Tension.allCases, pitchIntervalStats)
    )

    let count = tensionDictionary[tension]?.count ?? 0
    let tensionScore = tensionDictionary[tension]?.degree.tensionScore ?? 0
    let score = tensionDictionary[tension]?.score ?? 0
    let degreeName = (tensionDictionary[tension]?.degree.short ?? "")
    let inversionDegreeName = (tensionDictionary[tension]?.degree.inversion.short ?? "")

    var tensionType: LocalizedStringKey = ""

    switch tension {
    case .tritones:
      tensionType = "tritone"
    case .minor9ths:
      tensionType = LocalizedStringKey("\(degreeName) ⃰")
    case .major9ths:
      tensionType = LocalizedStringKey("\(degreeName)")
    default:
      switch tension {
      case .potentialHalfSteps, .potentialWholeSteps, .potentialMinor3rds,
          .potentialMajor3rds, .potentialPerfect4ths:
        tensionType = "\(degreeName) *or* \(inversionDegreeName)"
      default:
        tensionType = LocalizedStringKey("\(degreeName)")
      }
    }

    return TensionResult(
      count: count,
      score: score,
      tensionType: tensionType,
      tensionScore: tensionScore)
  }
}

extension TensionCalculator {
  func resolutionAmbiguityScore() -> Double {
    switch chordType.baseChordType {
    case .ma, .mi, .add4, .add2, .minorAdd4, .minorAdd2,
        .ma7, .mi7, .ma6:
      0
    case .ma7sus4:
      1
    case .mib6:
      2
    case .dim, .sus4, .sus2, .ma7sus4sh5, .dominant7sus2:
      4
    case .aug, .ma7b5, .ma7sh5, .ma7sh5sh11, .dominant7sus4:
      5
    case .dominant7, .dominant7b5, .dominant7sh5, .dim7,
        .dimMa7, .mi7b5, .mi6, .miMa7:
      6
    }
  }

  // TODO: chordTypeAmbiguityScore
  func chordTypeAmbiguityScore() -> Double {
    return 0
  }
}

extension TensionCalculator {
  func potentialHalfStepDegrees() -> [Degree] {
    let halfSteps = degrees.flatMap { $0.halfSteps() }
    let halfStepsInChord: [Degree] = halfSteps.filter { degrees.contains($0) }
      .sorted { $0.size.degreeNumberInOctave < $1.size.degreeNumberInOctave }

    return halfStepsInChord
  }
}
