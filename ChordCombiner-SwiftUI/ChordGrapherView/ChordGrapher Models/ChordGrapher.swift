//
//  ChordGrapher.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/3/24.
//

import Foundation

struct ChordGrapher {
  enum ElementsContained {
    case all, triadsAndNotes, notes
  }

  private let chord: Chord

  let chordGrapherRelationships: ChordGrapherRelationships
  let chordGrapherAttributes: ChordGrapherAttributes

  init(chord: Chord) {
    self.chord = chord

    chordGrapherRelationships = ChordGrapherRelationships(
      parentChord: ChordGrapherParentChord(chord: chord)
    )

    chordGrapherAttributes = ChordGrapherAttributes(
      elementsContained: chordGrapherRelationships.parentChord.elementsContained
    )
  }

}
