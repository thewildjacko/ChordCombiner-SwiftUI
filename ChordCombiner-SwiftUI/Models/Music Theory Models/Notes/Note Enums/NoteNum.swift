//
//  NoteEnum.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

protocol GettableNoteNum {
  var noteNum: NoteNum { get }
}

/// enum assigns 0-11 for C-B
enum NoteNum: Int, CaseIterable, CustomStringConvertible, Codable {
  case zero = 0, one, two, three, four, five, six, seven, eight, nine, ten, eleven
    
  var description: String {
    switch self {
    case .zero:
      return "_0"
    case .one:
      return "_1"
    case .two:
      return "_2"
    case .three:
      return "_3"
    case .four:
      return "_4"
    case .five:
      return "_5"
    case .six:
      return "_6"
    case .seven:
      return "_7"
    case .eight:
      return "_8"
    case .nine:
      return "_9"
    case .ten:
      return "_10"
    case .eleven:
      return "_11"
    }
  }
  
  init(_ num: Int) {
    switch num {
    case 0:
      self = .zero
    case 1:
      self = .one
    case 2:
      self = .two
    case 3:
      self = .three
    case 4:
      self = .four
    case 5:
      self = .five
    case 6:
      self = .six
    case 7:
      self = .seven
    case 8:
      self = .eight
    case 9:
      self = .nine
    case 10:
      self = .ten
    case 11:
      self = .eleven
    default:
      self = .zero
    }
  }
  
  func plusDeg(_ deg: NoteNum) -> NoteNum {
    return NoteNum((self.rawValue + deg.rawValue).degreeInOctave)
  }
  
  func minusDeg(_ deg: NoteNum) -> NoteNum {
    return NoteNum((self.rawValue - deg.rawValue).degreeInOctave)
  }
}
