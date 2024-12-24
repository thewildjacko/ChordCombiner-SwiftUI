//
//  AllChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/26/24.
//

import SwiftUI

struct ChordSectionGroup: View {
  @Binding var chordTypeSections: [ChordTypeSection]
  @Binding var selectedSections: Set<ChordTypeSection>
  var rootKeyNote: RootKeyNote
  @Binding var expandedSections: Set<String>
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(chordTypeSections, id: \.tagName) { section in
          NonBinding_ChordTypeSectionView(
            section: section,
            rootKeyNote: rootKeyNote,
            isExpanded: expandedSections.contains(section.tagName),
            expandedSections: $expandedSections,
            keyboardDisplay: false
          )
        }
      }
    }
    .listStyle(.insetGrouped)
  }
}

struct SectionScrollView: View {
  @Binding var chordTypeSections: [ChordTypeSection]
  @Binding var selectedSections: Set<ChordTypeSection>
  @Binding var rootKeyNote: RootKeyNote
  @Binding var expandedSections: Set<String>
  
  @ViewBuilder
  var body: some View {
    if rootKeyNote == .c {
      ChordSectionGroup(
        chordTypeSections: $chordTypeSections,
        selectedSections: $selectedSections,
        rootKeyNote: rootKeyNote,
        expandedSections: $expandedSections
      )
    } else {
      ChordTypeSectionsScrollView(
        chordTypeSections: $chordTypeSections,
        selectedSections: $selectedSections,
        rootKeyNote: $rootKeyNote,
        expandedSections: $expandedSections
      )
    }
  }
}

struct AllChordsView: View {
  @State private var chordTypeSections: [ChordTypeSection] = ChordType.chordTypeSections
  @State private var selectedSections: Set<ChordTypeSection> = []
  @State private var selectedLetter: Letter = .c
  @State private var selectedAccidental: RootAccidental = .natural
  @State private var rootKeyNote: RootKeyNote = RootKeyNote(.c, .natural)
  @State private var expandedSections: Set<String> = [ChordType.chordTypeSections[0].tagName]
  
  var chordSectionGroups: [RootKeyNote: ChordSectionGroup] = [:]
  
  init(chordTypeSections: [ChordTypeSection] = ChordType.chordTypeSections, selectedSections: Set<ChordTypeSection> = [], selectedLetter: Letter = .c, selectedAccidental: RootAccidental = .natural, rootKeyNote: RootKeyNote = RootKeyNote.c, expandedSections: Set<String> = [ChordType.chordTypeSections[0].tagName]) {
    self.chordTypeSections = chordTypeSections
    self.selectedSections = selectedSections
    self.selectedLetter = selectedLetter
    self.selectedAccidental = selectedAccidental
    self.rootKeyNote = rootKeyNote
    self.expandedSections = expandedSections
    
    var chordSectionGroups: [RootKeyNote: ChordSectionGroup] = [:]
    chordSectionGroups.reserveCapacity(21)
    
    let rootKeyNotes = RootKeyNote.allCases
    
    for rootKeyNote in rootKeyNotes {
      chordSectionGroups.updateValue(
        ChordSectionGroup(
          chordTypeSections: $chordTypeSections,
          selectedSections: $selectedSections,
          rootKeyNote: rootKeyNote,
          expandedSections: $expandedSections
        ),
        forKey: rootKeyNote
      )
    }
    
    self.chordSectionGroups = chordSectionGroups
  }
      
  
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
      
      chordSectionGroups[rootKeyNote]
      
//      ChordTypeSectionsScrollView(
//        chordTypeSections: $chordTypeSections,
//        selectedSections: $selectedSections,
//        rootKeyNote: $rootKeyNote,
//        expandedSections: $expandedSections
//      )
    }
    .padding(.bottom, 20)
    .background { Color(.tagViewBackground) }
    .onChange(of: $chordTypeSections, <#T##action: (Equatable, Equatable) -> Void##(Equatable, Equatable) -> Void##(_ oldValue: Equatable, _ newValue: Equatable) -> Void#>)
  }
}

#Preview {
  AllChordsView()
}
