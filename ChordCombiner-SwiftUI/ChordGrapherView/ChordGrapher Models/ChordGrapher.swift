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
      elementsContained: chordGrapherRelationships.parentChord.elementsContained,
      rowElementsMax: chordGrapherRelationships.rowElementsMax
    )
  }

  static func getChordGrapher(chord: Chord?) async -> ChordGrapher? {
    guard let chord = chord else {
      return nil
    }

    let task = Task { return ChordGrapher(chord: chord) }
    print(await task.value.chord.preciseName)
    return await task.value
  }
}

extension ChordGrapher {
  func makeURL() -> URL? {
    var mapComponents = URLComponents()
    mapComponents.scheme = "https"
    mapComponents.host = "image-charts.com"
    mapComponents.path = "/chart"

    var chlItems: [String] = []

    var innerChlItems: [String] {

      var items: [String] = []

      items.append(chordGrapherAttributes.graphPrefix(edgeColor: "black"))
      items.append(chordGrapherAttributes.nodeShape(shape: "house"))
      items.append(chordGrapherAttributes.fontSize())
      items.append(chordGrapherRelationships.parentChord.dotName)

      items.append(chordGrapherAttributes.arrowHead(type: "none"))

      items.append(chordGrapherAttributes.firstChildLevelNodeShape)
      items.append(chordGrapherRelationships.parentToFirstChildLevelString)

      if chordGrapherRelationships.parentChord.elementsContained != .notes {

      }

      items.append(chordGrapherAttributes.nodeShape(shape: "oval", width: 0.5))

      chordGrapherRelationships.appendRelationshipStrings(
        toItems: &items,
        stringsToAppend: chordGrapherRelationships.fourNoteChordsToTriadStrings
      )

      items.append(chordGrapherAttributes.nodeShape(shape: "circle", width: 0.5))

      chordGrapherRelationships.appendRelationshipStrings(
        toItems: &items,
        stringsToAppend: chordGrapherRelationships.noteToChordsStrings
      )

      chordGrapherRelationships.appendRelationshipStrings(
        toItems: &items,
        stringsToAppend: chordGrapherRelationships.rankSameStrings)
      return items
    }

    chlItems = innerChlItems
    var chlItemsString: String {

      return chordGrapherAttributes.digraph +
      chlItems.joined(separator: "; ").bracketedAndPadded()
    }

    let queryItemChl = URLQueryItem(name: "chl", value: chlItemsString)
    let queryItemChs = URLQueryItem(name: "chs", value: "700x200")
    let queryItemCht = URLQueryItem(name: "cht", value: "gv:dot")
    let queryItemChof = URLQueryItem(name: "chof", value: ".png")

    mapComponents.queryItems = [queryItemChl, queryItemChs, queryItemCht, queryItemChof]

//    print(chlItemsString)

    let mapURL = mapComponents.url

    return mapURL ?? nil
  }
}
