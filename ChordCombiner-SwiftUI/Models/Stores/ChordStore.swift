//
//  ChordStore.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/21/24.
//

import Foundation

class ChordStore: ObservableObject {
  @Published var chordData = ChordData(
    lowerChord: FourNoteChord(
      RootGen(
        .c,
        .natural
      ),
      .dom7,
      inversion: .root
    ), triad: Triad(
      RootGen(
        .d,
        .natural
      ),
      .ma,
      inversion: .root
    )
  ) {
    didSet {
      saveChordsJSON()
    }
  }
  
  let chordsJSONURL = URL(fileURLWithPath: "chords", relativeTo: FileManager.documentsDirectoryURL)
    .appendingPathExtension("json")
    
  init() {
    chordData = loadChordsJSON()
  }
  
  func loadChordsJSON() -> ChordData {
    print(FileManager.documentsDirectoryURL)
    
    guard Bundle.main.url(forResource: "chords", withExtension: "json") != nil else {
      
      let decoder = JSONDecoder()
      
      do {
        let data = try Data(contentsOf: chordsJSONURL)
        chordData = try decoder.decode(ChordData.self, from: data)
        
      } catch let error {
        print("decoding error!")
        print(error)
        
        return chordData
      }
      
      return chordData
    }
    return chordData
  }
  
  private func saveChordsJSON() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    do {
      let data = try encoder.encode(chordData)
      try data.write(to: chordsJSONURL, options: .atomicWrite)
//      print("triad is:\n\n\(triad.description)")
    } catch let error {
      print("encoding error")
      print(error)
    }
  }
}

extension ChordStore: Equatable {
  static func == (lhs: ChordStore, rhs: ChordStore) -> Bool {
    return lhs.chordData.triad == rhs.chordData.triad && lhs.chordData.lowerChord == rhs.chordData.lowerChord
  }
}

