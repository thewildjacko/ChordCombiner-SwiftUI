//
//  ChordTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ContentView: View {
  @State var multiChord = MultiChord(
    lowerChord: Chord(.c, .ma7),
    upperChord: Chord(.d, .ma)
  )
  
  @State var lowerChord: Chord = Chord(.c, .ma13_sh11)
  @State var upperChord: Chord = Chord(.a, .ma13_sh11)
  @State var resultChord: Chord?
  @State var oldLowerChord: Chord = Chord(.c, .ma13_sh11)
  @State var oldUpperChord: Chord = Chord(.a, .ma13_sh11)
  @State var oldResultChord: Chord?
  @State var onlyInLower: [Int] = []
  @State var onlyInUpper: [Int] = []
  @State var commonToneDegs: [Int] = []
  
  @State var equivalentChords: [Chord] = []
  @State var deltaChords: [Chord] = []
  @State var kb3: Keyboard = Keyboard(title: "Combined Chord", geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
  
  func highlightResult(startingOctave: Int, lowerChord: Chord, upperChord: Chord, result: Chord?) {
    let startingPitch = kb3.startingPitch
    let lowerRoot = lowerChord.root
    let upperRoot = upperChord.root
    
    let lowerPitch = lowerRoot.num.toPitch(startingOctave: startingOctave)
      .raiseAbove(pitch: startingPitch, degs: nil)
    
    let lowerBaseChordDegs = lowerChord.type.baseChord(root: lowerRoot).degrees.map {
      $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: startingPitch, degs: nil)
    }
    
    var upperPitch: Int
    
    if let _ = result {
      upperPitch = upperChord.root.num.toPitch(startingOctave: startingOctave).raiseAbove(pitch: startingPitch, degs: nil)
      
      var lowerDegs = lowerChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: lowerPitch, degs: nil)
      }
      
      lowerDegs = lowerDegs.map {
        $0.raiseAboveDegreesIfAbsent(lowerBaseChordDegs)
      }
      
      let lowerDegsMax = lowerDegs.max() ?? 0
      
      let upperDegs = upperChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: lowerDegsMax, degs: lowerDegs)
      }
      
      onlyInLower = Array(lowerDegs.toSet().subtracting(upperDegs))
      onlyInUpper = Array(upperDegs.toSet().subtracting(lowerDegs))
      commonToneDegs = Array(lowerDegs.toSet().intersection(upperDegs))
      
      kb3.highlightKeys(degs: onlyInLower, color: .yellow)
      kb3.highlightKeys(degs: onlyInUpper, color: .cyan)
      kb3.highlightKeys(degs: commonToneDegs, color: LinearGradient.commonTone(.cyan, .yellow))
    } else {
      
      var lowerDegs = lowerChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: lowerPitch, degs: nil)
      }
      
      lowerDegs = lowerDegs.map {
        $0.raiseAboveDegreesIfAbsent(lowerBaseChordDegs)
      }
      
      let lowerDegsMax = lowerDegs.max() ?? 0
//      print("lower degs:", lowerDegs, "lowerDegsMax:", lowerDegsMax)
             
      upperPitch = upperChord.root.num.toPitch(startingOctave: startingOctave).raiseAbove(pitch: lowerDegsMax, degs: nil)
//     print("upper pitch:", upperPitch)
      
      var upperDegs = upperChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
      }
//      print(upperDegs)
      
      upperDegs = upperDegs.map {
        $0.raiseAbove(pitch: upperPitch, degs: nil)
      }
      
      let upperDegsMin = upperDegs.min() ?? 0
      let upperDegsMax = upperDegs.max() ?? 0
      
      var upperBaseChordDegs: [Int] = []
//      print(upperDegs)
      if upperDegsMin == lowerDegsMax {
//        print("raising again!")
        upperDegs = upperDegs.map {
          $0.raiseAbove(pitch: upperDegsMax + 1, degs: nil)
        }
        
        upperBaseChordDegs = upperChord.type.baseChord(root: upperRoot).degrees.map {
          $0.toPitch(startingOctave: startingOctave)
            .raiseAbove(pitch: upperPitch, degs: nil)
            .raiseAbove(pitch: upperDegsMax + 1, degs: nil)
        }
        
      } else {
        upperBaseChordDegs = upperChord.type.baseChord(root: upperRoot).degrees.map {
          $0.toPitch(startingOctave: startingOctave)
            .raiseAbove(pitch: upperPitch, degs: nil)
        }
      }
      
      upperDegs = upperDegs.map {
        $0.raiseAboveDegreesIfAbsent(upperBaseChordDegs)
      }

//        .map {
//        ($0 + 12).raiseAbove(pitch: lowerDegsMax, degs: lowerDegs)
//      }
      
      kb3.highlightKeys(degs: lowerDegs, color: .yellow)
      kb3.highlightKeys(degs: upperDegs, color: .cyan)
    }
  }
  
  func setAndHighlightChords(initial: Bool) {
    resultChord = ChordFactory.combineChords(lowerChord, upperChord).resultChord
    equivalentChords = ChordFactory.combineChords(lowerChord, upperChord).equivalentChords
    
    if initial {
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: lowerChord, upperChord: upperChord, result: resultChord)
    } else {
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: oldLowerChord, upperChord: oldUpperChord, result: oldResultChord)
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: lowerChord, upperChord: upperChord, result: resultChord)
    }
    
    oldLowerChord = lowerChord
    oldUpperChord = upperChord
    oldResultChord = resultChord
  }
  
  var body: some View {
    VStack(spacing: 30) {
      
      Spacer()
      
      HStack(spacing: 90) {
        ChordMenu(text: "Lower Chord", chord: $lowerChord)
        ChordMenu(text: "Upper Chord", chord: $upperChord)
      }
      .padding()
      
      List {
        Section(header: Text("Combined Chord")) {
          VStack {
            if let resultChord = resultChord {
              Text(resultChord.name)
            } else {
              Text("\(upperChord.name)/\(lowerChord.name)")
            }
            
            kb3
          }
        }
        
        if !equivalentChords.isEmpty {
          Section(header: Text("Equivalent Chords")) {
            ForEach(equivalentChords, id: \.id) { chord in
              Text(chord.name)
            }
          }
        }
      }
      .scrollContentBackground(.hidden)
      Spacer()
    }
    .onAppear(perform: {
      setAndHighlightChords(initial: true)
//      print(lowerChord.type.baseChord(root: lowerChord.root).degrees)
//      print(upperChord.type.baseChord(root: upperChord.root).degrees)
    })
    .onChange(of: lowerChord) { oldLower, newLower in
      setAndHighlightChords(initial: false)
//      print(lowerChord.type.baseChord(root: lowerChord.root).degrees)
//      print(upperChord.type.baseChord(root: upperChord.root).degrees)
    }
    .onChange(of: upperChord) { oldUpper, newUpper in
      setAndHighlightChords(initial: false)
//      print(lowerChord.type.baseChord(root: lowerChord.root).degrees)
//      print(upperChord.type.baseChord(root: upperChord.root).degrees)
    }
  }
}


#Preview {
  ContentView()
}
