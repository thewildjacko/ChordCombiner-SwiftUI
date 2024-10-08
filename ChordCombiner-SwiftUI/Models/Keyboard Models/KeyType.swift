//
//  KeyType.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import Foundation

enum KeyType: Int {
  case C = 0, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B
  
  var initialKeyPosition: CGFloat {
    switch self {
    case .C, .E, .G, .A:
      return 11.5
    case .D, .F, .B:
      return 12
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return 7
    }
  }
  
  var nextKeyPosition: CGFloat {
    switch self {
    case .C:
      return 9.5
    case .Db:
      return 13.5
    case .D:
      return 14.5
    case .Eb:
      return 9.5
    case .E:
      return 23
    case .F:
      return 9.5
    case .Gb:
      return 14.5
    case .G:
      return 11.5
    case .Ab:
      return 11.5
    case .A:
      return 15.5
    case .Bb:
      return 7.5
    case .B:
      return 24
    }
  }
  
  var nextKey: KeyType {
    switch self {
    case .C:
      return .Db
    case .Db:
      return .D
    case .D:
      return .Eb
    case .Eb:
      return .E
    case .E:
      return .F
    case .F:
      return .Gb
    case .Gb:
      return .G
    case .G:
      return .Ab
    case .Ab:
      return .A
    case .A:
      return .Bb
    case .Bb:
      return .B
    case .B:
      return .C
    }
  }
  
  var keyShapePath: KeyShapePath {
    switch self {
    case .C:
      return .CShape
    case .D:
      return .DShape
    case .E:
      return .EShape
    case .F:
      return .FShape
    case .G:
      return .GShape
    case .A:
      return .AShape
    case .B:
      return .BShape
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return .BlackandEdgeWhiteKeyShape
    }
  }
  
  func toPitch(startingOctave: Int) -> Int { noteNum.rawValue + (startingOctave + 1) * 12 }
}

extension KeyType: GettableNoteNum {
  var noteNum: NoteNum {
    switch self {
    case .C:
      return .zero
    case .Db:
      return .one
    case .D:
      return .two
    case .Eb:
      return .three
    case .E:
      return .four
    case .F:
      return .five
    case .Gb:
      return .six
    case .G:
      return .seven
    case .Ab:
      return .eight
    case .A:
      return .nine
    case .Bb:
      return .ten
    case .B:
      return .eleven
    }
  }
  
  init(noteNum: NoteNum) {
    switch noteNum {
    case .zero:
      self = .C
    case .one:
      self = .Db
    case .two:
      self = .D
    case .three:
      self = .Eb
    case .four:
      self = .E
    case .five:
      self = .F
    case .six:
      self = .Gb
    case .seven:
      self = .G
    case .eight:
      self = .Ab
    case .nine:
      self = .A
    case .ten:
      self = .Bb
    case .eleven:
      self = .B
    }
  }
}

