//
//  MultiChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct MultiChordKeyboardView: View {
  
  //  MARK: @State and instance variables
  //  @StateObject var multiChord: MultiChord = MultiChord(
  //    lowerChord: Chord(.c, .ma7, startingOctave: 4),
  //    upperChord: Chord(.d, .ma, startingOctave: 4))
  //  @StateObject var oldMultiChord: MultiChord = MultiChord(
  //    lowerChord: Chord(.c, .ma7, startingOctave: 4),
  //    upperChord: Chord(.d, .ma, startingOctave: 4))

  @StateObject var multiChord: MultiChord = MultiChord(
    lowerChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil),
    upperChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil)
  )
  
  @State var oldLowerChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: nil, chordType: nil)
  @State var oldUpperChordProperties: ChordProperties = ChordProperties(letter: nil, accidental: nil, chordType: nil)
  
  @State var lowerKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2)
  @State var upperKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 2)
  @State var combinedKeyboard: Keyboard = Keyboard(geoWidth: 351, initialKeyType: .C,  startingOctave: 4, octaves: 3)
  @State var isInitial: Bool = true
  
  var color: Color = .lowerChordHighlight
  var secondColor: Color = .lowerChordHighlight
  
//  @State var chordProperties: MultiChordProperties = MultiChordProperties(letter: nil, accidental: nil, chordType: nil)
  
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
        keyboard: $lowerKeyboard,
        combinedKeyboard: $combinedKeyboard,
        chordProperties: $multiChord.lowerChordProperties,
        oldChordProperties: $multiChord.oldLowerChordProperties
      )
      
      Spacer()
      
      TitleView(text: "+", font: .largeTitle, weight: .heavy)
        .zIndex(1.0)
      
      Spacer()
      
      CustomChordMenuSelectedView(
        keyboard: $upperKeyboard,
        combinedKeyboard: $combinedKeyboard,
        chordProperties: $multiChord.upperChordProperties,
        oldChordProperties: $multiChord.oldUpperChordProperties
      )
      
      Spacer()
      
      TitleView(text: "=", font: .largeTitle, weight: .heavy)
      
      Spacer()
      
      DualChordKeyboardView(keyboard: $combinedKeyboard)
      
      Spacer()
    }
    // MARK: modifiers
    .environmentObject(multiChord)
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
    .environmentObject(
//      MultiChord(
//        lowerChord: Chord(.c, .ma7, startingOctave: 4),
//        upperChord: Chord(.d, .ma, startingOctave: 4)
//      )
      MultiChord(
        lowerChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil),
        upperChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil)
      )
    )
}
