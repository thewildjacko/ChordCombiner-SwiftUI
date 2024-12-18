//
//  ChordGrapherView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/4/24.
//

import SwiftUI

struct ChordGrapherView: View {
  @State private var currentZoom = 0.0
  @State private var totalZoom = 1.0

  var chordGrapher: ChordGrapher = ChordGrapher(chord: Chord(.c, .ma9))

  func makeURL() -> URL? {
    var mapComponents = URLComponents()
    mapComponents.scheme = "https"
    mapComponents.host = "image-charts.com"
    mapComponents.path = "/chart"

    var chlItems: [String] = []

    let clock = ContinuousClock()
    let elapsed = clock.measure {

      var innerChlItems: [String] {

        var items: [String] = []

        items.append(chordGrapher.chordGrapherAttributes.graphPrefix(edgeColor: "black"))
        items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "house"))
        items.append(chordGrapher.chordGrapherRelationships.parentChord.dotName)

        items.append(chordGrapher.chordGrapherAttributes.arrowHead(type: "none"))

        items.append(chordGrapher.chordGrapherAttributes.firstChildLevelNodeShape)
        items.append(chordGrapher.chordGrapherRelationships.parentToFirstChildLevelString)

        if chordGrapher.chordGrapherRelationships.parentChord.elementsContained != .notes {

        }

        items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "oval", width: 0.5))

        chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
          toItems: &items,
          stringsToAppend: chordGrapher.chordGrapherRelationships.fourNoteChordsToTriadStrings
        )

        items.append(chordGrapher.chordGrapherAttributes.nodeShape(shape: "circle", width: 0.5))

        chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
          toItems: &items,
          stringsToAppend: chordGrapher.chordGrapherRelationships.noteToChordsStrings
        )

        chordGrapher.chordGrapherRelationships.appendRelationshipStrings(
          toItems: &items,
          stringsToAppend: chordGrapher.chordGrapherRelationships.rankSameStrings)
        return items
      }

      chlItems = innerChlItems
    }

    print("It took \(elapsed) to build the URL")

    var chlItemsString: String {

      return chordGrapher.chordGrapherAttributes.digraph +
      chlItems.joined(separator: "; ").bracketedAndPadded()
    }

    let queryItemChl = URLQueryItem(name: "chl", value: chlItemsString)
    let queryItemChs = URLQueryItem(name: "chs", value: "700x200")
    let queryItemCht = URLQueryItem(name: "cht", value: "gv:dot")
    let queryItemChof = URLQueryItem(name: "chof", value: ".png")

    mapComponents.queryItems = [queryItemChl, queryItemChs, queryItemCht, queryItemChof]

    print(chlItemsString)
    //    print(mapComponents.url!)

    let mapURL = mapComponents.url!

    return mapURL
  }

  // TODO: ERROR HANDLING
  @ViewBuilder
  func imageView(url: URL?) -> some View {
    if let url = url {
      AsyncImage(url: url) { image in
        image
          .resizable()
          .scaledToFit()
        //        .aspectRatio(contentMode: .fit)
          .scaleEffect(currentZoom + totalZoom)
          .gesture(
            MagnifyGesture()
              .onChanged { value in
                currentZoom = value.magnification - 1
              }
              .onEnded { _ in
                totalZoom += currentZoom
                currentZoom = 0
              }
          )
          .accessibilityZoomAction { action in
            if action.direction == .zoomIn {
              totalZoom += 1
            } else {
              totalZoom -= 1
            }
          }

      } placeholder: {
        ProgressView()
          .frame(alignment: .center)
      }
    } else {
      // error view with error message
      Text("Error: URL Incorrect")
    }
  }

  var body: some View {
    ScrollView([.horizontal, .vertical]) {
      imageView(url: makeURL())
    }
    .frame(maxHeight: .infinity)
    .padding()
  }
}

#Preview {
  ChordGrapherView()
}
