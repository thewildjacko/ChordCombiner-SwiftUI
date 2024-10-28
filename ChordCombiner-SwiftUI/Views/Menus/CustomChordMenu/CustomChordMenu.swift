//
//  CustomChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct CustomChordMenu: View {
  @EnvironmentObject var multiChord: MultiChord
  
  @Binding var selectedKeyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  @Binding var oldChordProperties: ChordProperties
  
  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  
  var isLowerChordMenu: Bool {
    get { chordProperties == multiChord.lowerChordProperties ? true : false }
  }
  
  var selectedChord: Chord? {
    isLowerChordMenu ? multiChord.lowerChord : multiChord.upperChord
  }
  
  var chordToMatch: Chord? {
    isLowerChordMenu ? multiChord.upperChord : multiChord.lowerChord
  }
  
  var selectedChordColor: Color {
    isLowerChordMenu ? .lowerChordHighlight : .upperChordHighlight
  }
  
  var chordToMatchColor: Color {
    isLowerChordMenu ? .upperChordHighlight : .lowerChordHighlight
  }
  
  var chordSymbolTitleFont: Font {
    isLowerChordMenu ?
    multiChord.lowerChord != nil ?
      .largeTitle : .headline :
    multiChord.upperChord != nil ?
      .largeTitle : .headline
  }
  
  var rootKeyNote: RootKeyNote? {
    guard let letter = chordProperties.letter,
          let accidental = chordProperties.accidental else {
      return nil
    }
    
    return RootKeyNote(letter, accidental)
  }
  
  //  var showingMatchesText: String {
  //    guard let chord = chord else {
  //      return "Please select a chord"
  //    }
  //
  //    guard let lowerChord = multiChord.lowerChord,
  //          let upperChord = multiChord.upperChord else {
  //      return "Select upper and lower chords to show matches"
  //    }
  //
  //    return chord == multiChord.lowerChord ? "(showing matches for upper chord \(upperChord.preciseName))" : "(showing matches for lower chord \(lowerChord.preciseName))"
  //  }
  
  func clearLetters() { matchingLetters.removeAll() }
  func clearAccidentals() { matchingAccidentals.removeAll() }
  func clearChordTypes() { matchingChordTypes.removeAll() }
  
  func clearMatches() {
    clearLetters()
    clearAccidentals()
    clearChordTypes()
  }
  
  func setChordsForMatches() -> (firstChord: Chord?, secondChord: Chord?) {
    guard let lowerChord = multiChord.lowerChord,
          let upperChord = multiChord.upperChord else {
      return (nil, nil)
    }
    
    let (firstChord, secondChord) = isLowerChordMenu ?
    (upperChord, lowerChord) :
    (lowerChord, upperChord)
    
    return (firstChord, secondChord)
  }
  
  func insertMatching<T: ChordAndScaleProperty>(chordProperty: T, matchingProperties: inout Set<T>) {
    guard let firstChord = setChordsForMatches().firstChord,
          let secondChord = setChordsForMatches().secondChord else {
      return
    }
    
    if secondChord.variantCombinesWith(chordFrom: chordProperty, chordToMatch: firstChord) {
      chordProperty.insertMatching(matchingProperties: &matchingProperties)
    }
  }
  
  func matchByLetter() {
    for letter in Letter.allCases {
      insertMatching(chordProperty: letter, matchingProperties: &matchingLetters)
    }
  }
  
  func matchByAccidental() {
    for accidental in RootAccidental.allCases {
      insertMatching(chordProperty: accidental, matchingProperties: &matchingAccidentals)
    }
  }
  
  func matchByChordType() {
    for chordType in ChordType.allSimpleChordTypes {
      insertMatching(chordProperty: chordType, matchingProperties: &matchingChordTypes)
    }
  }
  
  func matchChords() {
    matchByLetter()
    matchByAccidental()
    matchByChordType()
  }
  
  func highlightSelectedChord() {
    guard let selectedChord = selectedChord else { return }
    
    selectedKeyboard.highlightKeysAfterClearing(pitches: selectedChord.voicingCalculator.stackedPitches, color: selectedChordColor)
    selectedKeyboard.setNotesStacked(pitchesByNote: selectedChord.voicingCalculator.stackedPitchesByNote, color: selectedChordColor)
    print(selectedChord.voicingCalculator.allNotes)
    print(selectedChord.voicingCalculator.pitchesRaisedAboveRoot)
    print(selectedChord.voicingCalculator.stackedPitches)
    print(selectedChord.voicingCalculator.stackedPitchesByNote)
//    selectedKeyboard.toggleLetters()
  }
  
  func highlightCombinedChord() {
    guard let selectedChord = selectedChord,
          let chordToMatch = chordToMatch,
          let resultChord = multiChord.resultChord,
          let mcvc = multiChord.multiChordVoicingCalculator else {
      return
    }
    
    print(multiChord.equivalentChords.map { $0.preciseName })
    
    combinedKeyboard.highlightKeysAfterClearing(pitches: mcvc.lowerTonesToHighlight, color: .lowerChordHighlight)
    combinedKeyboard.highlightKeysWithoutClearing(pitches: mcvc.upperTonesToHighlight, color: .upperChordHighlight)
    combinedKeyboard.highlightKeysWithoutClearing(pitches: mcvc.commonTonesToHighlight, color: LinearGradient.commonToneGradient)
  }
  
  //  func toggleHighlightForSelectedKeyboard() {
  //    var stackedPitches: [Int]
  //
  //    if !oldChordProperties.propertiesAreSet {
  //      if let selectedChord = selectedChord {
  //        stackedPitches = selectedChord.voicingCalculator.stackedPitches
  //      }
  //    }
  ////    let stackedPitches = isLowerChordMenu ?  multiChord.multiChordVoicingCalculator.lowerStackedPitches : multiChord.multiChordVoicingCalculator.upperStackedPitches
  ////
  ////    let color = chord == multiChord.lowerChord ? multiChord.color : multiChord.secondColor
  ////
  ////    let oldStackedPitches = chord == multiChord.lowerChord ? oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches : oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
  ////
  ////    //    print(stackedPitches, oldStackedPitches)
  ////
  ////    selectedKeyboard.toggleHighlightKeysSingle(degreeNumbers: oldStackedPitches, color: color)
  ////    selectedKeyboard.toggleHighlightKeysSingle(degreeNumbers: stackedPitches, color: color)
  //  }
  
  //  func toggleHighlightForCombinedKeyboard() {
  //    let resultChordExists: Bool = multiChord.resultChord != nil ? true : false
  //    var isSlashChord: Bool = false
  //
  //    if let resultChordVoicingCalculator = multiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
  //      isSlashChord = resultChordVoicingCalculator.isSlashChord == true ? true : false
  //    }
  //
  //    let lowerStackedPitches = multiChord.multiChordVoicingCalculator.lowerStackedPitches
  //    let upperStackedPitches = multiChord.multiChordVoicingCalculator.upperStackedPitches
  //
  //    let (lowerSplitPitches, upperSplitPitches) = multiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: lowerStackedPitches, upperPitches: upperStackedPitches)
  //
  //    let oldResultChordExists: Bool = oldMultiChord.resultChord != nil ? true : false
  //    var oldIsSlashChord: Bool = false
  //
  //    if let oldResultChordVoicingCalculator = oldMultiChord.multiChordVoicingCalculator.resultChordVoicingCalculator {
  //      oldIsSlashChord = oldResultChordVoicingCalculator.isSlashChord == true ? true : false
  //    }
  //
  //    let oldLowerStackedPitches = oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches
  //    let oldUpperStackedPitches = oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
  //
  //    let (oldLowerSplitPitches, oldUpperSplitPitches) = oldMultiChord.multiChordVoicingCalculator.stackedSplit(lowerPitches: oldLowerStackedPitches, upperPitches: oldUpperStackedPitches)
  //
  //    combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
  //      onlyInLower: oldMultiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
  //      onlyInUpper: oldMultiChord.multiChordVoicingCalculator.upperTonesToHighlight,
  //      commonTones: oldMultiChord.multiChordVoicingCalculator.commonTonesToHighlight,
  //      lowerStackedPitches: oldLowerSplitPitches,
  //      upperStackedPitches: oldUpperSplitPitches,
  //      resultChordExists: oldResultChordExists,
  //      isSlashChord: oldIsSlashChord,
  //      color: multiChord.color,
  //      secondColor: multiChord.secondColor)
  //
  //    combinedKeyboard.toggleHighlightStackedCombinedOrSplit(
  //      onlyInLower: multiChord.multiChordVoicingCalculator.lowerTonesToHighlight,
  //      onlyInUpper: multiChord.multiChordVoicingCalculator.upperTonesToHighlight,
  //      commonTones: multiChord.multiChordVoicingCalculator.commonTonesToHighlight,
  //      lowerStackedPitches: lowerSplitPitches,
  //      upperStackedPitches: upperSplitPitches,
  //      resultChordExists: resultChordExists,
  //      isSlashChord: isSlashChord,
  //      color: multiChord.color,
  //      secondColor: multiChord.secondColor)
  //
  //    //    print(multiChord.resultChord?.preciseName)
  //
  //    //    print("lower chord is \(multiChord.lowerChord.preciseName), upper chord is \(multiChord.upperChord.preciseName)")
  //
  //    //    oldMultiChord.lowerChord = multiChord.lowerChord
  //    //    oldMultiChord.upperChord = multiChord.upperChord
  //  }
  
  
  //  func setOldMultiChord() {
  //    oldMultiChord = MultiChord(lowerChord: multiChord.lowerChord, upperChord: multiChord.upperChord)
  //    oldMultiChord.setResultChord()
  //  }
  
  func clearAndMatchChords() {
    clearMatches()
    matchChords()
    //    toggleHighlightForSelectedKeyboard()
    //    toggleHighlightForCombinedKeyboard()
    //    setOldMultiChord()
  }
  
  var body: some View {
    VStack {
      VStack(spacing: 8) {
        
        VStack {
          TitleView(
            text: multiChord.singleChordTitle(forLowerChord: isLowerChordMenu),
            font: chordSymbolTitleFont,
            weight: .heavy,
            isMenuTitle: false
          )
          
          selectedKeyboard
        }
        
        TitleView(
          text: /*showingMatchesText*/"",
          font: .caption,
          weight: .semibold,
          color: .glowText
        )
        
        HStack(alignment: .bottom) {
          CustomChordMenuTagsView(
            selectedProperty: $chordProperties.letter,
            matchingProperties: $matchingLetters,
            tagProperties: Letter.allCases,
            isHorizontal: true,
            font: .headline,
            horizontalPadding: 10,
            verticalPadding: 1.5,
            cornerRadius: 5,
            spacing: 8,
            highlightColor: .tagBackgroundHighlighted
          )
          
          Divider()
            .frame(height: 30)
            .titleColorOverlay()
          
          
          CustomChordMenuTagsView(
            selectedProperty: $chordProperties.accidental,
            matchingProperties: $matchingAccidentals,
            tagProperties: RootAccidental.allCases,
            isHorizontal: true,
            font: .headline,
            horizontalPadding: 5,
            verticalPadding: 1.5,
            cornerRadius: 5,
            spacing: 8,
            highlightColor: .tagBackgroundHighlighted
          )
        }
      }
      
      TitleColorDivider()
      
      CustomChordMenuKeyboardDisplayScrollView(
        selectedChordType: $chordProperties.chordType,
        matchingChordTypes: $matchingChordTypes,
        chordTypes: ChordType.allSimpleChordTypes,
        rootKeyNote: rootKeyNote,
        color: selectedChordColor
      )
      
      TitleColorDivider()
      
      DualChordKeyboardView(keyboard: $combinedKeyboard)
      
      Spacer()
    }
    .environmentObject(multiChord)
    .padding()
    .onAppear {
      matchChords()
      highlightSelectedChord()
      highlightCombinedChord()
    }
    .onChange(of: selectedChord, { oldValue, newValue in
      clearAndMatchChords()
      highlightSelectedChord()
      highlightCombinedChord()
    })
    
  }
}

#Preview {
  CustomChordMenu(
    selectedKeyboard:
        .constant(
          Keyboard(
            geoWidth: 330,
            initialKeyType: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        geoWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    ),
    chordProperties: .constant(ChordProperties(letter: nil, accidental: nil, chordType: nil)),
    oldChordProperties: .constant(ChordProperties(letter: nil, accidental: nil, chordType: nil))
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil),
      upperChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil)
    )
  )
}
