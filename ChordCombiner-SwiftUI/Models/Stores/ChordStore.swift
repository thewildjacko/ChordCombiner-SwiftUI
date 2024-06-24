//
//  ChordStore.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/21/24.
//

import Foundation

class ChordStore: ObservableObject {
  @Published var chordData = ChordData(
    lowerChordData: LowerChordData(letter: .c, accidental: .natural, type: .dom7, inversion: .root),
    ustData: USTData(letter: .d, accidental: .natural, type: .ma, inversion: .root)
  ) {
    didSet {
      saveChordsJSON()
    }
  }
  
  @Published var triad: Triad = Triad() {
    didSet {
      saveChordsJSON()
    }
  }
    
  @Published var lowerChord: FourNoteChord = FourNoteChord() {
    didSet {
      saveChordsJSON()
    }
  }
  
  let chordsJSONURL = URL(fileURLWithPath: "chords", relativeTo: FileManager.documentsDirectoryURL)
    .appendingPathExtension("json")
    
  init() {
    chordData = loadChordsJSON()
    
    triad = Triad(
      RootGen(
        self.chordData.ustData.letter,
        self.chordData.ustData.accidental
      ),
      self.chordData.ustData.type,
      inversion: self.chordData.ustData.inversion
    )
    
    lowerChord = FourNoteChord(
      RootGen(
        self.chordData.lowerChordData.letter,
        self.chordData.lowerChordData.accidental
      ),
      self.chordData.lowerChordData.type,
      inversion: self.chordData.lowerChordData.inversion
    )
  }
  
  func loadChordsJSON() -> ChordData {
//    print(FileManager.documentsDirectoryURL)
    
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
    return lhs.chordData.ustData == rhs.chordData.ustData && lhs.chordData.lowerChordData == rhs.chordData.lowerChordData
  }
}

