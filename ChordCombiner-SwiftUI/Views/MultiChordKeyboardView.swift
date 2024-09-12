//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
  
//  MARK: @State and instance variables
  @StateObject var multiChord: MultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  @StateObject var oldMultiChord: MultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4)
  )
  @State var lowerKeyboard: Keyboard = Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var upperKeyboard: Keyboard = Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var combinedKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
  
  var color: Color = .yellow
  var secondColor: Color = .cyan
  
//  MARK: instance methods
  func setAndHighlightChords(initial: Bool) {
    let lowerDegrees = multiChord.lowerDegrees
    let lowerRoot = multiChord.lowerRoot
    let upperDegrees = multiChord.upperDegrees
    let upperRoot = multiChord.upperRoot
    
    var resultChordExists: Bool = false
    
    multiChord.resultChord = ChordFactory.combineChordDegrees(lowerDegrees, upperDegrees, lowerRoot: lowerRoot, upperRoot: upperRoot)

    let lowerStackedPitches = multiChord.lowerStackedPitches
    let upperStackedPitches = multiChord.upperStackedPitches
    var stackedPitches: [Int] = []
    
    var lowerTonesStacked: [Int] = []
    var upperTonesStacked: [Int] = []
    var commonTonesStacked: [Int] = []
    
    if let result = multiChord.resultChord {
      resultChordExists = true
      stackedPitches = result.stackedPitches
    }
    lowerTonesStacked = stackedPitches.includeIfSameNote(multiChord.onlyInLower)
    upperTonesStacked = stackedPitches.includeIfSameNote(multiChord.onlyInUpper)
    commonTonesStacked = stackedPitches.includeIfSameNote(multiChord.commonTones)
    
    if initial {
      lowerKeyboard.highlightKeysSingle(degs: lowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: upperStackedPitches, color: secondColor)
      
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: lowerTonesStacked,
        onlyInUpper: upperTonesStacked,
        commonTones: commonTonesStacked,
        lowerStackedPitches: lowerStackedPitches,
        upperStackedPitches: upperStackedPitches,
        resultChordExists: resultChordExists,
        color: color,
        secondColor: secondColor
      )
    } else {
      var oldResultChordExists = false
      
      let oldLowerStackedPitches = oldMultiChord.lowerStackedPitches
      let oldUpperStackedPitches = oldMultiChord.upperStackedPitches
      
      var oldStackedPitches: [Int] = []
      
      var oldLowerTonesStacked: [Int] = []
      var oldUpperTonesStacked: [Int] = []
      var oldCommonTonesStacked: [Int] = []
      
      if let oldResult = oldMultiChord.resultChord {
        oldResultChordExists = true
        oldStackedPitches = oldResult.stackedPitches
      }
      oldLowerTonesStacked = oldStackedPitches.includeIfSameNote(oldMultiChord.onlyInLower)
      oldUpperTonesStacked = oldStackedPitches.includeIfSameNote(oldMultiChord.onlyInUpper)
      oldCommonTonesStacked = oldStackedPitches.includeIfSameNote(oldMultiChord.commonTones)
      
      lowerKeyboard.highlightKeysSingle(degs: oldLowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: oldUpperStackedPitches, color: secondColor)

      lowerKeyboard.highlightKeysSingle(degs: lowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: upperStackedPitches, color: secondColor)
      
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: oldLowerTonesStacked,
        onlyInUpper: oldUpperTonesStacked,
        commonTones: oldCommonTonesStacked,
        lowerStackedPitches: oldLowerStackedPitches,
        upperStackedPitches: oldUpperStackedPitches,
        resultChordExists: oldResultChordExists,
        color: color,
        secondColor: secondColor
      )
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: lowerTonesStacked,
        onlyInUpper: upperTonesStacked,
        commonTones: commonTonesStacked,
        lowerStackedPitches: lowerStackedPitches,
        upperStackedPitches: upperStackedPitches,
        resultChordExists: resultChordExists,
        color: color,
        secondColor: secondColor
      )
    }
    
    oldMultiChord.lowerChord = multiChord.lowerChord
    oldMultiChord.upperChord = multiChord.upperChord
    oldMultiChord.resultChord = multiChord.resultChord
  }
  
  var body: some View {
    VStack() {
      
      ForEach((1...7), id: \.self ) { _ in
        Spacer()
      }
      
      HStack {
        Spacer()
        
        SingleChordKeyboardView(
          text: "Lower Chord",
          chord: $multiChord.lowerChord,
          keyboard: $lowerKeyboard,
          color: color
        )
                
        Spacer()
        
        Text("+")
          .font(.title2)
          .fontWeight(.heavy)
          .foregroundStyle(Color("titleColor"))
          .zIndex(1.0)
        
        Spacer()
        
        SingleChordKeyboardView(
          text: "Upper Chord",
          chord: $multiChord.upperChord,
          keyboard: $upperKeyboard,
          color: secondColor
        )
    
        Spacer()
      }

      ForEach((1...8), id: \.self ) { _ in
        Spacer()
      }
      
      Text("=")
        .font(.title2)
        .fontWeight(.heavy)
        .foregroundStyle(Color("titleColor"))
      
      Spacer()
      
      DualChordKeyboardView(
        text: "Combined Chord",
        keyboard: $combinedKeyboard
      )
      
      ForEach((1...6), id: \.self ) { _ in
        Spacer()
      }
    }
    // MARK: modifiers
    .environmentObject(multiChord)
    .padding()
    .onAppear(perform: {
      
      setAndHighlightChords(initial: true)
//      ChordFactory.compareDegreesInC()
    })
    .onChange(of: multiChord.lowerChord) {
      setAndHighlightChords(initial: false)
      multiChord.lowerChord.setNotesByDegree()
      print("allNotes: ", multiChord.lowerChord.allNotes)
      print(multiChord.lowerChord.allNotes.map { $0.noteNum.rawValue }, multiChord.lowerChord.degrees)
    }
    .onChange(of: multiChord.upperChord) {
      setAndHighlightChords(initial: false)
    }
  }
}

//  MARK: Preview
#Preview {
  MultiChordKeyboardView()
    .environmentObject(
      MultiChord(
        lowerChord: Chord(.c, .ma7, startingOctave: 4),
        upperChord: Chord(.d, .ma, startingOctave: 4)
      )
    )
}
