//
//  ChordCombinerChordSelectionMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI


struct ChordCombinerChordSelectionMenu: View {
  let keyboardHighlighter: KeyboardHighlighter = KeyboardHighlighter()

  var chordCombinerViewModel: ChordCombinerViewModel
  
  @Binding var selectedKeyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties {
    mutating didSet {
      setChordCombinerSelectedChordTitleModel()
      setRootKeyNote()
    }
  }
  
  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  
  var chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel.initial
  
  var rootKeyNote: RootKeyNote? = nil
  
  var chordCombinerPropertyMatcher: ChordCombinerPropertyMatcher {
    ChordCombinerPropertyMatcher(
      chordCombinerViewModel: chordCombinerViewModel,
      isLowerChordMenu: chordCombinerSelectedChordTitleModel.isLowerChordMenu,
      matchingLetters: $matchingLetters,
      matchingAccidentals: $matchingAccidentals,
      matchingChordTypes: $matchingChordTypes
    )
  }
  
  
  
  init(chordCombinerViewModel: ChordCombinerViewModel, selectedKeyboard: Binding<Keyboard>, combinedKeyboard: Binding<Keyboard>, chordProperties: Binding<ChordProperties>) {
    self.chordCombinerViewModel = chordCombinerViewModel
    self._selectedKeyboard = selectedKeyboard
    self._combinedKeyboard = combinedKeyboard
    self._chordProperties = chordProperties
    
    setChordCombinerSelectedChordTitleModel()
    setRootKeyNote()
  }
  
  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(
      chordCombinerViewModel: chordCombinerViewModel,
      chordProperties: chordProperties
    )
  }
  
  mutating func setRootKeyNote() {
    if let letter = chordProperties.letter,
          let accidental = chordProperties.accidental {
      rootKeyNote = RootKeyNote(letter, accidental)
    } else {
      rootKeyNote = nil
    }
  }
  
  func highlightKeyboardOnSelect() {
    if chordCombinerSelectedChordTitleModel.selectedChord != nil {
      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
        combinedKeyboard: &combinedKeyboard
      )
    }
  }
  
  var body: some View {
    VStack {
      VStack(spacing: 8) {
        SingleChordTitleNavigationStackView(
          selectedKeyboard: $selectedKeyboard,
          chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel
        )
        
        ChordCombinerPropertySelectionView(
          chordProperties: $chordProperties,
          matchingLetters: $matchingLetters,
          matchingAccidentals: $matchingAccidentals,
          matchingChordTypes: $matchingChordTypes,
          chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel
        )
        
        DualChordKeyboardView(
          chordCombinerViewModel: chordCombinerViewModel,
          keyboard: $combinedKeyboard
        )
        
        Spacer()
      }
      .padding()
      .onAppear(perform: {
        if let _ = chordCombinerViewModel.lowerChord, let _ = chordCombinerViewModel.upperChord {
          chordCombinerPropertyMatcher.matchChords()
        }
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord, { oldValue, newValue in
        highlightKeyboardOnSelect()
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.letter, {
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .letter)
        
        highlightKeyboardOnSelect()
        
//        keyboardHighlighter.highlightKeyboards(
//          selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
//          chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
//          chordCombinerViewModel: chordCombinerViewModel,
//          selectedKeyboard: &selectedKeyboard,
//          selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
//          combinedKeyboard: &combinedKeyboard
//        )
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.accidental, { oldValue, _ in
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .accidental)
        
        if oldValue != nil { highlightKeyboardOnSelect() }
        
//        keyboardHighlighter.highlightKeyboards(
//          selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
//          chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
//          chordCombinerViewModel: chordCombinerViewModel,
//          selectedKeyboard: &selectedKeyboard,
//          selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
//          combinedKeyboard: &combinedKeyboard
//        )
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.chordType, { oldValue, _ in
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .chordType)
        
        if oldValue != nil { highlightKeyboardOnSelect() }
        
//        keyboardHighlighter.highlightKeyboards(
//          selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
//          chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
//          chordCombinerViewModel: chordCombinerViewModel,
//          selectedKeyboard: &selectedKeyboard,
//          selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor,
//          combinedKeyboard: &combinedKeyboard
//        )
      })
    }
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
