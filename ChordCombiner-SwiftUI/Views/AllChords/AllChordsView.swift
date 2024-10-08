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
      Divider()
        .overlay {
          Color.title
        }
      ScrollView {
        VStack(alignment: .leading) {
          ForEach(chordTypeSections, id: \.tagName) { section in
            KeyboardDisplayScrollView(section: section, rootKeyNote: $rootKeyNote, isExpanded: expandedSections.contains(section.tagName), expandedSections: $expandedSections, kbDisplay: false)
          }
        }
      }
      
//      .listRowBackground(Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1))
      .background {
//        Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1)
      }
      .listStyle(.insetGrouped)
    }
    .padding(.bottom, 20)
    .background {
      Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1)
    }
  }
}

#Preview {
  AllChordsView()
}
