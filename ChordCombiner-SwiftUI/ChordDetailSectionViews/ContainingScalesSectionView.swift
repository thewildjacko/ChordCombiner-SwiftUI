//
//  ContainingScalesSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/19/25.
//

import SwiftUI

struct ContainingScalesSectionView: View {
  @Binding var containingScales: [Scale]

  var keyboardWidth: CGFloat = 351
  let chord: Chord
  var chordNotesCount: Int { chord.notes.count }
  var primaryScales: [Scale] = []
  var parentScales: [Scale] = []
  var pentatonicScales: [Scale] = []

  init(keyboardWidth: CGFloat, chord: Chord, containingScales: Binding<[Scale]>) {
    self.keyboardWidth = keyboardWidth
    self.chord = chord
    self._containingScales = containingScales

    getPrimaryScales()
    parentScales = self.containingScales.filter { $0.scaleType.isParentScaleType && !$0.scaleType.isPentatonic }
    pentatonicScales = self.containingScales.filter { $0.scaleType == .pentatonic }
  }

  mutating func getPrimaryScales() {
    for scale in containingScales
    where scale.root == chord.root &&
    !primaryScales.contains(scale) &&
    !scale.scaleType.isPentatonic {
      primaryScales.append(scale)
    }
  }

  mutating func getParentScales() {
    for scale in primaryScales {
      let degreeNumberSet = scale.scalePitchCalculator.degreeNumberSet
      if scale.scaleType.isParentScaleType {
        if let parentScale = containingScales.first(
          where: { $0.scalePitchCalculator.degreeNumberSet == degreeNumberSet }) {
          parentScales.append(parentScale)
        }
      } else {

      }
    }
  }

  var primaryParentSectionHeaderText: String {
    !parentScales.isEmpty ? "Primary Scales" : "Primary/Parent Scales"
  }

  @ViewBuilder
  var body: some View {
    if !containingScales.isEmpty {
      Section(header: Text(primaryParentSectionHeaderText)) {
        List {
          ForEach(primaryScales) { scale in
            NavigationLink {
              ScaleDetailView(scale: scale, keyboardWidth: keyboardWidth)
            } label: {
              TitleView(text: scale.details.name, font: .headline)
            }
          }
        }
      }

      if primaryScales != parentScales {
        Section(header: Text("Parent Scales")) {
          List {
            ForEach(parentScales) { scale in
              NavigationLink {
                ScaleDetailView(scale: scale, keyboardWidth: keyboardWidth)
              } label: {
                TitleView(text: scale.details.name, font: .headline)
              }
            }
          }
        }
      }

      if !pentatonicScales.isEmpty {
        Section(header: Text("Pentatonic Scales")) {
          List {
            ForEach(pentatonicScales) { scale in
              NavigationLink {
                ScaleDetailView(scale: scale, keyboardWidth: keyboardWidth)
              } label: {
                TitleView(text: scale.details.name, font: .headline)
              }
            }
          }
        }
      }
    } else {
      Text("loading scales or no scales found...")
    }
  }
}

#Preview {
  ContainingScalesSectionView(
    keyboardWidth: 351,
    chord: Chord(.c, .ma7),
    containingScales: .constant([]))
}
