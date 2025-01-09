//
//  DualKeyboardHelpView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 1/8/25.
//

import SwiftUI

struct DualKeyboardHelpCircle: View {
  var circleType: KeyCircleType = .lower

  var body: some View {
    HStack(spacing: 5) {
        ZStack {
          Rectangle()
            .frame(width: 15, height: 15)
            .foregroundStyle(
              circleType == .upper ? .upperChordHighlight : .lowerChordHighlight)
          Circle()
            .frame(width: 13, height: 13)
            .foregroundStyle(circleType.helpColor)
          KeyCirclesView(
            width: 15,
            sizeMultiplier: 1,
            circlesOn: true,
            circleType: circleType,
            lineWidth: 1)
        }
      TitleView(
        text: ":",
        font: .body,
        weight: .regular)
        .padding(.trailing, 10)

      Text(circleType.helpText)
      Spacer()
    }
  }
}

struct DualKeyboardHelpView: View {
  @Environment(\.dismiss) private var dismiss

  var keyboard: Keyboard

  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button {
          dismiss()
        } label: {
          TitleView(
            text: "Done",
            font: .body,
            weight: .regular)
        }
      }

      VStack(alignment: .leading, spacing: 10) {
        TitleView(
          text: "Symbols Legend:",
          font: .headline,
          weight: .regular)

        DualKeyboardHelpCircle(circleType: .lower)
        DualKeyboardHelpCircle(circleType: .upper)
        DualKeyboardHelpCircle(circleType: .common)
      }

      Spacer()
    }
    .padding()
  }
}
