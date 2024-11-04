//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
  
  //  MARK: @State and instance variables

  @Bindable var multiChord: MultiChord = MultiChord(
    lowerChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    upperChordProperties: ChordProperties(letter: nil, accidental: .natural, chordType: nil),
    lowerKeyboard: Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    upperKeyboard: Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2),
    combinedKeyboard: Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  )
  
  @State var isInitial: Bool = true
  var color: Color = .lowerChordHighlight
  var secondColor: Color = .lowerChordHighlight
    
//    MARK: instance methods
  
//    func setAndHighlightChords() {
//      guard multiChord.resultChord != nil, let multiChordResultChord: Chord = multiChord.resultChord else {
//        return
//      }
//  
//      let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
//      var isSlashChord: Bool = false
//  
//      if let resultChordVoicingCalculator = multiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//        isSlashChord = resultChordVoicingCalculator.isSlashChord == true ? true : false
//      }
//  
//      let lowerStackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
//      let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
//  
//      let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: lowerStackedPitches, upperPitches: upperStackedPitches)
//  
//      if isInitial {
//        multiChord.multiChordVoicingCalculator.setResultChordCombinedHighlightedPitches()
//  
//        combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//          onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//          onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//          commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//          lowerStackedPitches: lowerSplitPitches,
//          upperStackedPitches: upperSplitPitches,
//          resultChordExists: resultChordExists,
//          isSlashChord: isSlashChord,
//          color: multiChord.color,
//          secondColor: multiChord.secondColor)
//        isInitial = false
//      } else {
//        let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
//        var oldIsSlashChord: Bool = false
//  
//        if let oldResultChordVoicingCalculator = oldMultiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
//          oldIsSlashChord = oldResultChordVoicingCalculator.isSlashChord == true ? true : false
//        }
//  
//        let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
//        let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
//  
//        let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
//  
//        combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//          onlyInLower: oldMultiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//          onlyInUpper: oldMultiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//          commonTones: oldMultiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//          lowerStackedPitches: oldLowerSplitPitches,
//          upperStackedPitches: oldUpperSplitPitches,
//          resultChordExists: oldResultChordExists,
//          isSlashChord: oldIsSlashChord,
//          color: multiChord.color,
//          secondColor: multiChord.secondColor)
//        combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
//          onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
//          onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
//          commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
//          lowerStackedPitches: lowerSplitPitches,
//          upperStackedPitches: upperSplitPitches,
//          resultChordExists: resultChordExists,
//          isSlashChord: isSlashChord,
//          color: multiChord.color,
//          secondColor: multiChord.secondColor)
//      }
//  
//      //    print(multiChord.resultChord?.preciseName)
//  
//  //    print("lower chord is \(multiChord.lowerChord.preciseName), upper chord is \(multiChord.upperChord.preciseName)")
//  
//  
//      oldMultiChord.lowerChord = multiChord.lowerChord
//      oldMultiChord.upperChord = multiChord.upperChord
//    }
  
  var body: some View {
    VStack {
      Spacer()
      
      CustomChordMenuSelectedView(
        multiChord: multiChord,
        keyboard: $multiChord.lowerKeyboard,
        combinedKeyboard: $multiChord.combinedKeyboard,
        chordProperties: $multiChord.lowerChordProperties
      )
      
      Spacer()
      
      TitleView(text: "+", font: .largeTitle, weight: .heavy)
        .zIndex(1.0)
      
      Spacer()
      
      CustomChordMenuSelectedView(
        multiChord: multiChord,
        keyboard: $multiChord.upperKeyboard,
        combinedKeyboard: $multiChord.combinedKeyboard,
        chordProperties: $multiChord.upperChordProperties
      )
      
      Spacer()
      
      TitleView(text: "=", font: .largeTitle, weight: .heavy)
      
      Spacer()
      
      DualChordKeyboardView(multiChord: multiChord)
      
      Spacer()
    }
    // MARK: modifiers
    .padding()
    .onAppear(perform: {
      //      setAndHighlightChords()
      //      MultiChordKeyboardHighlighter.singleton().setAndHighlightChords(
      //        multiChord: multiChord,
      //        oldMultiChord: oldMultiChord,
      //        isInitial: &isInitial,
      //        lowerKeyboard: &lowerKeyboard,
      //        upperKeyboard: &upperKeyboard,
      //        combinedKeyboard: &combinedKeyboard,
      //        color: multiChord.color,
      //        secondColor: multiChord.secondColor
      //      )
    })
    .onChange(of: multiChord.lowerChord) {
      //      setAndHighlightChords()
      //      MultiChordKeyboardHighlighter.singleton().setAndHighlightChords(
      //        multiChord: multiChord,
      //        oldMultiChord: oldMultiChord,
      //        isInitial: &isInitial,
      //        lowerKeyboard: &lowerKeyboard,
      //        upperKeyboard: &upperKeyboard,
      //        combinedKeyboard: &combinedKeyboard,
      //        color: multiChord.color,
      //        secondColor: multiChord.secondColor
      //      )
      //      multiChord.lowerChord.setNotesByDegree()
      //      print("allNotes: ", multiChord.lowerChord.allNotes)
      //      print(multiChord.lowerChord.allNotes.map { $0.noteNumber.rawValue }, multiChord.lowerChord.degreeNumbers)
    }
    .onChange(of: multiChord.upperChord) {
      //      setAndHighlightChords()
      //      MultiChordKeyboardHighlighter.singleton().setAndHighlightChords(
      //        multiChord: multiChord,
      //        oldMultiChord: oldMultiChord,
      //        isInitial: &isInitial,
      //        lowerKeyboard: &lowerKeyboard,
      //        upperKeyboard: &upperKeyboard,
      //        combinedKeyboard: &combinedKeyboard,
      //        color: multiChord.color,
      //        secondColor: multiChord.secondColor
      //      )
      //      multiChord.upperChord.setNotesByDegree()
    }
  }
}

//  MARK: Preview
#Preview {
  MultiChordKeyboardView()
}
