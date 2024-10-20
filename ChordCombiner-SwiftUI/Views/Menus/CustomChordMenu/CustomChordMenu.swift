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
  @Binding var chordProperties: MultiChordProperties
  @Binding var oldChordProperties: MultiChordProperties
  
  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  
  var isLowerChordMenu: Bool {
    get { chordProperties == multiChord.lowerChordProperties ? true : false }
  }
  
  var selectedChord: Chord? {
    isLowerChordMenu ? multiChord.lowerChord : multiChord.upperChord
  }
  
  var chordSymbolTitleFont: Font {
    isLowerChordMenu ?
    multiChord.lowerChord != nil ?
      .largeTitle : .headline :
    multiChord.upperChord != nil ?
      .largeTitle : .headline
  }
  
  var rootKeyNote: RootKeyNote? {
    if let letter = chordProperties.letter,
       let accidental = chordProperties.accidental {
      return RootKeyNote(letter, accidental)
    } else {
      return nil
    }
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
    
    return isLowerChordMenu ? (upperChord, lowerChord) : (lowerChord, upperChord)
  }
  
  func insertMatching<T: ChordAndScaleProperty>(chordProperty: T, matchingProperties: inout Set<T>) {
    guard let firstChord = setChordsForMatches().firstChord,
          let secondChord = setChordsForMatches().secondChord else {
      return
    }

    
    
    if firstChord.combinesWith(chordFrom: chordProperty, originalChord: secondChord) {
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
    for type in ChordType.allSimpleChordTypes {
      insertMatching(chordProperty: type, matchingProperties: &matchingChordTypes)
    }
  }
  
  func matchChords() {
    matchByLetter()
    matchByAccidental()
    matchByChordType()
  }
  
  func toggleHighlightForSelectedKeyboard() {
    var stackedPitches: [Int]
    
    if !oldChordProperties.propertiesAreSet {
      if let selectedChord = selectedChord {
        stackedPitches = selectedChord.voicingCalculator.stackedPitches
      }
    }
//    let stackedPitches = isLowerChordMenu ?  multiChord.multiChordVoicingCalculator.lowerStackedPitches : multiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    let color = chord == multiChord.lowerChord ? multiChord.color : multiChord.secondColor
//    
//    let oldStackedPitches = chord == multiChord.lowerChord ? oldMultiChord.multiChordVoicingCalculator.lowerStackedPitches : oldMultiChord.multiChordVoicingCalculator.upperStackedPitches
//    
//    //    print(stackedPitches, oldStackedPitches)
//    
//    selectedKeyboard.toggleHighlightKeysSingle(degs: oldStackedPitches, color: color)
//    selectedKeyboard.toggleHighlightKeysSingle(degs: stackedPitches, color: color)
  }
  
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
            CustomChordMenuLetterTagsView(
              selectedLetter: $chordProperties.letter,
              matchingLetters: $matchingLetters,
              font: .headline,
              horizontalPadding: 10,
              verticalPadding: 1.5,
              cornerRadius: 5,
              spacing: 8
            )
          
          Divider()
            .frame(height: 30)
            .titleColorOverlay()
          
          CustomChordMenuAccidentalTagsView(
            selectedAccidental: $chordProperties.accidental,
            matchingAccidentals: $matchingAccidentals,
            isHorizontal: true,
            font: .headline,
            horizontalPadding: 5,
            verticalPadding: 1.5,
            cornerRadius: 5
          )
        }
      }
      
      TitleColorDivider()
      
      CustomChordMenuKeyboardDisplayScrollView(
        selectedChordType: $chordProperties.type,
        matchingChordTypes: $matchingChordTypes,
        chordTypes: ChordType.allSimpleChordTypes,
        rootKeyNote: rootKeyNote,
        color: .cyan
      )
      
      TitleColorDivider()
      
      DualChordKeyboardView(keyboard: $combinedKeyboard)
      
      Spacer()
    }
    .environmentObject(multiChord)
    .padding()
    .onAppear {
//    setOldMultiChord()
//      print("CustomChordMenu\n------\nlowerChord is \(multiChord.lowerChord.preciseName), upperChord is \(multiChord.upperChord.preciseName)")
//      print(multiChord.lowerChord.voicingCalculator.stackedPitches, multiChord.upperChord.voicingCalculator.stackedPitches)
//      print("old lowerChord is \(oldMultiChord.lowerChord.preciseName), old upperChord is \(oldMultiChord.upperChord.preciseName)")
//      print(oldMultiChord.lowerChord.voicingCalculator.stackedPitches, oldMultiChord.upperChord.voicingCalculator.stackedPitches)
//      print("------")
      matchChords()
    }
    .onChange(of: multiChord.lowerChord, { oldValue, newValue in
      clearAndMatchChords()
    })
    .onChange(of: multiChord.upperChord, { oldValue, newValue in
      clearAndMatchChords()
    })
//    
//    .onChange(of: chord.letter, {
////      print("CustomChordMenu\n------\nlowerChord is \(multiChord.lowerChord.preciseName), upperChord is \(multiChord.upperChord.preciseName)")
////      print(multiChord.lowerChord.voicingCalculator.stackedPitches, multiChord.upperChord.voicingCalculator.stackedPitches)
////      print("old lowerChord is \(oldMultiChord.lowerChord.preciseName), old upperChord is \(oldMultiChord.upperChord.preciseName)")
////      print(oldMultiChord.lowerChord.voicingCalculator.stackedPitches, oldMultiChord.upperChord.voicingCalculator.stackedPitches)
////      print("------")
//      clearAndMatchChords()
//    })
//    .onChange(of: chord.accidental, {
////      print("CustomChordMenu\n------\nlowerChord is \(multiChord.lowerChord.preciseName), upperChord is \(multiChord.upperChord.preciseName)")
////      print(multiChord.lowerChord.voicingCalculator.stackedPitches, multiChord.upperChord.voicingCalculator.stackedPitches)
////      print("old lowerChord is \(oldMultiChord.lowerChord.preciseName), old upperChord is \(oldMultiChord.upperChord.preciseName)")
////      print(oldMultiChord.lowerChord.voicingCalculator.stackedPitches, oldMultiChord.upperChord.voicingCalculator.stackedPitches)
////      print("------")
//      
//      clearAndMatchChords()
//    })
//    .onChange(of: chord.type, {
////      print("CustomChordMenu\n------\nlowerChord is \(multiChord.lowerChord.preciseName), upperChord is \(multiChord.upperChord.preciseName)")
////      print(multiChord.lowerChord.voicingCalculator.stackedPitches, multiChord.upperChord.voicingCalculator.stackedPitches)
////      print("old lowerChord is \(oldMultiChord.lowerChord.preciseName), old upperChord is \(oldMultiChord.upperChord.preciseName)")
////      print(oldMultiChord.lowerChord.voicingCalculator.stackedPitches, oldMultiChord.upperChord.voicingCalculator.stackedPitches)
////      print("------")
//      clearAndMatchChords()
//    })
  }
}

#Preview {
  CustomChordMenu(
    selectedKeyboard:
        .constant(
          Keyboard(
            geoWidth: 330,
            initialKey: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        geoWidth: 351,
        initialKey: .C,
        startingOctave: 4,
        octaves: 5
      )
    ),
    chordProperties: .constant(MultiChordProperties(letter: nil, accidental: nil, type: nil)),
    oldChordProperties: .constant(MultiChordProperties(letter: nil, accidental: nil, type: nil))
  )
  .environmentObject(
    MultiChord(
      lowerChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil),
      upperChordProperties: MultiChordProperties(letter: nil, accidental: nil, type: nil)
    )
  )
}
