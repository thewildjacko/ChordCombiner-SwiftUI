//
//  ChordTypeSectionsScrollView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/21/24.
//

import SwiftUI

struct ChordTypeSectionsScrollView: View {
  @Binding var chordTypeSections: [ChordTypeSection]
  @Binding var selectedSections: Set<ChordTypeSection>
  @Binding var rootKeyNote: RootKeyNote
  @Binding var expandedSections: Set<String>
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
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
}
