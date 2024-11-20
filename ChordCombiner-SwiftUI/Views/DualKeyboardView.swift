//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var multiChord: MultiChord
  
  var dualChordKeyboardChordSymbolTitleSelector: DualChordKeyboardChordSymbolTitleSelector {
    DualChordKeyboardChordSymbolTitleSelector(multiChord: multiChord)
  }
    
  var titleText: String { dualChordKeyboardChordSymbolTitleSelector.chordSymbolText
  }
  
  var titleFont: Font {
    if let _ = multiChord.resultChord {
      return .title
    } else {
      switch multiChord.chordSelectionStatus {
      case .lowerChordIsSelected, .upperChordIsSelected:
        return .title
      default:
        return .headline
      }
    }
  }
  
  var body: some View {
    VStack(spacing: 20) {
      HStack {
        DualChordTitleView(multiChord: multiChord, titleText: dualChordKeyboardChordSymbolTitleSelector.chordSymbolText, titleFont: titleFont)  
        DualChordDetailNavigationLinkView(multiChord: multiChord)
      }
      
      multiChord.combinedKeyboard
    }
  }
}

#Preview("Both chords selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    )
  )
}

#Preview("Lower chord selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7)
    )
  )
}

#Preview("Upper chord selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    )
  )
}

#Preview("No chords selected") {
  DualChordKeyboardView(multiChord: MultiChord())
}
