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
      TagsView(selectedSections: $selectedSections, expandedSections: $expandedSections)
        .padding(.horizontal, 10)
        .padding(.top, 10)
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
      Divider()
        .overlay {
          Color.title
        }
      HStack(alignment: .bottom) {
        LettersView(selectedLetter: $selectedLetter)
          .onChange(of: selectedLetter) { oldValue, newValue in
            rootKeyNote = RootKeyNote(newValue, selectedAccidental)
          }
        Divider()
          .frame(width: 2, height: 30)
          .overlay {
            Color.title
          }
        AccidentalsView(selectedAccidental: $selectedAccidental)
          .onChange(of: selectedAccidental) { oldValue, newValue in
            rootKeyNote = RootKeyNote(selectedLetter, newValue)
          }
      }
      
      Divider()
        .overlay {
          Color.title
        }
      Text(text)
        .font(.headline)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
        .foregroundStyle(.title)
        .fontWeight(.bold)
        .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
        .onTapGesture {
          if text == "Expand All" {
            expandedSections = Set(chordTypeSections.map { $0.tagName })
            text = "Collapse All"
          } else {
            expandedSections.removeAll()
            text = "Expand All"
          }
        }
       
    }
  }
}

#Preview {
  ChordAndKeySelectionView(chordTypeSections: Binding.constant(ChordType.chordTypeSections), selectedSections: Binding.constant([ChordType.chordTypeSections[0]]), selectedLetter: Binding.constant(.c), selectedAccidental: Binding.constant(.natural), rootKeyNote: Binding.constant(.c), expandedSections: Binding.constant([]))
}
