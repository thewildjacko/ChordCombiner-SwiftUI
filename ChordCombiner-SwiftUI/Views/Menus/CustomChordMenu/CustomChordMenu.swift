//
//  CustomChordMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct CustomChordMenu: View {
  var multiChord: MultiChord
  
  @Binding var selectedKeyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  
  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  
  let keyboardHighlighter: KeyboardHighlighter = KeyboardHighlighter()
  
  var isLowerChordMenu: Bool {
    get { chordProperties == multiChord.lowerChordProperties ? true : false }
  }
  
  var chordMenuPropertyMatcher: ChordMenuPropertyMatcher {
    ChordMenuPropertyMatcher(multiChord: multiChord, isLowerChordMenu: isLowerChordMenu, matchingLetters: $matchingLetters, matchingAccidentals: $matchingAccidentals, matchingChordTypes: $matchingChordTypes)
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
      
      DualChordKeyboardView(multiChord: multiChord)
      
      Spacer()
    }
    .padding()
    .onAppear {
      chordMenuPropertyMatcher.matchChords()
      
      keyboardHighlighter.highlightKeyboards(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor, combinedKeyboard: &combinedKeyboard)
    }
    .onChange(of: selectedChord?.letter, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .letter)
      
      keyboardHighlighter.highlightKeyboards(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor, combinedKeyboard: &combinedKeyboard)
    })
    .onChange(of: selectedChord?.accidental, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .accidental)
      
      keyboardHighlighter.highlightKeyboards(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor, combinedKeyboard: &combinedKeyboard)
    })
    .onChange(of: selectedChord?.chordType, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .chordType)
      
      keyboardHighlighter.highlightKeyboards(selectedChord: selectedChord, chordToMatch: chordToMatch, multiChord: multiChord, selectedKeyboard: &selectedKeyboard, selectedChordColor: selectedChordColor, combinedKeyboard: &combinedKeyboard)
    })
  }
}

#Preview {
  CustomChordMenu(
    multiChord: MultiChord(),
    selectedKeyboard:
        .constant(
          Keyboard(
            baseWidth: 330,
            initialKeyType: .C,
            startingOctave: 4,
            octaves: 2
          )
        ),
    combinedKeyboard: .constant(
      Keyboard(
        baseWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    ),
    chordProperties: .constant(ChordProperties(letter: nil, accidental: nil, chordType: nil))
  )
}
