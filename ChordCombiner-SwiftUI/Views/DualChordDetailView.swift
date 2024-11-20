//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
  var multiChord: MultiChord
  
  var titleText: String {
    return multiChord.resultChord != nil ?
    multiChord.displayDetails(detailType: .commonName) :
    multiChord.displayDetails(detailType: .preciseName)
  }
  
  var titleFont: Font {
    multiChord.resultChord != nil ? .largeTitle : .title
  }
  
  var body: some View {
    VStack(spacing: 20) {
      DualChordTitleView(multiChord: multiChord, titleText: titleText, titleFont: titleFont)
            
      multiChord.combinedKeyboard
      
      Form {
        List {
          DetailRow(title: "Notes", text: multiChord.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: multiChord.displayDetails(detailType: .degreeNames))
        }
        
        Section(header: Text("Component Chords")) {
          DetailRow(title: "Lower Chord", text: multiChord.displayDetails(detailType: .lowerChordName))
          DetailRow(title: "Upper Chord", text: multiChord.displayDetails(detailType: .upperChordName))
        }
        
        EquivalentChordsSectionView(chord: multiChord.resultChord)
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview("Both chords selected") {
  DualChordDetailView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    )
  )
}

#Preview("Lower chord selected") {
  DualChordDetailView(
    multiChord: MultiChord(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7)
    )
  )
}

#Preview("Upper chord selected") {
  DualChordDetailView(
    multiChord: MultiChord(
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    )
  )
}

#Preview("No chords selected") {
  DualChordDetailView(multiChord: MultiChord())
}
