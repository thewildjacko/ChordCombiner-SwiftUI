//
//  DualChordDetailView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/16/24.
//

import SwiftUI

struct DualChordDetailView: View {
  var chordCombinerViewModel: ChordCombinerViewModel
  
  var titleText: String {
    return chordCombinerViewModel.resultChord != nil ?
    chordCombinerViewModel.displayDetails(detailType: .commonName) :
    chordCombinerViewModel.displayDetails(detailType: .preciseName)
  }
  
  var titleFont: Font {
    chordCombinerViewModel.resultChord != nil ? .largeTitle : .title
  }
  
  var showCaption: Bool
  
  var body: some View {
    VStack(spacing: 20) {
      DualChordTitleView(chordCombinerViewModel: chordCombinerViewModel, titleText: titleText, titleFont: titleFont, showCaption: showCaption)
            
      chordCombinerViewModel.combinedKeyboard
      
      Form {
        List {
          DetailRow(title: "Notes", text: chordCombinerViewModel.displayDetails(detailType: .noteNames))
          DetailRow(title: "Degrees", text: chordCombinerViewModel.displayDetails(detailType: .degreeNames))
        }
        
        if let resultChord = chordCombinerViewModel.resultChord {
          NavigationLink(
            destination:
              ChordGrapherView(chordGrapher: ChordGrapher(chord: resultChord))
              .navigationTitle("Chord Graph")
          ) {
            Text("Chord Graph:")
          }
        }
        
        Section(header: Text("Component Chords")) {
          DetailRow(title: "Lower Chord", text: chordCombinerViewModel.displayDetails(detailType: .lowerChordName))
          DetailRow(title: "Upper Chord", text: chordCombinerViewModel.displayDetails(detailType: .upperChordName))
        }
        
        EquivalentChordsSectionView(chord: chordCombinerViewModel.resultChord)
      }

      Spacer()
    }
    .padding(.vertical)
  }
}

#Preview("Both chords selected") {
  DualChordDetailView(
    chordCombinerViewModel: ChordCombinerViewModel(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7),
      upperChordProperties: ChordProperties(letter: .e, accidental: .natural, chordType: .sus4)
    ),
    showCaption: true
  )
}

#Preview("Lower chord selected") {
  DualChordDetailView(
    chordCombinerViewModel: ChordCombinerViewModel(
      lowerChordProperties: ChordProperties(letter: .c, accidental: .natural, chordType: .ma7)
    ),
    showCaption: true
  )
}

#Preview("Upper chord selected") {
  DualChordDetailView(
    chordCombinerViewModel: ChordCombinerViewModel(
      upperChordProperties: ChordProperties(letter: .d, accidental: .natural, chordType: .ma)
    ),
    showCaption: true
  )
}

#Preview("No chords selected") {
  DualChordDetailView(chordCombinerViewModel: ChordCombinerViewModel(),
                      showCaption: true)
}
