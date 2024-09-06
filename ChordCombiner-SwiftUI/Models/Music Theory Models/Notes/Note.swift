//
//  Note.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/5/24.
//

import Foundation

struct Note: KSwitch {
  let rootNum: NoteNum
  
  var noteNum: NoteNum {
    get {
      return NoteNum(rootNum.basePitchNum.plusDeg(1))
    }
    set { }
  }
  
  var enharm: Enharmonic
  
  var degree: Degree
  
  var rootKey: KeyName {
    ks.root(rootNum: rootNum)
  }
  
  var key: KeyName {
    switch degree {
    case .root:
      ks.root(rootNum: rootNum)
    case .minor9th:
      ks.minor9th(rootNum: rootNum)
    case .major9th:
      ks.major9th(rootNum: rootNum)
    case .sharp9th:
      ks.sharp9th(rootNum: rootNum)
    case .minor3rd:
      ks.minor3rd(rootNum: rootNum)
    case .major3rd:
      ks.major3rd(rootNum: rootNum)
    case .perfect4th:
      ks.perfect4th(rootNum: rootNum)
    case .sharp4th:
      ks.sharp4th(rootNum: rootNum)
    case .dim5th:
      ks.dim5th(rootNum: rootNum)
    case .perfect5th:
      ks.perfect5th(rootNum: rootNum)
    case .sharp5th:
      ks.sharp5th(rootNum: rootNum)
    case .minor6th:
      ks.minor6th(rootNum: rootNum)
    case .major6th:
      ks.major6th(rootNum: rootNum)
    case .dim7th:
      ks.dim7th(rootNum: rootNum)
    case .minor7th:
      ks.minor7th(rootNum: rootNum)
    case .major7th:
      ks.major7th(rootNum: rootNum)
    }
  }
  
  init(rootNum: NoteNum = .zero, enharm: Enharmonic = .flat, degree: Degree) {
    self.rootNum = rootNum
    self.enharm = enharm
    self.degree = degree
  }
  
  init(_ degree: Degree = .root, of root: RootGen = .c) {
    self.enharm = root.keyName.enharm
    self.degree = degree
    self.rootNum = root.keyName.noteNum
  }
  
  init(_ root: RootGen = .c) {
    self.enharm = root.keyName.enharm
    self.rootNum = root.keyName.noteNum
    self.degree = .root
  }

}
