//
//  KeyType.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/5/24.
//

import SwiftUI

enum KeyType: Int {
  // swiftlint:disable:next identifier_name
  case c = 0, dB, d, eB, e, f, gB, g, aB, a, bB, b

  var initialKeyPosition: CGFloat {
    switch self {
    case .c, .e, .g, .a:
      return 11.5
    case .d, .f, .b:
      return 12
    case .dB, .eB, .gB, .aB, .bB:
      return 7
    }
  }

  var nextKeyPosition: CGFloat {
//    switch self {
//    case .c:
//      return 9.5
//    case .dB:
//      return 14
//    case .d:
//      return 14
//    case .eB:
//      return 9.5
//    case .e:
//      return 23.5
//    case .f:
//      return 19
//    case .gB:
//      return 14.5
//    case .g:
//      return 11.5
//    case .aB:
//      return 11.5
//    case .a:
//      return 14.5
//    case .bB:
//      return 9
//    case .b:
//      return 23.5
//    }

    switch self {
    case .c, .eB:
      return 9.5
    case .dB:
      return 14
    case .d:
      return 14
    case .e, .b:
      return 23.5
    case .f, .bB:
      return 9
    case .gB, .a:
      return 14.5
    case .g, .aB:
      return 11.5
    }
  }

  var nextKey: KeyType {
    switch self {
    case .c:
      return .dB
    case .dB:
      return .d
    case .d:
      return .eB
    case .eB:
      return .e
    case .e:
      return .f
    case .f:
      return .gB
    case .gB:
      return .g
    case .g:
      return .aB
    case .aB:
      return .a
    case .a:
      return .bB
    case .bB:
      return .b
    case .b:
      return .c
    }
  }

  var keyShapePath: KeyShapePathType {
    switch self {
    case .c:
      return .CShape
    case .d:
      return .DShape
    case .e:
      return .EShape
    case .f:
      return .FShape
    case .g:
      return .GShape
    case .a:
      return .AShape
    case .b:
      return .BShape
    case .dB, .eB, .gB, .aB, .bB:
      return .blackAndEdgeWhiteKeyShape
    }
  }

  var isBlackKey: Bool {
    switch self {
    case .c, .d, .e, .f, .g, .a, .b:
      return false
    case .dB, .eB, .gB, .aB, .bB:
      return true
    }
  }

  var defaultFillColor: Color { self.isBlackKey ? .black : .white }

  var baseRadius: CGFloat {
    switch self {
    case .c, .d, .e, .f, .g, .a, .b:
      return KeyRadius.whiteKey.rawValue
    case .dB, .eB, .gB, .aB, .bB:
      return KeyRadius.blackKey.rawValue
    }
  }

  var baseWidth: CGFloat {
    switch self {
    case .c, .e, .g, .a:
      return KeyWidth.whiteKeyCEGA.rawValue
    case .d, .f, .b:
      return KeyWidth.whiteKeyDFB.rawValue
    case .dB, .eB, .gB, .aB, .bB:
      return KeyWidth.blackKey.rawValue
    }
  }

  var baseHeight: CGFloat {
    switch self {
    case .c, .d, .e, .f, .g, .a, .b:
      return KeyHeight.whiteKey.rawValue
    case .dB, .eB, .gB, .aB, .bB:
      return KeyHeight.blackKey.rawValue
    }
  }

  var fill: Color {
    switch self {
    case .c, .d, .e, .f, .g, .a, .b:
      return .white
    case .dB, .eB, .gB, .aB, .bB:
      return .black
    }
  }

  var zIndex: Double {
    switch self {
    case .c, .d, .e, .f, .g, .a, .b:
      return 0
    case .dB, .eB, .gB, .aB, .bB:
      return 1.0
    }
  }

  func toPitch(startingOctave: Int) -> Int { noteNumber.rawValue + (startingOctave + 1) * 12 }
}

extension KeyType: GettableNoteNumber {
  var noteNumber: NoteNumber {
    switch self {
    case .c:
      return .zero
    case .dB:
      return .one
    case .d:
      return .two
    case .eB:
      return .three
    case .e:
      return .four
    case .f:
      return .five
    case .gB:
      return .six
    case .g:
      return .seven
    case .aB:
      return .eight
    case .a:
      return .nine
    case .bB:
      return .ten
    case .b:
      return .eleven
    }
  }

  init(noteNumber: NoteNumber) {
    let keyTypeMap: [NoteNumber: KeyType] = [
      .zero: .c,
      .one: .dB,
      .two: .d,
      .three: .eB,
      .four: .e,
      .five: .f,
      .six: .gB,
      .seven: .g,
      .eight: .aB,
      .nine: .a,
      .ten: .bB,
      .eleven: .b
    ]

    self = keyTypeMap[noteNumber] ?? .c
  }
}
