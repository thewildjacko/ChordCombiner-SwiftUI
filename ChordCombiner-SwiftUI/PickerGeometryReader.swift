//
//  PickerGeometryReader.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI

struct PickerGeometryReader: View {
  @Binding var lowerChord: FourNoteChord
  
  var body: some View {
    GeometryReader { geometry in
      HStack(spacing: -15) {
        LetterPicker(letter: $lowerChord.letter)
          .pickerStyle(.wheel)
          .frame(width: geometry.size.width * 2/9, height: 250)
          .clipped()
        AccidentalPicker(accidental: $lowerChord.accidental)
          .pickerStyle(.wheel)
          .frame(width: geometry.size.width * 2/9, height: 130)
          .clipped()
        FNCTypePicker(type: $lowerChord.type)
          .pickerStyle(.wheel)
          .frame(width: geometry.size.width * 5/9, height: 250)
          .clipped()
      }
    }    }
}

#Preview {
  PickerGeometryReader(lowerChord: Binding.constant(FourNoteChord()))
}
