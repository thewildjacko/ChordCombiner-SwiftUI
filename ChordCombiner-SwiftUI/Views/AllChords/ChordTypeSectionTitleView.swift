//
//  ChordTypeSectionTitleView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/10/24.
//

import SwiftUI

struct ChordTypeSectionTitleView: View {
  var section: ChordTypeSection
  var isExpanded: Bool
  @Binding var kbDisplay: Bool
  @Binding var expandedSections: Set<String>
  
  func selectDeselect(_ section: ChordTypeSection) {
    if expandedSections.contains(section.tagName) {
      expandedSections.remove(section.tagName)
    } else {
      expandedSections.insert(section.tagName)
    }
  }
  
  var body: some View {
    HStack {
      HStack {
        Image(systemName: !isExpanded ? "chevron.right" : "chevron.down")
        Text(section.title)
        Spacer()
      }
      .font(.headline)
      .fontWeight(.bold)
      .contentShape(Rectangle())
      .onTapGesture {
        //          withAnimation(.easeInOut) {
        self.selectDeselect(section)
        //          }
      }
      if isExpanded {
        HStack {
          Keyboard(geoWidth: 40, keyCount: 12, initialKey: .C, startingOctave: 4)
            .padding(.trailing, 5)
            .onTapGesture {
              kbDisplay.toggle()
            }
          Toggle("", isOn: $kbDisplay)
            .labelsHidden()
        }
      }
    }
  }
}

#Preview {
  ChordTypeSectionTitleView(
    section: ChordType.chordTypeSections[5],
    isExpanded: true,
    kbDisplay: Binding.constant(true),
    expandedSections: Binding.constant([])
  )
}
