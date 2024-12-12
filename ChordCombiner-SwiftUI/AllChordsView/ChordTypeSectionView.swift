//
//  ChordTypeSectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct NonBinding_ChordTypeSectionView: View {
  let section: ChordTypeSection
  let rootKeyNote: RootKeyNote
  var isExpanded: Bool
  @Binding var expandedSections: Set<String>
  @State var keyboardDisplay: Bool = false
  
  var body: some View {
    content
  }
    
  private var content: some View {
    VStack(alignment: .leading) {
      ChordTypeSectionTitleView(
        section: section,
        isExpanded: isExpanded,
        keyboardDisplay: $keyboardDisplay,
        expandedSections: $expandedSections
      )
            
      if isExpanded {
        NonBinding_KeyboardDisplayScrollView(
          section: section,
          rootKeyNote: rootKeyNote,
          keyboardDisplay: $keyboardDisplay
        )
      }
    }
    .padding([.horizontal, .bottom], 8)
  }
}

struct ChordTypeSectionView: View {
  let section: ChordTypeSection
  @Binding var rootKeyNote: RootKeyNote
  var isExpanded: Bool
  @Binding var expandedSections: Set<String>
  @State var keyboardDisplay: Bool = false
  
  var body: some View {
    content
  }
    
  private var content: some View {
    VStack(alignment: .leading) {
      ChordTypeSectionTitleView(
        section: section,
        isExpanded: isExpanded,
        keyboardDisplay: $keyboardDisplay,
        expandedSections: $expandedSections
      )
            
      if isExpanded {
        KeyboardDisplayScrollView(
          section: section,
          rootKeyNote: $rootKeyNote,
          keyboardDisplay: $keyboardDisplay
        )
      }
    }
    .padding([.horizontal, .bottom], 8)
  }
}

#Preview {
  ChordTypeSectionView(
    section: ChordType.chordTypeSections[5],
    rootKeyNote: Binding.constant(.c),
    isExpanded: true,
    expandedSections: Binding.constant([])
  )
  .padding()
}
