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

  var rootKeyNote: RootKeyNote?

  var chordCombinerPropertyMatcher: ChordCombinerPropertyMatcher {
    ChordCombinerPropertyMatcher(
      lowerChord: chordCombinerViewModel.lowerChord,
      upperChord: chordCombinerViewModel.upperChord,
      isLowerChordMenu: chordCombinerSelectedChordTitleModel.isLowerChordMenu,
      matchingLetters: $matchingLetters,
      matchingAccidentals: $matchingAccidentals,
      matchingChordTypes: $matchingChordTypes
    )
  }

  init(
    chordCombinerViewModel: ChordCombinerViewModel,
    selectedKeyboard: Binding<Keyboard>,
    combinedKeyboard: Binding<Keyboard>,
    chordProperties: Binding<ChordProperties>) {
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

  func highlightKeyboardsOnSelect() {
    if chordCombinerSelectedChordTitleModel.selectedChord != nil {
      keyboardHighlighter.highlightSelectedChord(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor)

      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        chordCombinerViewModel: chordCombinerViewModel,
        //        selectedKeyboard: &selectedKeyboard,
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
//        .containerRelativeFrame(.vertical) { height, _ in height * 3/24  }

        DualChordKeyboardView(
          chordCombinerViewModel: chordCombinerViewModel,
          keyboard: $combinedKeyboard
        )

        Spacer()
      }
      .padding()
      .onAppear(perform: {
        if chordCombinerViewModel.lowerChord != nil,
           chordCombinerViewModel.upperChord != nil {
          chordCombinerPropertyMatcher.matchChords()
        }
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord) {
        highlightKeyboardsOnSelect()
      }
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.letter) {
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .letter)

        highlightKeyboardsOnSelect()
      }
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.accidental, { oldValue, _ in
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .accidental)

        if oldValue != nil { highlightKeyboardsOnSelect() }
      })
      .onChange(of: chordCombinerSelectedChordTitleModel.selectedChord?.chordType, { oldValue, _ in
        chordCombinerPropertyMatcher.clearAndMatchChords(propertyChanged: .chordType)

        if oldValue != nil { highlightKeyboardsOnSelect() }
      })
    }
  }
}

#Preview {
  ChordCombinerChordSelectionMenu(
    chordCombinerViewModel: ChordCombinerViewModel(),
    selectedKeyboard: .constant(Keyboard.initialSingleChordKeyboard),
    combinedKeyboard: .constant(Keyboard.initialDualChordKeyboard),
    chordProperties: .constant(ChordProperties.initial)
  )
}
