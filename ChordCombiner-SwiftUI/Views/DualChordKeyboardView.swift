//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var multiChord: MultiChord
  @Binding var keyboard: Keyboard
  
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
      
      keyboard
    }
  }
}

#Preview("Both chords selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    ), keyboard: .constant(
      Keyboard(
        baseWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    )
  )
}

#Preview("Lower chord selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7)
    ), keyboard: .constant(
      Keyboard(
        baseWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    )
  )
}

#Preview("Upper chord selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    ), keyboard: .constant(
      Keyboard(
        baseWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    )
  )
}

#Preview("No chords selected") {
  DualChordKeyboardView(
    multiChord: MultiChord(),
    keyboard: .constant(
      Keyboard(
        baseWidth: 351,
        initialKeyType: .C,
        startingOctave: 4,
        octaves: 5
      )
    )
  )
}
