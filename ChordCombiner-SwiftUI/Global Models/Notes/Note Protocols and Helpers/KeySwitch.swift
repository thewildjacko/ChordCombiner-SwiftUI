//
//  KeySwitch.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// selects flat or sharp version of KeyName based on enharmonic
struct KeySwitcher: Enharmonic, Codable {
  var enharmonic: EnharmonicSymbol

  static let flat = KeySwitcher(enharmonic: .flat)
  static let sharp = KeySwitcher(enharmonic: .sharp)
}

// MARK: pickKey functions
extension KeySwitcher {
  func pickKey(_ flatKey: KeyName, _ sharpKey: KeyName) -> KeyName {
    return enharmonic == .flat ? flatKey : sharpKey
  }

  // pickKey(.c, .bSh) 8
  // pickKey(.dB, .cSh) 9
  // (.eBB, .d) 6
  // .d 3
  // .eB 3
  // pickKey(.eB, .dSh) 9
  // pickKey(.fB, .e) 7
  // pickKey(.f, .eSh) 8
  // pickKey(.gBB, .f) 3
  // pickKey(.gB, .fSh) 9
  // .g 3
  // pickKey(.aBB, .g) 5
  // : .aB 3
  // pickKey(.aB, .gSh) 9
  // .a 3
  // .bB 3
  // pickKey(.bBB, .a) 7
  // pickKey(.bB, .aSh) 9
  // pickKey(.cB, .b) 8
  // pickKey(.dBB, .c) 4

  func root(rootNumber: NoteNumber) -> KeyName {
    let keyMap: [NoteNumber: KeyName] = [
      .zero: pickKey(.c, .bSh),
      .one: pickKey(.dB, .cSh),
      .two: .d,
      .three: pickKey(.eB, .dSh),
      .four: pickKey(.fB, .e),
      .five: pickKey(.f, .eSh),
      .six: pickKey(.gB, .fSh),
      .seven: .g,
      .eight: pickKey(.aB, .gSh),
      .nine: .a,
      .ten: pickKey(.bB, .aSh),
      .eleven: pickKey(.cB, .b)
    ]

    return keyMap[rootNumber] ?? .c
  }

  func minor9th(rootNumber: NoteNumber) -> KeyName {
    let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.dB, .cSh),
       .one: pickKey(.eBB, .d),
       .two: .eB,
       .three: pickKey(.fB, .e),
       .four: pickKey(.gBB, .f),
       .five: pickKey(.gB, .fSh),
       .six: pickKey(.aBB, .g),
       .seven: .aB,
       .eight: pickKey(.bBB, .a),
       .nine: .bB,
       .ten: pickKey(.cB, .b),
       .eleven: pickKey(.dBB, .c)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func major9th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.d, .cX),
       .one: pickKey(.eB, .dSh),
       .two: .e,
       .three: pickKey(.f, .eSh),
       .four: pickKey(.gB, .fSh),
       .five: pickKey(.g, .fX),
       .six: pickKey(.aB, .gSh),
       .seven: .a,
       .eight: pickKey(.bB, .aSh),
       .nine: .b,
       .ten: pickKey(.c, .bSh),
       .eleven: pickKey(.dB, .cSh)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func sharp9th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: .dSh,
       .one: pickKey(.e, .dX),
       .two: .eSh,
       .three: pickKey(.fSh, .eX),
       .four: pickKey(.g, .fX),
       .five: .gSh,
       .six: pickKey(.a, .gX),
       .seven: .aSh,
       .eight: pickKey(.b, .aX),
       .nine: .bSh,
       .ten: pickKey(.cSh, .bX),
       .eleven: pickKey(.d, .cX)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func minor3rd(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.eB, .dSh),
       .one: pickKey(.fB, .e),
       .two: .f,
       .three: pickKey(.gB, .fSh),
       .four: pickKey(.aBB, .g),
       .five: pickKey(.aB, .gSh),
       .six: pickKey(.bBB, .a),
       .seven: .bB,
       .eight: pickKey(.cB, .b),
       .nine: .c,
       .ten: pickKey(.dB, .cSh),
       .eleven: pickKey(.eBB, .d)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func major3rd(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.e, .dX),
       .one: pickKey(.f, .eSh),
       .two: .fSh,
       .three: pickKey(.g, .fX),
       .four: pickKey(.aB, .gSh),
       .five: pickKey(.a, .gX),
       .six: pickKey(.bB, .aSh),
       .seven: .b,
       .eight: pickKey(.c, .bSh),
       .nine: .cSh,
       .ten: pickKey(.d, .cX),
       .eleven: pickKey(.eB, .dSh)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func perfect4th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.f, .eSh),
       .one: pickKey(.gB, .fSh),
       .two: .g,
       .three: pickKey(.aB, .gSh),
       .four: pickKey(.bBB, .a),
       .five: pickKey(.bB, .aSh),
       .six: pickKey(.cB, .b),
       .seven: .c,
       .eight: pickKey(.dB, .cSh),
       .nine: .d,
       .ten: pickKey(.eB, .dSh),
       .eleven: pickKey(.fB, .e)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func sharp4th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.fSh, .eX),
       .one: pickKey(.g, .fX),
       .two: .gSh,
       .three: pickKey(.a, .gX),
       .four: pickKey(.bB, .aSh),
       .five: pickKey(.b, .aX),
       .six: pickKey(.c, .bSh),
       .seven: .cSh,
       .eight: pickKey(.d, .cX),
       .nine: .dSh,
       .ten: pickKey(.e, .dX),
       .eleven: pickKey(.f, .eSh)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func dim5th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.gB, .fSh),
       .one: pickKey(.aBB, .g),
       .two: .aB,
       .three: pickKey(.bBB, .a),
       .four: pickKey(.cBB, .bB),
       .five: pickKey(.cB, .b),
       .six: pickKey(.dBB, .c),
       .seven: .dB,
       .eight: pickKey(.eBB, .d),
       .nine: .eB,
       .ten: pickKey(.fB, .e),
       .eleven: pickKey(.gBB, .f)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func perfect5th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.g, .fX),
       .one: pickKey(.aB, .gSh),
       .two: .a,
       .three: pickKey(.bB, .aSh),
       .four: pickKey(.cB, .b),
       .five: pickKey(.c, .bSh),
       .six: pickKey(.dB, .cSh),
       .seven: .d,
       .eight: pickKey(.eB, .dSh),
       .nine: .e,
       .ten: pickKey(.f, .eSh),
       .eleven: pickKey(.gB, .fSh)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func sharp5th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: .gSh,
       .one: pickKey(.a, .gX),
       .two: .aSh,
       .three: pickKey(.b, .aX),
       .four: pickKey(.c, .bSh),
       .five: pickKey(.cSh, .bX),
       .six: pickKey(.d, .cX),
       .seven: .dSh,
       .eight: pickKey(.e, .dX),
       .nine: .eSh,
       .ten: pickKey(.fSh, .eX),
       .eleven: pickKey(.g, .fX)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func minor6th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.aB, .gSh),
       .one: pickKey(.bBB, .a),
       .two: .bB,
       .three: pickKey(.cB, .b),
       .four: pickKey(.dBB, .c),
       .five: pickKey(.dB, .cSh),
       .six: pickKey(.eBB, .d),
       .seven: .eB,
       .eight: pickKey(.fB, .e),
       .nine: .f,
       .ten: pickKey(.gB, .fSh),
       .eleven: pickKey(.aBB, .g)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func major6th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.a, .gX),
       .one: pickKey(.bB, .aSh),
       .two: .b,
       .three: pickKey(.c, .bSh),
       .four: pickKey(.dB, .cSh),
       .five: pickKey(.d, .cX),
       .six: pickKey(.eB, .dSh),
       .seven: .e,
       .eight: pickKey(.f, .eSh),
       .nine: .fSh,
       .ten: pickKey(.g, .fX),
       .eleven: pickKey(.aB, .gSh)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func dim7th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.bBB, .a),
       .one: pickKey(.cBB, .bB),
       .two: .cB,
       .three: pickKey(.dBB, .c),
       .four: .dB,
       .five: pickKey(.eBB, .d),
       .six: pickKey(.fBB, .eB),
       .seven: .fB,
       .eight: pickKey(.gBB, .f),
       .nine: .gB,
       .ten: pickKey(.aBB, .g),
       .eleven: .aB
       ]

       return keyMap[rootNumber] ?? .c
     }

     func minor7th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.bB, .aSh),
       .one: pickKey(.cB, .b),
       .two: .c,
       .three: pickKey(.dB, .cSh),
       .four: pickKey(.eBB, .d),
       .five: pickKey(.eB, .dSh),
       .six: pickKey(.fB, .e),
       .seven: .f,
       .eight: pickKey(.gB, .fSh),
       .nine: .g,
       .ten: pickKey(.aB, .gSh),
       .eleven: pickKey(.bBB, .a)
       ]

       return keyMap[rootNumber] ?? .c
     }

     func major7th(rootNumber: NoteNumber) -> KeyName {
       let keyMap: [NoteNumber: KeyName] = [
       .zero: pickKey(.b, .aX),
       .one: pickKey(.c, .bSh),
       .two: .cSh,
       .three: pickKey(.d, .cX),
       .four: pickKey(.eB, .dSh),
       .five: pickKey(.e, .dX),
       .six: pickKey(.f, .eSh),
       .seven: .fSh,
       .eight: pickKey(.g, .fX),
       .nine: .gSh,
       .ten: pickKey(.a, .gX),
       .eleven: pickKey(.bB, .aSh)
       ]

       return keyMap[rootNumber] ?? .c
     }
}

/// a protocol to allow notes to adopt `EnharmonicSymbol` and `KeySwitch` variables
protocol KeySwitch: Enharmonic {
  var keySwitcher: KeySwitcher { get }
}
