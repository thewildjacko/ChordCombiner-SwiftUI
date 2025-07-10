//
//  ModeDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/21/25.
//

import SwiftUI

struct SelectedOrParentScaleDetailRow: View {
  var scale: Scale
  var isSelectedOrParentScale: Bool
  var detailTitle: String
  var detailText: String
  var detailColor: Color = .title
  var keyboardWidth: CGFloat

  @ViewBuilder
  var body: some View {
    if isSelectedOrParentScale {
      DetailRow(
        title: detailTitle,
        text: detailText,
        color: detailColor)
    } else {
      NavigationLink {
        ScaleDetailView(
          scale: scale,
          keyboardWidth: keyboardWidth)
      } label: {
        DetailRow(
          title: detailTitle,
          text: detailText)
      }
    }
  }
}

struct NotesDegreesAndModesDetailView: View {
  let scale: Scale
  var keyboardWidth: CGFloat = 351
  @Binding var modes: [Scale]

  var parentScale: Scale { modes.first ?? scale }

  init(scale: Scale, keyboardWidth: CGFloat, modes: Binding<[Scale]>) {
    self.scale = scale
    self.keyboardWidth = keyboardWidth
    self._modes = modes
  }

  @ViewBuilder
  var body: some View {
    Section {
      List {
        DetailRow(
          title: "Notes",
          text: scale.details.noteNames)
        DetailRow(
          title: "Degrees",
          text: scale.details.degreeNames)
        DetailRow(title: "Mode", text: scale.scaleType.romanNumeral)

        SelectedOrParentScaleDetailRow(
          scale: scale,
          isSelectedOrParentScale: scale.scaleType.isParentScaleType,
          detailTitle: "Parent Scale",
          detailText: parentScale.details.name,
          keyboardWidth: keyboardWidth)
      }
    }

    Section(header: Text("Modes of \(modes.first?.details.name ?? "")")) {
      List {
        ForEach(modes) { mode in
          let modeIsScale = mode == scale
          let modeTitle = modeIsScale ? "\(mode.details.name)*" : mode.details.name

          SelectedOrParentScaleDetailRow(
            scale: mode,
            isSelectedOrParentScale: modeIsScale,
            detailTitle: modeTitle,
            detailText: mode.scaleType.romanNumeral,
            detailColor: modeIsScale ? .tagTitleHighlighted : .title,
            keyboardWidth: keyboardWidth)
        }
      }
    }
  }
}

#Preview {
  @Previewable @State var modes: [Scale] = []
  let scale = Scale(.cSh, .diminished)

  NotesDegreesAndModesDetailView(
    scale: scale,
    keyboardWidth: 351,
    modes: $modes)
  .onAppear {
    Task {
      modes = await scale.getModes()
    }
  }
}
