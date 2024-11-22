//
//  ChordCombinerChordSelectionMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct ChordCombinerChordSelectionMenu: View {
  var chordCombinerViewModel: ChordCombinerViewModel
  
  @Binding var selectedKeyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties
  
  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  
  let keyboardHighlighter: KeyboardHighlighter = KeyboardHighlighter()
  
  var chordCombinerSelectedChordTitleModel: ChordCombinerSelectedChordTitleModel {
    ChordCombinerSelectedChordTitleModel(chordCombinerViewModel: chordCombinerViewModel, chordProperties: chordProperties)
  }
  
  var chordMenuPropertyMatcher: ChordMenuPropertyMatcher {
    ChordMenuPropertyMatcher(
      chordCombinerViewModel: chordCombinerViewModel,
      isLowerChordMenu: chordCombinerSelectedChordTitleModel.isLowerChordMenu,
      matchingLetters: $matchingLetters,
      matchingAccidentals: $matchingAccidentals,
      matchingChordTypes: $matchingChordTypes
    )
  }
  
  var rootKeyNote: RootKeyNote? {
    guard let letter = chordProperties.letter,
          let accidental = chordProperties.accidental else {
      return nil
    }
    
    return RootKeyNote(letter, accidental)
  }
  
  var body: some View {
    VStack {
      VStack(spacing: 8) {
        VStack {
          HStack {
            TitleView(
              text: chordCombinerSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: chordCombinerSelectedChordTitleModel.chordSymbolTitleFont,
              weight: .heavy,
              isMenuTitle: false
            )
            SingleChordDetailNavigationLinkView(chord: chordCombinerSelectedChordTitleModel.selectedChord, color: chordCombinerSelectedChordTitleModel.selectedChordColor)
          }
          
          selectedKeyboard
        }
        
        TitleView(
          text: chordCombinerSelectedChordTitleModel.showingMatchesText,
          font: .caption,
          weight: .semibold,
          color: .glowText
        )
        
        HStack(alignment: .bottom) {
          ChordCombinerTagsView(
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
          
          
          ChordCombinerTagsView(
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
      
      ChordCombinerKeyboardScrollView(
        selectedChordType: $chordProperties.chordType,
        matchingChordTypes: $matchingChordTypes,
        chordTypes: ChordType.allSimpleChordTypes,
        rootKeyNote: rootKeyNote,
        color: chordCombinerSelectedChordTitleModel.selectedChordColor
      )
      
      TitleColorDivider()
      
      DualChordKeyboardView(
        chordCombinerViewModel: chordCombinerViewModel,
        keyboard: $combinedKeyboard
      )
      
      Spacer()
    }
    .padding()
    .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.letter, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .letter)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    })
    .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.accidental, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .accidental)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    })
    .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.chordType, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .chordType)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    })
  }
}

#Preview {
  ChordCombinerChordSelectionMenu(
    chordCombinerViewModel: ChordCombinerViewModel(),
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
