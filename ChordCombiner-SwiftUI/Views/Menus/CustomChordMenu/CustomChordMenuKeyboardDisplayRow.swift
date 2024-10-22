//
//  CustomChordMenuKeyboardDisplayRow.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/20/24.
//

import SwiftUI

struct CustomChordMenuKeyboardDisplayRow: View {
  @Binding var selectedChordType: ChordType?
  @Binding var matchingChordTypes: Set<ChordType>
  
  var chordType: ChordType
  var titleText: String
  var titleColor: Color
  var keyboard: Keyboard
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      VStack(alignment: .leading, spacing: 10) {
        TitleView(
          text: titleText,
          font: .title3, weight: .heavy,
          color: titleColor
        )
        
        keyboard
      }
      .onTapGesture { selectedChordType = chordType }
      
      Spacer()
      
      if matchingChordTypes.contains(chordType) {
        TitleView(text: "match found!", font: .caption, weight: .bold, color: .glowText)
      }
    }
  }
}
