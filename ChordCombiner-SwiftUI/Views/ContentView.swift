//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/24/24.
//

import SwiftUI

enum Tab {
  case singleChord, multiChord, allChords
}

struct ContentView: View {
  @State private var selectedTab: Tab = .multiChord
  
  @State var cMa13sh11 = Chord(.c, .ma13_sh11)
  @State var chordDictionary: [Chord: [Chord]] = [Chord(.c, .ma13_sh11):Chord(.c, .ma13_sh11).containingChords()]
  
  let cMa9sh11 = Chord(.c, .ma9_sh11)
  let cMa9 = Chord(.c, .ma9)
  
  let cMa = Chord(.c, .ma)
  let cMa7 = Chord(.c, .ma7)
  
  var body: some View {
    NavigationStack {
      List {
        NavigationLink(
          destination:
            MultiChordKeyboardView()
            .navigationTitle("Chord Combiner")
        ) { Text("Chord Combiner") }
        
        NavigationLink(
          destination:
            AllChordsView()
            .navigationTitle("All Chords")
        ) {
          Text("All Chords")
        }
      }
      .navigationTitle("Harmony Brain")
    }
    .onAppear {
      cMa13sh11.recursiveContainingChords(usedChords: &cMa13sh11.usedChords, chordDictionary: &chordDictionary)
      
      var containsC: [String] = []
      
      for (key, value) in chordDictionary.filter({ $0.value.map {$0.preciseName }.contains("Cma")}) {
        containsC.append(key.preciseName)
//        print(key.preciseName)
//        print(value.map { $0.preciseName })
//        print("")
      }
      
//      print("Cma:", containsC)
//      print(cMa13sh11.containingChords().filter { $0.chordType.isTriad}.map({ $0.preciseName }))
//      print(cMa13sh11.containingChords().count)
//      print(cMa9sh11.containingChords().map({ $0.preciseName }))
//      print(cMa9sh11.containingChords().count)
//      print(cMa9.containingChords().map({ $0.preciseName }))
//      print(cMa9.containingChords().count)
    }
  }
}

#Preview {
  ContentView()
}
