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
      isLowerChordMenu: isLowerChordMenu,
      matchingLetters: $matchingLetters,
      matchingAccidentals: $matchingAccidentals,
      matchingChordTypes: $matchingChordTypes
    )
  }

  // MARK: Initializer
  init(
    chordProperties: Binding<ChordProperties>,
    islowerChordMenu: Bool) {
      self._chordProperties = chordProperties
      self.isLowerChordMenu = islowerChordMenu

      setChordCombinerSelectedChordTitleModel()
      setRootKeyNote()
    }

  // MARK: Initializer helper methods
  mutating func setChordCombinerSelectedChordTitleModel() {
    chordCombinerSelectedChordTitleModel = ChordCombinerSelectedChordTitleModel(isLowerChordMenu: isLowerChordMenu)
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
      if isLowerChordMenu {
        keyboardHighlighter.highlightSelectedChord(
          selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
          selectedKeyboard: &chordCombinerViewModel.lowerKeyboard,
          selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor)
      } else {
        keyboardHighlighter.highlightSelectedChord(
          selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
          selectedKeyboard: &chordCombinerViewModel.upperKeyboard,
          selectedChordColor: chordCombinerSelectedChordTitleModel.selectedChordColor)
      }

      keyboardHighlighter.highlightKeyboards(
        selectedChord: chordCombinerSelectedChordTitleModel.selectedChord,
        chordToMatch: chordCombinerSelectedChordTitleModel.chordToMatch,
        combinedKeyboard: &chordCombinerViewModel.combinedKeyboard
      )
    }
  }

  // MARK: Body
  var body: some View {
    VStack(spacing: 8) {
      SingleChordTitleNavigationStackView(
        keyboardWidth: chordCombinerViewModel.upperKeyboard.width,
        selectedKeyboard: isLowerChordMenu
        ? chordCombinerViewModel.lowerKeyboard
        : chordCombinerViewModel.upperKeyboard,
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

      DualChordKeyboardView(chordCombinerSelectedChordTitleModel: chordCombinerSelectedChordTitleModel)

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
  ChordCombinerChordSelectionMenu(chordProperties: .constant(ChordProperties.initial), islowerChordMenu: true)
}
