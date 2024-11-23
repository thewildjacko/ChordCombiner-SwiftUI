//
//  DualChordKeyboardView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/22/24.
//

import SwiftUI

struct DualChordKeyboardView: View {
  var chordCombinerViewModel: ChordCombinerViewModel
  @Binding var keyboard: Keyboard
  
  var dualChordKeyboardChordSymbolTitleSelector: DualChordKeyboardChordSymbolTitleSelector {
    DualChordKeyboardChordSymbolTitleSelector(chordCombinerViewModel: chordCombinerViewModel)
  }
    
  var titleText: String { dualChordKeyboardChordSymbolTitleSelector.chordSymbolText
  }
  
  var titleFont: Font {
    if let _ = chordCombinerViewModel.resultChord {
      return .title
    } else {
      switch chordCombinerViewModel.chordSelectionStatus {
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
        DualChordTitleView(chordCombinerViewModel: chordCombinerViewModel, titleText: dualChordKeyboardChordSymbolTitleSelector.chordSymbolText, titleFont: titleFont)  
        DualChordDetailNavigationLinkView(chordCombinerViewModel: chordCombinerViewModel)
      }
      
      keyboard
    }
  }
}

#Preview("Both chords selected") {
  DualChordKeyboardView(
    chordCombinerViewModel: ChordCombinerViewModel(
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
    chordCombinerViewModel: ChordCombinerViewModel(
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
    chordCombinerViewModel: ChordCombinerViewModel(
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
    chordCombinerViewModel: ChordCombinerViewModel(),
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
