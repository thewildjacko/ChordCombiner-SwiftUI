//
//  CombinedChordHighlightPitches.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/16/24.
//
import Foundation

struct CombinedChordHighlightPitches {
  let startingPitch: Int

  var lower: [Int]
  var upper: [Int]
  var common: [Int]

  var combined: [Int] { lower + upper + common }
  var combinedSorted: [Int] { combined.sorted() }

  mutating func raiseAbove() {
    if let minPitch = combined.min() {
      var tempMinPitch = minPitch

      while tempMinPitch < startingPitch {
        lower.raiseAllBy(12)
        upper.raiseAllBy(12)
        common.raiseAllBy(12)
        tempMinPitch += 12
      }
    }
  }

  mutating func pivotCombinedPitchesAround(
    degreeSize: Int,
    slashChordBassNoteRaisedPitch: Int,
    rootRaisedPitch: Int) {
    if degreeSize < 17 {
      lower.pivotAround(
        pivotPitch: slashChordBassNoteRaisedPitch,
        raiseUp: true
      )
      upper.pivotAround(
        pivotPitch: slashChordBassNoteRaisedPitch,
        raiseUp: true
      )
      common.pivotAround(
        pivotPitch: slashChordBassNoteRaisedPitch,
        raiseUp: true
      )
    } else {
      let dividingPitch = rootRaisedPitch + degreeSize - 1

      lower.pivot(
        around: rootRaisedPitch,
        with: dividingPitch,
        raiseUp: false
      )
      upper.pivot(
        around: rootRaisedPitch,
        with: dividingPitch,
        raiseUp: false
      )
      common.pivot(
        around: rootRaisedPitch,
        with: dividingPitch,
        raiseUp: false
      )
    }
  }
}
