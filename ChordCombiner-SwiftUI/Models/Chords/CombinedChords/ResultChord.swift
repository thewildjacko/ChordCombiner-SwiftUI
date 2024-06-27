//
//  ResultChord.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 5/27/19.
//  Copyright © 2019 Jake Smolowe. All rights reserved.
//

import Foundation

class ResultChord: CustomStringConvertible {
  var baseChord: FourNoteChord {
    didSet {
      if self.baseChord != oldValue {
        convertBothOrUpper(true)
      }
    }
  }
  
  var upStrctTriad: Triad {
    didSet {
      if self.upStrctTriad != oldValue {
        convertBothOrUpper(false)
      }
    }
  }
  
  var type: FNCType
  
  var root: Root {
    if let slashKey = slashRoot {
      return slashKey
    } else {
      return lowerRoot
    }
  }
  
  var slashRoot: Root? {
    return details.chordCategory.slashRoot
  }
  
  var slashChord: Bool = false
  
  var key: KeyName {
    return root.key
  }
  
  var enharm: Enharmonic
  var quality: Suffix {
    return details.chordCategory.chord.quality
  }
  
  var triadRoots: [Root] = []
  var triadQualities: [Suffix.LongUpper] = []
  
  var formulas: [String] {
    var myFormulas = [String]()
    
    let uSTs = upperStructureTriads()
    let locationRoot: Root = slashChord ? slashRoot! : lowerRoot
    
    func getFormulas(triad: Triad, triadRoot: Root, scaleNoteNum: NoteNum) {
      if let location = scale.degNamesByNoteNum.names[scaleNoteNum], let rootName = scale.notesByNoteNum[scaleNoteNum]?.noteName {
        myFormulas.append(triad.locationInChord(rootName: rootName, at: location, of: locationRoot))
      } else {
        myFormulas.append("\(triadRoot.noteName) missing! input those formulaNums!")
      }
    }
    
    var scaleNoteNum: NoteNum
    
    if quality != .tension {
      let slashRootNum: Int = slashChord ? root.num : lowerRoot.num
      var triad: Triad
      
      if uSTs.count > 1 {
        for i in 0...(uSTs.count - 1) {
          triad = uSTs[i]
          scaleNoteNum = NoteNum(triad.root.noteNum.num.minusDeg(slashRootNum))
          getFormulas(triad: triad, triadRoot: triad.root, scaleNoteNum: scaleNoteNum)
        }
      } else {
        triad = uSTs[0]
        scaleNoteNum = NoteNum(triad.root.noteNum.num.minusDeg(slashRootNum))
        getFormulas(triad: triad, triadRoot: triad.root, scaleNoteNum: scaleNoteNum)
      }
    } else {
      scaleNoteNum = NoteNum(upperRoot.noteNum.num.minusDeg(root.noteNum.num))
      getFormulas(triad: upStrctTriad, triadRoot: upperRoot, scaleNoteNum: scaleNoteNum)
    }
    
    return myFormulas
  }
  
  /**
   Returns an array of `Triad`s
   */
  
  func upperStructureTriads() -> [Triad] {
    //        var upStrNotes: [Int] = chord.uprStrNotes
    var upStrNotes: [Int] = uprStrNotes
    if baseChord.type == .ma6 {
      if let index = upStrNotes.firstIndex(of: 9) {
        upStrNotes.remove(at: index)
        if type == .ma7 {
          upStrNotes.append(11)
        } else { // type == .dom7
          upStrNotes.append(10)
        }
      }
    }
    var result: [Triad] = []
    for rootNote in degrees {
      let scaleRootNum: Int = slashChord ? rootNote.minusDeg((slashRoot!.num - lowerRoot.num)) : rootNote
      
      let ustTypes = All_C_Triads.allCases[0...4]
      for triad in ustTypes {
        let triadChord = triad.chord
        let type = triad.chord.type
        let chordNotes = triadChord.translated(by: rootNote).noteNums.map { $0.num }
        let chordNoteSet = Set(chordNotes)
        if degSet.isSuperset(of: chordNoteSet) {
          if upStrNotes.count > 0 {
            if chordNoteSet.isSuperset(of: upStrNotes) {
              if let deg = scale.notesByNoteNum[NoteNum(scaleRootNum)] {
                let root = RootGen(deg.key)
                switch type {
                case .ma, .mi, .aug, .dim:
                  result.append(Triad(root, type))
                case .sus4, .sus2:
                  if !result.contains(where: { $0 == triad.chord }) {
                    result.append(Triad(root, type))
                  }
                  if type == .sus4 {
                    if let sus2deg = scale.notesByNoteNum[NoteNum(scaleRootNum.plusDeg(5))] {
                      let sus2root = RootGen(sus2deg.key)
                      result.append(Triad(sus2root, .sus2))
                    }
                  } else {
                    if let sus4deg = scale.notesByNoteNum[NoteNum(scaleRootNum.minusDeg(5))] {
                      let sus4root = RootGen(sus4deg.key)
                      result.append(Triad(sus4root, .sus4))
                    }
                  }
                }
              }
            }
          } else {
            if let deg = scale.notesByNoteNum[NoteNum(scaleRootNum)] {
              let root = RootGen(deg.key)
              switch type {
              case .ma, .mi, .aug, .dim:
                result.append(Triad(root, type))
              case .sus4, .sus2:
                if !result.contains(where: { $0 == triad.chord }) {
                  result.append(Triad(root, type))
                }
                if type == .sus4 {
                  if let sus2deg = scale.notesByNoteNum[NoteNum(scaleRootNum.plusDeg(5))] {
                    let sus2root = RootGen(sus2deg.key)
                    result.append(Triad(sus2root, .sus2))
                  }
                } else {
                  if let sus4deg = scale.notesByNoteNum[NoteNum(scaleRootNum.minusDeg(5))] {
                    let sus4root = RootGen(sus4deg.key)
                    result.append(Triad(sus4root, .sus4))
                  }
                }
              }
            }
          }
        } else {
          continue
        }
      }
    }
    
    return result.sorted(by: {$1.type.orderNum > $0.type.orderNum})
  }
  
  var uprStrNotes: [Int] {
    if chordCategory.verdict == .tension {
      return upperDegs
    } else {
      var upperStructureDegs: Set<Int> = []
      if !slashChord {
        if let upperExtNum = degSpecs.upperExtNum {
          if suffix != " locrian" {
            upperStructureDegs.insert(upperExtNum)
          }
        }
        upperStructureDegs.formUnion(degSpecs.altSet)
        upperStructureDegs.formUnion(degSpecs.tensionSet)
      } else {
        var nonBaseChordTones = degSet.subtracting(lowConvDegs)
        if let upperExtNum = initialDegSpecs.upperExtNum {
          if (initialDegSpecs.is_mi7 && upperExtNum != slashRoot!.num) || (initialDegSpecs.is_dim && degSet.contains(slashRoot!.num)) {
            nonBaseChordTones.remove(upperExtNum)
          }
        }
        upperStructureDegs = nonBaseChordTones
      }
      return upperStructureDegs.map {$0}.sorted()
    }
  }
  
  var name: String {
    get {
      if quality != .tension {
        //                if let slashKey = chordCategory.slashRoot {
        let chordName = root.noteName + quality.rawValue
        return root == lowerRoot ? chordName : chordName + "/" + lowerRoot.noteName
      } else {
        return scale.name
      }
    }
    set {
      ()
    }
  }
  
  var altName: String? {
    return quality == .tension ? root.noteName + suffix : nil
  }
  
  var lowerRoot: Root {
    return baseChord.root
  }
  
  var upperRoot: Root {
    return upStrctTriad.root
  }
  
  var lowerDegs: [Int] {
    return baseChord.degrees
  }
  
  var upperDegs: [Int] {
    return upStrctTriad.degrees
  }
  
  var lowConvDegs: [Int] {
    return baseChord.convertedDegrees
  }
  
  var upConvDegs: [Int] {
    return upStrctTriad.convertedDegrees
  }
  
  var allDegs: [Int] {
    return lowConvDegs + upConvDegs
  }
  
  var degsUnconvertedSortedFiltered: [Int] {
    return lowerDegs.combineSetFilterSort(upperDegs)
  }
  
  var degreesUnsorted: [Int] {
    return lowConvDegs.combineAndFilter(upConvDegs)
  }
  
  var degrees: [Int] {
    return degreesUnsorted.sorted()
  }
  
  var noteNums: [NoteNum] {
    return allDegs.map { NoteNum($0) }
  }
  
  var degNames: [String] {
    return allNotes.map { $0.degName.short.rawValue }
  }
  
  var allNotes: [Note] {
    if !slashChord {
      return noteNums.compactMap {scale.notesByNoteNum[$0]}
    } else {
      return noteNums.compactMap {
        let num = $0.num.plusDeg(lowerRoot.num)
        let slashNum = slashRoot!.num
        let noteNum = NoteNum(num.minusDeg(slashNum))
        return scale.notesByNoteNum[noteNum]
      }
    }
  }
  
  var slashNotes: [Note] {
    if !slashChord {
      return noteNums.compactMap {scale.notesByNoteNum[$0]}
    } else {
      let displayNoteNums = displayDegs.map { NoteNum($0) }
      return displayNoteNums.compactMap {
        return scale.notesByNoteNum[$0]
      }
    }
  }
  
  var noteNames: [String] {
    return slashNotes.map { $0.noteName }
  }
  
  var degSet: Set<Int> {
    return Set(degrees)
  }
  
  var degSetUnconverted: Set<Int> {
    return lowerDegs.combineSetFilter(upperDegs)
  }
  
  var degreesInKey: [Int] {
    return degrees.map {$0 + root.num}
  }
  
  var displayDegs: [Int] {
    return root == lowerRoot ? degrees : degrees.map { $0.plusDeg(lowerRoot.num - root.num) }
  }
  
  var details: DetailChord {
    get {
      return DetailChord(resultChord: self)
    }
    set {
      ()
    }
  }
  
  var chordCategory: ChordCategory {
    get {
      return details.chordCategory
    }
    set {
      
    }
  }
  
  var chord: ComboChord {
    return chordCategory.chord
  }
  
  var scale: ScaleDetails {
    return chordCategory.scale
  }
  
  var initialDegSpecs: DegSpecs {
    return DegSpecs(rootNum: lowerRoot.num, degSet: degSet, type: baseChord.type)
  }
  
  var degSpecs: DegSpecs {
    get {
      return DegSpecs(rootNum: lowerRoot.num, degSet: Set(displayDegs), type: type)
    }
    set {
      ()
    }
  }
  
  var suffixGen: SuffixGenerator {
    return SuffixGenerator(degSpecs: degSpecs)
  }
  
  var suffix: String {
    return suffixGen.suffix
  }
  
  init(baseChord: FourNoteChord, upStrctTriad: Triad) {
    self.baseChord = baseChord
    self.upStrctTriad = upStrctTriad
    self.type = baseChord.type
    self.enharm = baseChord.enharm
    
    self.baseChord.convertDegsToOwnRoot()
    self.upStrctTriad.convertDegrees(to: lowerRoot.noteNum)
    
  }
  
  func convertBothOrUpper(_ convertBoth: Bool) {
    let lowerRootNum = lowerRoot.noteNum
    if convertBoth {
      baseChord.convertDegsToOwnRoot()
      upStrctTriad.convertDegrees(to: lowerRootNum)
    } else {
      upStrctTriad.convertDegrees(to: lowerRootNum)
    }
  }
  
  func equivalentChord(lhs: ResultChord, rhs: ResultChord) -> Bool {
    return lhs.degsUnconvertedSortedFiltered == rhs.degsUnconvertedSortedFiltered
  }
  
  var description: String {
    return """
        ResultChord:
        \tverdict: \(chordCategory.verdict)
        \ttensionScore: \(degSpecs.tensionScore)
        \tinitial tension score: \(initialDegSpecs.tensionScore)
        \ttension? \(degSpecs.isTension)
        \ttype: \(type)
        \troot: \(root.noteName)
        \tletter: \(key.letter)
        \taccidental: \(key.accidental)
        \tenharmonic: \(root.enharm)
        \tkey: \(key)
        \tquality: \(chord.quality.rawValue)
        \tname: \(name)
        \tsuffix: \(suffix)
        \tscale: \(scale.name)
        \tscale notes: \(scale.noteNames.joined(separator: " "))
        \tdegrees: \(displayDegs)
        \tnotes: \(noteNames.joined(separator: " "))
        """
  }
}

extension ResultChord: Equatable {
  static func == (lhs: ResultChord, rhs: ResultChord) -> Bool {
    return lhs.degsUnconvertedSortedFiltered == rhs.degsUnconvertedSortedFiltered && lhs.name == rhs.name
  }
}
