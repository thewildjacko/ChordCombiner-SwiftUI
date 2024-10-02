//
//  AllChordsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/26/24.
//

import SwiftUI

struct AccidentalsView: View {
  @Binding var selectedAccidental: RootAccidental
  
  var body: some View {
    HStack {
      ForEach(RootAccidental.allCases, id: \.self) { accidental in
        Text(accidental.rawValue)
          .font(.title3)
          .padding(.horizontal, 8)
          .padding(.vertical, 3)
          .background(selectedAccidental == accidental ? Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.9) : Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
          .foregroundStyle(selectedAccidental == accidental ? .white : .black)
          .fontWeight(.bold)
          .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
          .onTapGesture {
            selectedAccidental = accidental
          }
      }
      .font(.caption)
    }
  }
}

struct LettersView: View {
  @Binding var selectedLetter: Letter
  @Binding var selectedAccidental: RootAccidental
  
  var body: some View {
    HStack {
      ForEach(Letter.allCases, id: \.self) { letter in
        Text(letter.rawValue)
          .font(.title3)
          .padding(.horizontal, 9)
          .padding(.vertical, 3)
          .background(selectedLetter == letter ? Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.9) : Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
          .foregroundStyle(selectedLetter == letter ? .white : .black)
          .fontWeight(.bold)
          .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
          .onTapGesture {
            selectedLetter = letter
          }
      }
      .font(.caption)
    }
  }
}


struct TagsView: View {
  @Binding var selectedSections: Set<ChordTypeSection>
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 5) {
        ForEach(ChordType.chordTypeSections, id: \.id) { section in
          Text(section.tagName)
            .font(.headline)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(selectedSections.contains(section) ? Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.9) : Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.9))
            .foregroundStyle(selectedSections.contains(section) ? .white : .black)
            .fontWeight(.bold)
            .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
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
  @State private var selectedLetter: Letter = .c
  @State private var selectedAccidental: RootAccidental = .natural
  @State private var rootKeyNote: RootKeyNote = RootKeyNote(.c, .natural)
  @State private var isExpanded: Set<String> = []
  
  var body: some View {
    let _ = Self._printChanges()
    
    let rows = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible())
    ]
    
    
    
    VStack {
      VStack {
        TagsView(selectedSections: $selectedSections)
          .padding(.horizontal, 10)
          .onAppear(perform: {
            isExpanded = Set([chordTypeSections[0].tagName])
          })
          .onChange(of: selectedSections.count) {
            if selectedSections.isEmpty {
              chordTypeSections = ChordType.chordTypeSections
            } else {
              chordTypeSections = Array(selectedSections.sorted(by: { $0.id < $1.id }))
            }
            //            isExpanded = Set([chordTypeSections[0].tagName])
          }
        Divider()
          .overlay {
            Color.title
          }
        HStack(alignment: .bottom) {
          LettersView(selectedLetter: $selectedLetter, selectedAccidental: $selectedAccidental)
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
      }
      Divider()
        .overlay {
          Color.title
        }
      ScrollViewReader { proxy in
        List {
          ForEach(chordTypeSections, id: \.tagName) { section in
            Section(
              isExpanded: Binding<Bool> (
                get: {
                  return isExpanded.contains(section.tagName)
                },
                set: { isExpanding in
                  if isExpanding {
                    isExpanded.insert(section.tagName)
                  } else {
                    isExpanded.remove(section.tagName)
                  }
                }
              )
            ) {
              ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 15) {
                  ForEach(section.chordTypes) { type in
                    KeyboardDisplayView(
                      chord: Chord(rootKeyNote, type),
                      keyboard: Keyboard(
                        geoWidth: 250,
                        initialKey: .C,
                        startingOctave: 4,
                        octaves: 3),
                      color: .yellow
                    )
                  }
                }
              }
              .padding(.vertical, 8)
            } header: {
              Text(section.title)
                .font(.title2)
                .fontWeight(.bold)
                .headerProminence(.increased)
            }
          }
        }
        .listStyle(.sidebar)
        .listRowBackground(Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1))
        .background {
          Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1)
        }
        .listStyle(SidebarListStyle())
      }
    }
    .padding(.bottom, 20)
    .background {
      Color(red: 0, green: 0.8, blue: 0.8, opacity: 0.1)
    }
  }
}

struct KeyboardDisplayView: View {
  var chord: Chord
  @State var keyboard: Keyboard
  var color: Color
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(chord.preciseName)
      //        .font(.headline)
        .font(.title2)
        .fontWeight(.heavy)
        .fixedSize()
        .foregroundStyle(Color("titleColor"))
      keyboard
    }
    .onAppear {
      keyboard.highlightKeysSingle(degs: chord.voicingCalculator.stackedPitches, color: color)
    }
    .onChange(of: chord) { oldValue, newValue in
      keyboard.toggleHighlightKeysSingle(degs: oldValue.voicingCalculator.stackedPitches, color: color)
      keyboard.toggleHighlightKeysSingle(degs: newValue.voicingCalculator.stackedPitches, color: color)
    }
  }
}

#Preview {
  AllChordsView()
}
