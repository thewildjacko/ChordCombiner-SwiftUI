//
//  TagsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct TagsView: View {
  @Binding var selectedSections: Set<ChordTypeSection>
  @Binding var expandedSections: Set<String>
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 5) {
        ForEach(ChordType.chordTypeSections, id: \.id) { section in
          Text(section.tagName)
            .tagView(
              condition: selectedSections.contains(section),
              font: .headline,
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
      .font(.caption)
    }
  }
}

#Preview {
  TagsView(selectedSections: Binding.constant([]), expandedSections: Binding.constant([]))
}
