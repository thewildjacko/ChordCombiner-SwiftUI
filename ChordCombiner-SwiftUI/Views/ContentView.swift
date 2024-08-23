//
//  ContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ContentView: View {
  @State var multiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  
  @State var oldMultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  
  @State var onlyInLower: [Int] = []
  @State var onlyInUpper: [Int] = []
  @State var commonToneDegs: [Int] = []
  
  @State var equivalentChords: [Chord] = []
  @State var deltaChords: [Chord] = []
  @State var kb3: Keyboard = Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
  
  func highlightResult(startingOctave: Int, lowerChord: Chord, upperChord: Chord, result: Chord?) {
    let startingPitch = kb3.startingPitch
    let lowerRoot = lowerChord.root
    let upperRoot = upperChord.root
    
    let lowerPitch = lowerRoot.basePitchNum.toPitch(startingOctave: startingOctave)
      .raiseAbove(pitch: startingPitch, degs: nil)
    
    let lowerBaseChordDegs = lowerChord.type.baseChord(root: lowerRoot).degrees.map {
      $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: startingPitch, degs: nil)
    }
    
    var upperPitch: Int
    
    if let _ = result {
      upperPitch = upperChord.root.basePitchNum.toPitch(startingOctave: startingOctave).raiseAbove(pitch: startingPitch, degs: nil)
      
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
             
      upperPitch = upperChord.root.basePitchNum.toPitch(startingOctave: startingOctave).raiseAbove(pitch: lowerDegsMax, degs: nil)
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
    multiChord.resultChord = ChordFactory.combineChords(multiChord.lowerChord, multiChord.upperChord).resultChord
    equivalentChords = ChordFactory.combineChords(multiChord.lowerChord, multiChord.upperChord).equivalentChords
    
    if initial {
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: multiChord.lowerChord, upperChord: multiChord.upperChord, result: multiChord.resultChord)
    } else {
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: oldMultiChord.lowerChord, upperChord: oldMultiChord.upperChord, result: oldMultiChord.resultChord)
      highlightResult(startingOctave: kb3.startingOctave, lowerChord: multiChord.lowerChord, upperChord: multiChord.upperChord, result: multiChord.resultChord)
    }
    
    oldMultiChord.lowerChord = multiChord.lowerChord
    oldMultiChord.upperChord = multiChord.upperChord
    oldMultiChord.resultChord = multiChord.resultChord
  }
  
  var body: some View {
    VStack(spacing: 30) {
      
      Spacer()
      
      HStack(spacing: 90) {
        ChordMenu(text: "Lower Chord", chord: $multiChord.lowerChord)
        ChordMenu(text: "Upper Chord", chord: $multiChord.upperChord)
      }
      .padding()
      
      List {
        Section(header: Text("Combined Chord")) {
          VStack {
            if let resultChord = multiChord.resultChord {
              Text(resultChord.name)
            } else {
              Text("\(multiChord.upperChord.name)/\(multiChord.lowerChord.name)")
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
      print("degrees", multiChord.lowerChord.degrees, "degrees in C", multiChord.lowerChord.type.degreesInC)
      print(multiChord.lowerChord.startingPitch, kb3.startingPitch)
      print(multiChord.lowerChord.raisedPitches)
      print(multiChord.lowerChord.raisedRoot)
      print(multiChord.stackedChord(degrees: multiChord.lowerChord.raisedPitches))
    })
    .onChange(of: multiChord.lowerChord) { oldLower, newLower in
      setAndHighlightChords(initial: false)
      print("degrees", multiChord.lowerChord.degrees, "degrees in C", multiChord.lowerChord.type.degreesInC)
      print(multiChord.lowerChord.startingPitch, kb3.startingPitch)
      print(multiChord.lowerChord.raisedPitches)
      print(multiChord.lowerChord.raisedRoot)
      print(multiChord.stackedChord(degrees: multiChord.lowerChord.raisedPitches))
    }
    .onChange(of: multiChord.upperChord) { oldUpper, newUpper in
      setAndHighlightChords(initial: false)
      print("degrees", multiChord.lowerChord.degrees, "degrees in C", multiChord.lowerChord.type.degreesInC)
      print(multiChord.lowerChord.startingPitch, kb3.startingPitch)
      print(multiChord.lowerChord.raisedPitches)
      print(multiChord.lowerChord.raisedRoot)
      print(multiChord.stackedChord(degrees: multiChord.lowerChord.raisedPitches))
    }
  }
}


#Preview {
  ContentView()
}
