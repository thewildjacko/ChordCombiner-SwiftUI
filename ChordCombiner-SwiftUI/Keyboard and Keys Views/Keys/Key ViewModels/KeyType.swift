//
//  KeyType.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

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
    case .C, .Eb:
      return 9.5
    case .Db, .D:
      return 14
    case .E, .B:
      return 23.5
    case .F, .Bb:
      return 9
    case .Gb, .A:
      return 14.5
    case .G, .Ab:
      return 11.5
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
  
  var keyShapePath: KeyShapePathType {
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
      return .blackAndEdgeWhiteKeyShape
    }
  }
  
  var isBlackKey: Bool {
    switch self {
    case .C, .D, .E, .F, .G, .A, .B:
      return false
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return true
    }
  }
  
  var defaultFillColor: Color { self.isBlackKey ? .black : .white }
  
  func toPitch(startingOctave: Int) -> Int { noteNumber.rawValue + (startingOctave + 1) * 12 }
}

extension KeyType: GettableNoteNumber {
  var noteNumber: NoteNumber {
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
  
  init(noteNumber: NoteNumber) {
    switch noteNumber {
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

