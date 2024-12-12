//
//  KeyLetterView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/10/24.
//

import SwiftUI

struct KeyLetterView: View {
  let width: CGFloat
  let sizeMultiplier: CGFloat
  let textColor: Color
  var note: Note?
  var lettersOn: Bool
  
  init(width: CGFloat, sizeMultiplier: CGFloat, textColor: Color, note: Note? = nil, lettersOn: Bool) {
    self.width = width
    self.sizeMultiplier = sizeMultiplier
    self.textColor = textColor
    self.note = note
    self.lettersOn = lettersOn
  }
  
  @ViewBuilder
  var body: some View {
    if lettersOn {
      if let note = note {
        TitleView(
          text: note.noteName,
          font: .system(size: width * sizeMultiplier),
          color: textColor
        )
      }
    }
  }
}
