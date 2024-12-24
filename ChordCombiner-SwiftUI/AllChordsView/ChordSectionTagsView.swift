//
//  ChordSectionTagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct ChordSectionTagsView: View {
  @Binding var selectedSections: Set<ChordTypeSection>
  @Binding var expandedSections: Set<String>
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 5) {
        ForEach(ChordType.chordTypeSections, id: \.id) { section in
          HighlightableTagView(
            text: section.tagName,
            highlightCondition: selectedSections.contains(section),
            horizontalPadding: 8,
            verticalPadding: 5,
            cornerRadius: 8
          )
          .onTapGesture {
            if selectedSections.contains(section) {
              selectedSections.remove(section)
              expandedSections.remove(section.tagName)
            } else {
              selectedSections.insert(section)
              expandedSections.insert(section.tagName)
            }
          }
        }
      }
    }
  }
}

#Preview {
  ChordSectionTagsView(selectedSections: Binding.constant([]), expandedSections: Binding.constant([]))
}
