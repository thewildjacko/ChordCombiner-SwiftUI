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
  
  var customChordMenuSelectedChordTitleModel: CustomChordMenuSelectedChordTitleModel {
    CustomChordMenuSelectedChordTitleModel(multiChord: multiChord, chordProperties: chordProperties)
  }
  
  var chordMenuPropertyMatcher: ChordMenuPropertyMatcher {
    ChordMenuPropertyMatcher(
      multiChord: multiChord,
      isLowerChordMenu: customChordMenuSelectedChordTitleModel.isLowerChordMenu,
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
              text: customChordMenuSelectedChordTitleModel.singleChordKeyboardTitleSelector.chordTitle,
              font: customChordMenuSelectedChordTitleModel.chordSymbolTitleFont,
              weight: .heavy,
              isMenuTitle: false
            )
            SingleChordDetailNavigationLinkView(chord: customChordMenuSelectedChordTitleModel.selectedChord, color: customChordMenuSelectedChordTitleModel.selectedChordColor)
          }
          
          selectedKeyboard
        }
        
        TitleView(
          text: customChordMenuSelectedChordTitleModel.showingMatchesText,
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
        color: customChordMenuSelectedChordTitleModel.selectedChordColor
      )
      
      TitleColorDivider()
      
      DualChordKeyboardView(
        multiChord: multiChord,
        keyboard: $combinedKeyboard
      )
      
      Spacer()
    }
    .padding()
    .onChange(of: customChordMenuSelectedChordTitleModel.selectedChord?.letter, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .letter)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: customChordMenuSelectedChordTitleModel.selectedChord,
        chordToMatch: customChordMenuSelectedChordTitleModel.chordToMatch,
        multiChord: multiChord,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: customChordMenuSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    })
    .onChange(of: customChordMenuSelectedChordTitleModel.selectedChord?.accidental, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .accidental)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: customChordMenuSelectedChordTitleModel.selectedChord,
        chordToMatch: customChordMenuSelectedChordTitleModel.chordToMatch,
        multiChord: multiChord,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: customChordMenuSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    })
    .onChange(of: customChordMenuSelectedChordTitleModel.selectedChord?.chordType, {
      chordMenuPropertyMatcher.clearAndMatchChords(propertyChanged: .chordType)
      
      keyboardHighlighter.highlightKeyboards(
        selectedChord: customChordMenuSelectedChordTitleModel.selectedChord,
        chordToMatch: customChordMenuSelectedChordTitleModel.chordToMatch,
        multiChord: multiChord,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: customChordMenuSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
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
