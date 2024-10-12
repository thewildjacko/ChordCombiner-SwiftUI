//
//  AllChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/26/24.
//

import SwiftUI

struct AllChordsView: View {
  @State var chordTypeSections = ChordType.chordTypeSections
  @State private var selectedSections: Set<ChordTypeSection> = []
  @State private var selectedLetter: Letter = .c
  @State private var selectedAccidental: RootAccidental = .natural
  @State private var rootKeyNote: RootKeyNote = RootKeyNote(.c, .natural)
  @State private var expandedSections: Set<String> = [ChordType.chordTypeSections[0].tagName]
  
  var body: some View {
    VStack {
      ChordAndKeySelectionView(
        chordTypeSections: $chordTypeSections,
        selectedSections: $selectedSections,
        selectedLetter: $selectedLetter,
        selectedAccidental: $selectedAccidental,
        rootKeyNote: $rootKeyNote,
        expandedSections: $expandedSections)
      
      TitleColorDivider()
      
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(chordTypeSections, id: \.tagName) { section in
            ChordTypeSectionView(
              section: section,
              rootKeyNote: $rootKeyNote, 
              isExpanded: expandedSections.contains(section.tagName),
              expandedSections: $expandedSections,
              kbDisplay: false
            )
          }
        }
      }
      .listStyle(.insetGrouped)
    }
    .padding(.bottom, 20)
    .background { Color(.tagViewBackground) }
  }
}

#Preview {
  AllChordsView()
}
