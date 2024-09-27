//
//  AllChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/26/24.
//

import SwiftUI

struct TagsView: View {
  @Binding var selectedSections: Set<ChordTypeSection>
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(ChordType.chordTypeSections, id: \.id) { section in
          Text(section.tagName)
            .padding(10)
            .background(selectedSections.contains(section) ? Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.9) : Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
            .foregroundStyle(selectedSections.contains(section) ? .white : .black)
            .fontWeight(.bold)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .onTapGesture {
              if selectedSections.contains(section) {
                selectedSections.remove(section)
              } else {
                selectedSections.insert(section)
              }
            }
        }
      }
      .font(.caption)
    }
  }
}

struct AllChordsView: View {
  @State var chordTypeSections = ChordType.chordTypeSections
  @State private var selectedSections: Set<ChordTypeSection> = []
  
  var body: some View {
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
    ]
    
    VStack {
      TagsView(selectedSections: $selectedSections)
        .padding()
        .onChange(of: selectedSections) {
          if selectedSections.isEmpty {
            chordTypeSections = ChordType.chordTypeSections
          } else {
            chordTypeSections = Array(selectedSections.sorted(by: { $0.id < $1.id }))
          }
        }
      ScrollView {
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(chordTypeSections, id: \.id) { section in
            Section(header: Text(section.title)) {
              ForEach(section.chordTypes) { type in
                KeyboardDisplayView(chord: Chord(.c, type), color: .yellow)
              }
            }
          }
        }
      }
      .padding()
    }
  }
}

struct KeyboardDisplayView: View {
  var chord: Chord
  @State var keyboard: Keyboard = Keyboard(
    geoWidth: 160,
    initialKey: .C,
    startingOctave: 4,
    octaves: 2)
  var color: Color
  
  
  var body: some View {
    VStack() {
      Text(chord.preciseName)
        .font(.headline)
      //        .font(.title3)
        .fontWeight(.heavy)
        .fixedSize()
        .foregroundStyle(Color("titleColor"))
      keyboard
    }
    .onAppear {
      keyboard.highlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
    }
  }
}

#Preview {
  AllChordsView()
}
