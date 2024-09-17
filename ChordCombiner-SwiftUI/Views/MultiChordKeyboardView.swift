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
    upperChord: Chord(.d, .ma, startingOctave: 4))
  @StateObject var oldMultiChord: MultiChord = MultiChord(
    lowerChord: Chord(.c, .ma7, startingOctave: 4),
    upperChord: Chord(.d, .ma, startingOctave: 4))
  @State var lowerKeyboard: Keyboard = Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var upperKeyboard: Keyboard = Keyboard(geoWidth: 150, initialKey: .C,  startingOctave: 4, octaves: 2)
  @State var combinedKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKey: .C,  startingOctave: 4, octaves: 5)
  @State var isInitial: Bool = true
  
  var color: Color = .yellow
  var secondColor: Color = .cyan
  
//  MARK: instance methods
  func setAndHighlightChords() {
    let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
    
    let lowerStackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
    let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
    
    let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: lowerStackedPitches, upperPitches: upperStackedPitches)
    
    if isInitial {
      lowerKeyboard.highlightKeysSingle(degs: lowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: upperStackedPitches, color: secondColor)
      
      multiChord.multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches()
      
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
        onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
        commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
        lowerStackedPitches: lowerSplitPitches,
        upperStackedPitches: upperSplitPitches,
        resultChordExists: resultChordExists,
        color: color,
        secondColor: secondColor)
      isInitial = false
    } else {
      let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
      
      let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
      let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
      
      let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
      
      lowerKeyboard.highlightKeysSingle(degs: oldLowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: oldUpperStackedPitches, color: secondColor)

      lowerKeyboard.highlightKeysSingle(degs: lowerStackedPitches, color: color)
      upperKeyboard.highlightKeysSingle(degs: upperStackedPitches, color: secondColor)
      
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: oldMultiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
        onlyInUpper: oldMultiChord.multiChordVoicingCalculator.upperTonesToHighlight,
        commonTones: oldMultiChord.multiChordVoicingCalculator.commonTonesToHighlight,
        lowerStackedPitches: oldLowerSplitPitches,
        upperStackedPitches: oldUpperSplitPitches,
        resultChordExists: oldResultChordExists,
        color: color,
        secondColor: secondColor)
      combinedKeyboard.highlightStackedCombinedOrSplit(
        onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
        onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
        commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
        lowerStackedPitches: lowerSplitPitches,
        upperStackedPitches: upperSplitPitches,
        resultChordExists: resultChordExists,
        color: color,
        secondColor: secondColor)
    }
    
    oldMultiChord.lowerChord = multiChord.lowerChord
    oldMultiChord.upperChord = multiChord.upperChord
  }
  
  var body: some View {
    NavigationStack {
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
            color: color)
                  
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
            color: secondColor)
      
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
          keyboard: $combinedKeyboard)
        
        ForEach((1...6), id: \.self ) { _ in
          Spacer()
        }
      }
      // MARK: modifiers
      .environmentObject(multiChord)
      .padding()
      .onAppear(perform: {
        setAndHighlightChords()
      })
      .onChange(of: multiChord.lowerChord) {
        setAndHighlightChords()
        multiChord.lowerChord.setNotesByDegree()
        print("allNotes: ", multiChord.lowerChord.allNotes)
        print(multiChord.lowerChord.allNotes.map { $0.noteNum.rawValue }, multiChord.lowerChord.degrees)
      }
      .onChange(of: multiChord.upperChord) {
        setAndHighlightChords()
    }
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
      ))
}
