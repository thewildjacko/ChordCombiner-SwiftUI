// Copyright (c) 2024 Kodeco Inc.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//  ChordGrapherView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/4/24.
//

import SwiftUI

struct ChordGrapherView: View {
//  @State private var image: Image?
  var chordGrapher: ChordGrapher = ChordGrapher(chord: Chord(.c, .ma9))

//  func makeURL() -> URL? {
//    var mapComponents = URLComponents()
//    mapComponents.scheme = "https"
//    mapComponents.host = "image-charts.com"
//    mapComponents.path = "/chart"
//
//    var chlItems: [String] = []
//
//    var innerChlItems: [String] {
//
//      var items: [String] = []
//
//      items.append(chordGrapher.chordGrapherAttributes.graphPrefix(edgeColor: "black"))
//      items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "house"))
//      items.append(chordGrapher.chordGrapherAttributes.fontSize())
//      items.append(chordGrapher.chordGrapherRelationships.parentChord.dotName)
//
//      items.append(chordGrapher.chordGrapherAttributes.arrowHead(type: "none"))
//
//      items.append(chordGrapher.chordGrapherAttributes.firstChildLevelNodeShape)
//      items.append(chordGrapher.chordGrapherRelationships.parentToFirstChildLevelString)
//
//      if chordGrapher.chordGrapherRelationships.parentChord.elementsContained != .notes {
//
//      }
//
//      items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "oval", width: 0.5))
//
//      chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
//        toItems: &items,
//        stringsToAppend: chordGrapher.chordGrapherRelationships.fourNoteChordsToTriadStrings
//      )
//
//      items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "circle", width: 0.5))
//
//      chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
//        toItems: &items,
//        stringsToAppend: chordGrapher.chordGrapherRelationships.noteToChordsStrings
//      )
//
//      chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
//        toItems: &items,
//        stringsToAppend: chordGrapher.chordGrapherRelationships.rankSameStrings)
//      return items
//    }
//
//    chlItems = innerChlItems
//    var chlItemsString: String {
//
//      return chordGrapher.chordGrapherAttributes.digraph +
//      chlItems.joined(separator: "; ").bracketedAndPadded()
//    }
//
//    let queryItemChl = URLQueryItem(name: "chl", value: chlItemsString)
//    let queryItemChs = URLQueryItem(name: "chs", value: "700x200")
//    let queryItemCht = URLQueryItem(name: "cht", value: "gv:dot")
//    let queryItemChof = URLQueryItem(name: "chof", value: ".png")
//
//    mapComponents.queryItems = [queryItemChl, queryItemChs, queryItemCht, queryItemChof]
//
////    print(chlItemsString)
//
//    let mapURL = mapComponents.url
//
//    return mapURL ?? nil
//  }

  var body: some View {
    ChordGraphImageView(chordGrapher: chordGrapher)
      .padding()
      .navigationTitle(chordGrapher.chordGrapherRelationships.parentChord.chord.preciseName)
  }
}

#Preview {
  ChordGrapherView()
}
