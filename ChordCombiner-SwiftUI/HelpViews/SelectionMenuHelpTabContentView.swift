//
//  SelectionMenuHelpTabContentView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/9/25.
//

import SwiftUI

struct SelectionMenuHelpTabContentView: View {
  let chordPropertyType: ChordPropertyType

  var chordPropertyTitleText: String {
    switch chordPropertyType {
    case .letter:
      "Letter"
    case .accidental:
      "Accidental"
    case .chordType:
      "Chord Type"
    }
  }

  var lowerOrUpperText: String {
    switch chordPropertyType {
    case .letter:
      "Lower"
    case .accidental:
      "Lower"
    case .chordType:
      "Upper"
    }
  }

  var lowerChordSymbol: String {
    switch chordPropertyType {
    case .letter:
      "Cma7"
    case .accidental:
      "Bma7"
    case .chordType:
      "Cmi"
    }
  }

  var upperChordSymbol: String {
    switch chordPropertyType {
    case .letter:
      "Dma"
    case .accidental:
      "E♭ma"
    case .chordType:
      "Dma"
    }
  }

  var selectedText: String {
    switch chordPropertyType {
    case .letter:
      "C is selected and matches"
    case .accidental:
      "\"♮\" is selected but doesn't match"
    case .chordType:
      "Dma is selected and matches"
    }
  }

  var matchesText: String {
    switch chordPropertyType {
    case .letter:
      "D, G & A also match"
    case .accidental:
      "\"♭\" matches"
    case .chordType:
      "Dmi also matches"
    }
  }

  var noMatchesText: String {
    switch chordPropertyType {
    case .letter:
      "E, F & B don't match"
    case .accidental:
      "\"♯\" doesn't match"
    case .chordType:
      "D+ (augmented) doesn't match"
    }
  }

  var resultsText: String {
    switch chordPropertyType {
    case .letter:
      "Cma7, Dma7, Gma7 and Ama7 each combine with Dma"
    case .accidental:
      "B♭ma7 combines with E♭ma"
    case .chordType:
      "Dma and Dmi each combine with Cmi"
    }
  }

  @ViewBuilder
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("\(chordPropertyTitleText) Picker")
        .font(.headline)

      HStack {
        Spacer()
        Text("Example: \(lowerOrUpperText) Chord Menu")
          .fontWeight(.bold)
        Spacer()
      }

      VStack(alignment: .leading) {
        Text("Lower Chord: \(lowerChordSymbol)")
        Text("Upper Chord: \(upperChordSymbol)")
      }
      .font(.footnote)

      VStack(alignment: .center) {
        TitleColorDivider()

        switch chordPropertyType {
        case .letter:
          ChordCombinerTagsView(
            selectedProperty: .constant(Letter.c),
            matchingProperties: .constant([Letter.c, Letter.d, Letter.g, Letter.a]),
            tagProperties: Letter.allCases,
            isHorizontal: true,
            font: .headline,
            horizontalPadding: 10,
            verticalPadding: 1.5,
            cornerRadius: 5,
            spacing: 8,
            highlightColor: .tagBackgroundHighlighted
          )
        case .accidental:
          ChordCombinerTagsView(
            selectedProperty: .constant(RootAccidental.natural),
            matchingProperties: .constant([RootAccidental.flat]),
            tagProperties: RootAccidental.allCases,
            isHorizontal: true,
            font: .headline,
            horizontalPadding: 10,
            verticalPadding: 1.5,
            cornerRadius: 5,
            spacing: 8,
            highlightColor: .tagBackgroundHighlighted
          )
        case .chordType:
          ChordCombinerKeyboardScrollView(
            keyboardWidth: 100,
            selectedChordType: .constant(ChordType.ma),
            matchingChordTypes: .constant(ChordType.helpViewPickerDemoTypes),
            chordTypes: ChordType.allSimpleChordTypes,
            rootKeyNote: RootKeyNote.d,
            color: .lowerChordHighlight
          )
        }

        TitleColorDivider()

          VStack(alignment: .center) {
            Text(selectedText)
            Text(matchesText)
            Text(noMatchesText)
              .padding(.bottom, 5)
            Text("\(resultsText) to create a valid chord")
          }
          .font(.footnote)

        Spacer()
      }

      Spacer()
    }
    .foregroundStyle(.title)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
