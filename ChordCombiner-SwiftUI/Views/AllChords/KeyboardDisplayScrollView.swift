//
//  KeyboardDisplayScrollView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/2/24.
//

import SwiftUI

struct KeyboardDisplayScrollView: View {
  let section: ChordTypeSection
  @Binding var rootKeyNote: RootKeyNote
  let isExpanded: Bool
  @Binding var expandedSections: Set<String>
  @State var kbDisplay: Bool = false
  
  let rows = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    content
  }
  
  func selectDeselect(_ section: ChordTypeSection) {
    if expandedSections.contains(section.tagName) {
      expandedSections.remove(section.tagName)
    } else {
      expandedSections.insert(section.tagName)
    }
  }
  
  private var content: some View {
    VStack(alignment: .leading) {
      HStack {
        HStack {
          if !isExpanded {
            Image(systemName: "chevron.right")
          } else {
            Image(systemName: "chevron.down")
          }
          Text(section.title)
          Spacer()
        }
        .font(.headline)
        .fontWeight(.bold)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation(.easeInOut) {
            self.selectDeselect(section)
          }
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
      
      if isExpanded {
        ScrollView(.horizontal) {
          LazyHGrid(rows: rows, spacing: 20) {
            ForEach(section.chordTypes) { type in
              let chord = Chord(rootKeyNote, type)
              
              if kbDisplay {
                KeyboardDisplayView(
                  chord: chord,
                  keyboard: Keyboard(
                    geoWidth: 250,
                    initialKey: .C,
                    startingOctave: 4,
                    octaves: 3),
                  color: .yellow
                )
              } else {
                Text(chord.preciseName)
                  .font(.title2)
                  .padding(.horizontal, 8)
                  .padding(.vertical, 5)
                  .background(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
                  .foregroundStyle(.title)
                  .fontWeight(.bold)
                  .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
              }
            }
          }
        }
        .frame(maxHeight: .infinity)
      }
    }
    .padding(8)
  }
}

#Preview {
  KeyboardDisplayScrollView(section: ChordType.chordTypeSections[5],
                            rootKeyNote: Binding.constant(.c),
                            isExpanded: true,
                            expandedSections: Binding.constant([]))
  .padding()
}
