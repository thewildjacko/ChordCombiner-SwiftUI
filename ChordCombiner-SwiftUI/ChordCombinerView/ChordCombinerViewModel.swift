//
//  ChordCombinerViewModel.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/21/24.
//

import SwiftUI
import Observation
import OSLog

@Observable
class ChordCombinerViewModel: ObservableObject {
  // MARK: Shared static singleton
  private static var shared: ChordCombinerViewModel?

  var initial: Bool = true

  // MARK: Instance properties
  var chordPropertyData = ChordPropertyData(
    lowerChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil),
    upperChordProperties: ChordProperties(letter: nil, accidental: nil, chordType: nil)
  ) {
    didSet {
      saveChordsJSON()
    }
  }

  let chordsJSONURL = URL(fileURLWithPath: "chords", relativeTo: FileManager.documentsDirectoryURL)
    .appendingPathExtension("json")

  var lowerKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard
  var upperKeyboard: Keyboard = Keyboard.initialSingleChordKeyboard
  var combinedKeyboard: Keyboard = Keyboard.initialDualChordKeyboard

  var lowerChord: Chord? {
    guard let letter = chordPropertyData.lowerChordProperties.letter,
          let accidental = chordPropertyData.lowerChordProperties.accidental,
          let chordType = chordPropertyData.lowerChordProperties.chordType else {
      return nil
    }

    return Chord(RootKeyNote(letter, accidental), chordType)
  }

  var upperChord: Chord? {
    guard let letter = chordPropertyData.upperChordProperties.letter,
          let accidental = chordPropertyData.upperChordProperties.accidental,
          let chordType = chordPropertyData.upperChordProperties.chordType else {
      return nil
    }

    return Chord(RootKeyNote(letter, accidental), chordType)
  }

  var resultChord: Chord? {
    guard let lowerChord = lowerChord, let upperChord = upperChord else {
      return nil
    }

    return ChordCombiner.combineChords(firstChord: lowerChord, secondChord: upperChord)
  }

  var chordCombinerVoicingCalculator: ChordCombinerVoicingCalculator? {
    guard let lowerChord = lowerChord,
          let upperChord = upperChord else {
      return nil
    }

    return ChordCombinerVoicingCalculator(
      lowerChordVoicingCalculator: lowerChord.voicingCalculator,
      upperChordVoicingCalculator: upperChord.voicingCalculator,
      resultChordVoicingCalculator: resultChord?.voicingCalculator ?? nil)
  }

  // MARK: Initializer
  private init(
    lowerChordProperties: ChordProperties = ChordProperties(
      letter: nil,
      accidental: .natural,
      chordType: nil),
    upperChordProperties: ChordProperties = ChordProperties(
      letter: nil,
      accidental: .natural,
      chordType: nil),
    lowerKeyboard: Keyboard = Keyboard(
      width: 351,
      initialKeyType: .c,
      startingOctave: 4,
      octaves: 2,
      letterPadding: true),
    upperKeyboard: Keyboard = Keyboard(
      width: 351,
      initialKeyType: .c,
      startingOctave: 4,
      octaves: 2,
      letterPadding: true),
    combinedKeyboard: Keyboard = Keyboard(
      width: 351,
      initialKeyType: .c,
      startingOctave: 4,
      octaves: 3,
      letterPadding: true)
  ) {
    chordPropertyData = loadChordsJSON()

    self.lowerKeyboard = lowerKeyboard
    self.upperKeyboard = upperKeyboard
    self.combinedKeyboard = combinedKeyboard
  }

  // MARK: Singleton function
  public class func singleton() -> ChordCombinerViewModel {
    if shared == nil {
      shared = ChordCombinerViewModel()
    }
    return shared!
  }

  func loadChordsJSON() -> ChordPropertyData {

    guard Bundle.main.url(forResource: "chords", withExtension: "json") != nil else {

      let decoder = JSONDecoder()

      do {
        let data = try Data(contentsOf: chordsJSONURL)
        chordPropertyData = try decoder.decode(ChordPropertyData.self, from: data)

      } catch let error {
        Logger.main.error("Decoding error! Couldn't load ChordPropertyData; setting to defaults.")
        Logger.main.error("\(error)")

        return ChordPropertyData(
          lowerChordProperties: ChordProperties(
            letter: nil,
            accidental: .natural,
            chordType: nil),
          upperChordProperties: ChordProperties(
            letter: nil,
            accidental: .natural,
            chordType: nil))
      }
      return chordPropertyData
    }
    return chordPropertyData
  }

  private func saveChordsJSON() {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
      let data = try encoder.encode(chordPropertyData)
      try data.write(to: chordsJSONURL, options: .atomicWrite)
    } catch let error {
      Logger.main.error("Encoding error!")
      Logger.main.error("\(error)")
    }
  }
}
