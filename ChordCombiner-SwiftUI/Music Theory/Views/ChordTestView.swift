//
//  ChordTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/1/24.
//

import SwiftUI

struct ChordTestView: View {
  @State var lowerChord: Chord = Chord(.c, .ma7)
  @State var upperChord: Chord = Chord(.e, .mi)
  @State var resultChord: Chord?
  @State var oldLowerChord: Chord = Chord(.c, .ma7)
  @State var oldUpperChord: Chord = Chord(.e, .mi)
  @State var oldResultChord: Chord?
  @State var onlyInLower: [Int] = []
  @State var onlyInUpper: [Int] = []
  @State var commonToneDegs: [Int] = []
  
  @State var equivalentChords: [Chord] = []
  @State var deltaChords: [Chord] = []
  @State var kb3: Keyboard = Keyboard(title: "Combined Chord", geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 3)
  
  func highlightResult(startingOctave: Int, lowerChord: Chord, upperChord: Chord, result: Chord?) {
//    print("starting pitch:", kb3.startingPitch)
    let lowerPitch = lowerChord.root.num.toPitch(startingOctave: startingOctave).raiseAbove(pitch: kb3.startingPitch, degs: nil)
//    print("lower pitch:", lowerPitch)
    
    var upperPitch: Int
    
    if let _ = result {
      upperPitch = upperChord.root.num.toPitch(startingOctave: startingOctave).raiseAbove(pitch: kb3.startingPitch, degs: nil)
//      print("upper pitch:", upperPitch)
      
      let lowerDegs = lowerChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: lowerPitch, degs: nil)
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
      let lowerDegs = lowerChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
        .raiseAbove(pitch: lowerPitch, degs: nil)
      }
      let lowerDegsMax = lowerDegs.max() ?? 0
//      print("lower degs:", lowerDegs, "lowerDegsMax:", lowerDegsMax)
       
      var upper = upperChord.root.num.toPitch(startingOctave: startingOctave)
      
      upperPitch = upperChord.root.num.toPitch(startingOctave: startingOctave).raiseAbove(pitch: lowerDegsMax, degs: nil)
//     print("upper pitch:", upperPitch)
      
      let upperDegs = upperChord.degrees.map {
        $0.toPitch(startingOctave: startingOctave)
          .raiseAbove(pitch: upperPitch, degs: nil)
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
      print(lowerChord.type.baseChord.degreesInC)
      print(upperChord.type.baseChord)
    })
    .onChange(of: lowerChord) { oldLower, newLower in
      setAndHighlightChords(initial: false)
      print(lowerChord.type.baseChord.degreesInC)
      print(upperChord.type.baseChord.degreesInC)
    }
    .onChange(of: upperChord) { oldUpper, newUpper in
      setAndHighlightChords(initial: false)
      print(lowerChord.type.baseChord.degreesInC)
      print(upperChord.type.baseChord.degreesInC)
    }
  }
}


#Preview {
  ChordTestView()
}
