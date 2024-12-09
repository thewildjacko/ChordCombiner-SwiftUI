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
  
  let chordGrapher = ChordGrapher(chord: Chord(.c, .dim11_b13_add_ma7))
  
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
        
        
        
        chordGrapher.chordGrapherRelationships.appendRelationshipStrings(toItems: &items, stringsToAppend: chordGrapher.chordGrapherRelationships.rankSameStrings)
        return items
      }
      
      chlItems = innerChlItems
    }
    
    print("It took \(elapsed) to build the URL")
    
    var chlItemsString: String {
//            return "digraph { ordering=out ratio=1.0 edge [color=\"black\"] charset=\"utf8\"; node [shape=house]; \"C&#186;11(b13add ma7)\"; edge [arrowhead=none]; node [shape=rectangle width=0.5]; \"C&#186;11(b13add ma7)\" -> { \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"B7\" \"B7(b5)\" \"Bmi7\" \"Bmi7(b5)\" \"B&#186;7\" \"B6\" \"Bmi6\" \"D7\" \"D7(b5)\" \"Dmi7\" \"Dmi7(b5)\" \"D&#186;7\" \"D6\" \"Dmi6\" \"F7\" \"F7(b5)\" \"Fmi7\" \"Fmi7(b5)\" \"F&#186;7\" \"F6\" \"Fmi6\" \"Ab7\" \"Ab7(b5)\" \"Abmi7\" \"Abmi7(b5)\" \"Ab&#186;7\" \"Ab6\" \"Abmi6\" }; node [shape=oval width=0.5]; { \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"Ab7\" } -> \"C&#186;\"; { \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"B7\" } -> \"Eb&#186;\"; { \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"D7\" } -> \"Gb&#186;\"; { \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"F7\" } -> \"A&#186;\"; { \"B7\" \"B6\" \"Abmi7\" } -> \"Bma\"; { \"Bmi7\" \"Bmi6\" \"D6\" \"Abmi7(b5)\" } -> \"Bmi\"; { \"Bmi7(b5)\" \"B&#186;7\" \"D&#186;7\" \"Dmi6\" \"F&#186;7\" \"Ab&#186;7\" } -> \"B&#186;\"; { \"Bmi7\" \"D7\" \"D6\" } -> \"Dma\"; { \"Bmi7(b5)\" \"Dmi7\" \"Dmi6\" \"F6\" } -> \"Dmi\"; { \"B&#186;7\" \"Dmi7(b5)\" \"D&#186;7\" \"F&#186;7\" \"Fmi6\" \"Ab&#186;7\" } -> \"D&#186;\"; { \"Dmi7\" \"F7\" \"F6\" } -> \"Fma\"; { \"Dmi7(b5)\" \"Fmi7\" \"Fmi6\" \"Ab6\" } -> \"Fmi\"; { \"B&#186;7\" \"D&#186;7\" \"Fmi7(b5)\" \"F&#186;7\" \"Ab&#186;7\" \"Abmi6\" } -> \"F&#186;\"; { \"Fmi7\" \"Ab7\" \"Ab6\" } -> \"Abma\"; { \"B6\" \"Fmi7(b5)\" \"Abmi7\" \"Abmi6\" } -> \"Abmi\"; { \"B&#186;7\" \"Bmi6\" \"D&#186;7\" \"F&#186;7\" \"Abmi7(b5)\" \"Ab&#186;7\" } -> \"Ab&#186;\"; node [shape=circle width=0.5]; { \"D7(b5)\" \"Ab7(b5)\" \"C&#186;\" \"Gb&#186;\" \"A&#186;\" \"Fma\" \"Fmi\" \"Abma\" } -> \"C\"; { \"B7(b5)\" \"F7(b5)\" \"C&#186;\" \"Eb&#186;\" \"A&#186;\" \"Bma\" \"Abma\" \"Abmi\" } -> \"Eb\"; { \"D7(b5)\" \"Ab7(b5)\" \"C&#186;\" \"Eb&#186;\" \"Gb&#186;\" \"Bma\" \"Bmi\" \"Dma\" } -> \"Gb\"; { \"B7(b5)\" \"F7(b5)\" \"Eb&#186;\" \"Gb&#186;\" \"A&#186;\" \"Dma\" \"Dmi\" \"Fma\" } -> \"Bbb\"; { \"B7(b5)\" \"F7(b5)\" \"Bma\" \"Bmi\" \"B&#186;\" \"F&#186;\" \"Abmi\" \"Ab&#186;\" } -> \"B\"; { \"D7(b5)\" \"Ab7(b5)\" \"Bmi\" \"B&#186;\" \"Dma\" \"Dmi\" \"D&#186;\" \"Ab&#186;\" } -> \"D\"; { \"B7(b5)\" \"F7(b5)\" \"B&#186;\" \"Dmi\" \"D&#186;\" \"Fma\" \"Fmi\" \"F&#186;\" } -> \"F\"; { \"D7(b5)\" \"Ab7(b5)\" \"D&#186;\" \"Fmi\" \"F&#186;\" \"Abma\" \"Abmi\" \"Ab&#186;\" } -> \"Ab\"; { rank=same; \"C\" \"Eb\" \"Gb\" \"Bbb\" \"B\" \"D\" \"F\" \"Ab\" }; { rank=same; \"C&#186;7\" \"Eb&#186;7\" \"Gb&#186;7\" \"A&#186;7\" \"B7\" \"B7(b5)\" \"Bmi7\" \"Bmi7(b5)\" \"B&#186;7\" \"B6\" \"Bmi6\" \"D7\" \"D7(b5)\" \"Dmi7\" \"Dmi7(b5)\" \"D&#186;7\" \"D6\" \"Dmi6\" \"F7\" \"F7(b5)\" \"Fmi7\" \"Fmi7(b5)\" \"F&#186;7\" \"F6\" \"Fmi6\" \"Ab7\" \"Ab7(b5)\" \"Abmi7\" \"Abmi7(b5)\" \"Ab&#186;7\" \"Ab6\" \"Abmi6\" }; { rank=same; \"C&#186;\" \"Eb&#186;\" \"Gb&#186;\" \"A&#186;\" \"Bma\" \"Bmi\" \"B&#186;\" \"Dma\" \"Dmi\" \"D&#186;\" \"Fma\" \"Fmi\" \"F&#186;\" \"Abma\" \"Abmi\" \"Ab&#186;\" } }"
      
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
              .onEnded { value in
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
    //    .onAppear {
    //      print(chordGrapher.parentToFourNoteSimpleChords)
    //      print(chordGrapher.fourNoteSimpleChords.map { $0.preciseName })
    //      print(chordGrapher.triads.map { $0.preciseName })
    //      print(chordGrapher.parentChord.notes.map { $0.degree.size } )
    //
    //      for i in (0..<chordGrapher.triads.count) {
    //        print("{ \(chordGrapher.fnsChordsByTriad[i].map { $0.preciseName }) } -> \(chordGrapher.triads[i].preciseName)")
    ////        for chords in chordGrapher.fnsChordsByTriad {
    ////          print(chords.map { $0.preciseName })
    ////        }
    //      }
    //
    //      for chords in chordGrapher.triadsByNote {
    //        print(chords.map { $0.preciseName })
    //      }
    //    }
  }
}

#Preview {
  ChordGrapherView()
}


//    let queryItemChl = URLQueryItem(name: "chl",
//                                    value: "digraph { ordering=out edge [color=\"red\"] charset=\"utf8\"; \"Cma13#11\" -> {\"Cma9#11\" Emi11}; \"Cma9#11\" -> {Cma9 Emi9}; Emi11 -> { Emi9 Gma9}; Emi9 -> { Emi7 Gma7}; Gma9 -> { Gma7 Bmi7 }; Cma9 -> {Cma7 Emi7 Csus2 Gsus4 }; edge [color=\"black\"]; Cma7 -> { Cma Emi }; Emi7 -> { Emi Gma}; Gma7 -> { Gma Bmi }; Bmi7 -> { Bmi Dma }; Csus2 -> Gsus4; Cma7 -> Emi7 -> Cma9 [color=green,penwidth=1.5]; Csus2 -> Cma7 -> Cma9 [color=green,penwidth=1.5]; Cma -> Emi -> Gma -> Cma9 [color=green,penwidth=1.5]; edge [style=dotted]; node [shape=circle width=0.5] { Cma Csus2 Gsus4} -> C; { Cma Emi } -> E; { Cma Emi Gma Gsus4 Csus2} -> G; { Emi Gma} -> B; { Gma Gsus4 Csus2} -> D; Bmi -> { B D \"F#\"}; Dma -> { D \"F#\" A}; { rank=same; Cma7 Emi7 } { rank=same; Cma Emi Gma Csus2 Gsus4 } { rank=same; C E G B D } }")
