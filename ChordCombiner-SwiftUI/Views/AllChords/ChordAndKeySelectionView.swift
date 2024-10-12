//
//  ChordAndKeySelectionView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct ChordAndKeySelectionView: View {
  @Binding var chordTypeSections: [ChordTypeSection]
  @Binding var selectedSections: Set<ChordTypeSection>
  @Binding var selectedLetter: Letter
  @Binding var selectedAccidental: RootAccidental
  @Binding var rootKeyNote: RootKeyNote
  @Binding var expandedSections: Set<String>
  @State var text = "Expand All"
  
  var body: some View {
    VStack {
      ChordSectionTagsView(selectedSections: $selectedSections, expandedSections: $expandedSections)
        .padding([.horizontal, .top], 10)
        .onAppear(perform: {
          expandedSections = Set([chordTypeSections[0].tagName])
        })
        .onChange(of: selectedSections.count) {
          if selectedSections.isEmpty {
            chordTypeSections = ChordType.chordTypeSections
          } else {
            chordTypeSections = Array(selectedSections.sorted(by: { $0.id < $1.id }))
          }
        }
      
      TitleColorDivider()
        .titleColorOverlay()
      
      HStack(alignment: .bottom) {
        LetterTagsView(selectedLetter: $selectedLetter)
          .onChange(of: selectedLetter) { oldValue, newValue in
            rootKeyNote = RootKeyNote(newValue, selectedAccidental)
          }
        Divider()
          .frame(height: 30)
          .titleColorOverlay()
        
        AccidentalTagsView(selectedAccidental: $selectedAccidental)
          .onChange(of: selectedAccidental) { oldValue, newValue in
            rootKeyNote = RootKeyNote(selectedLetter, newValue)
          }
      }
      
      TitleColorDivider()
      
      Text(text)
        .roundRectTagView(font: .caption, horizontalPadding: 8, verticalPadding: 5, cornerRadius: 12)
        .onTapGesture {
          if text == "Expand All" {
            expandedSections = Set(chordTypeSections.map { $0.tagName })
            text = "Collapse All"
          } else {
            expandedSections.removeAll(keepingCapacity: true)
            text = "Expand All"
          }
        }
    }
  }
}

#Preview {
  ChordAndKeySelectionView(chordTypeSections: Binding.constant(ChordType.chordTypeSections), selectedSections: Binding.constant([ChordType.chordTypeSections[0]]), selectedLetter: Binding.constant(.c), selectedAccidental: Binding.constant(.natural), rootKeyNote: Binding.constant(.c), expandedSections: Binding.constant([]))
}
