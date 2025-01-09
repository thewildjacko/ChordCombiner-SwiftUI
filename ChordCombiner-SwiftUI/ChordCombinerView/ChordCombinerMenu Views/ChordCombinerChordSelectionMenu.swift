//
//  ChordCombinerChordSelectionMenu.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/12/24.
//

import SwiftUI

struct ChordCombinerChordSelectionMenu: View {
  let keyboardHighlighter: KeyboardHighlighter = KeyboardHighlighter()

  var chordCombinerViewModel = ChordCombinerViewModel.singleton()

  @Binding var selectedKeyboard: Keyboard
  @Binding var combinedKeyboard: Keyboard
  @Binding var chordProperties: ChordProperties {
    mutating didSet {
      setChordCombinerSelectedChordTitleModel()
      setRootKeyNote()
    }
  }
  let isLowerChordMenu: Bool

  @State var matchingLetters: Set<Letter> = []
  @State var matchingAccidentals: Set<RootAccidental> = []
  @State var matchingChordTypes: Set<ChordType> = []
  @State var shouldPresentSelectionHelpView = false

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

  // MARK: Initializer
  init(
    selectedKeyboard: Binding<Keyboard>,
    combinedKeyboard: Binding<Keyboard>,
    chordProperties: Binding<ChordProperties>,
    islowerChordMenu: Bool) {
      self._selectedKeyboard = selectedKeyboard
      self._combinedKeyboard = combinedKeyboard
      self._chordProperties = chordProperties
      self.isLowerChordMenu = islowerChordMenu

      setChordCombinerSelectedChordTitleModel()
      setRootKeyNote()
    }

  // MARK: Initializer helper methods
  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(
      chordProperties: chordProperties,
      isLowerChordMenu: isLowerChordMenu
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

  // MARK: Instance methods
  func highlightKeyboardsOnSelect() {
    if chordCombinerSelectedChordTitleModel.selectedChord != nil {
      keyboardHighlighter.highlightSelectedChord(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        selectedKeyboard: &selectedKeyboard,
        selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor)

      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        combinedKeyboard: &combinedKeyboard
      )
    }
  }

  // MARK: Body
  var body: some View {
    VStack(spacing: 8) {
      SingleChordTitleNavigationStackView(
        keyboardWidth: selectedKeyboard.width,
        selectedKeyboard: $selectedKeyboard,
        chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel
      )

      ChordCombinerPropertySelectionView(
        keyboardWidth: chordCombinerViewModel.lowerKeyboard.width * 0.42,
        chordProperties: $chordProperties,
        matchingLetters: $matchingLetters,
        matchingAccidentals: $matchingAccidentals,
        matchingChordTypes: $matchingChordTypes,
        chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel
      )

      DualChordKeyboardView(
        keyboard: $combinedKeyboard,
        chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel)

      Spacer()
    }
    .padding()
    .background(.primaryBackground)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          shouldPresentSelectionHelpView.toggle()
        } label: {
          Image(systemName: "questionmark.circle")
        }
        .sheet(isPresented: $shouldPresentSelectionHelpView) {
            SelectionMenuHelpView()
            .presentationBackground(.ultraThinMaterial)
        }
      }
    }
    .onAppear(perform: {
      if chordCombinerViewModel.lowerChord != nil,
         chordCombinerViewModel.upperChord != nil {
        chordCombinerPropertyMatcher.matchChords()
      }
    })
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

#Preview {
  ChordCombinerChordSelectionMenu(
    selectedKeyboard: .constant(Keyboard.initialSingleChordKeyboard),
    combinedKeyboard: .constant(Keyboard.initialDualChordKeyboard),
    chordProperties: .constant(ChordProperties.initial),
    islowerChordMenu: true
  )
}
