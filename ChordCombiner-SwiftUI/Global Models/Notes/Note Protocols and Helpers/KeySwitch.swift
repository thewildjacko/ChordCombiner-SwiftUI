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
  
  func pickKey(_ flatKey: KeyName, _ sharpKey: KeyName, _ blackKeyFlats: KeyName, _ blackKeySharps: KeyName) -> KeyName {
    switch enharmonic {
    case .flat:
      return flatKey
    case .sharp:
      return sharpKey
    case .blackKeyFlats:
      return blackKeyFlats
    case .blackKeySharps:
      return blackKeySharps
    }
  }
  
  func root(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.c, .bSh, .c, .c)
    case .one:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .two:
      return .d
    case .three:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .four:
      return pickKey(.fB, .e, .e, .e)
    case .five:
      return pickKey(.f, .eSh, .f, .f)
    case .six:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .seven:
      return .g
    case .eight:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .nine:
      return .a
    case .ten:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .eleven:
      return pickKey(.cB, .b, .b, .b)
    }
  }
  
  func minor9th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .one:
      return pickKey(.e_bb, .d, .d, .d)
    case .two:
      return .eB
    case .three:
      return pickKey(.fB, .e, .e, .e)
    case .four:
      return pickKey(.g_bb, .f, .f, .f)
    case .five:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .six:
      return pickKey(.a_bb, .g, .g, .g)
    case .seven:
      return .aB
    case .eight:
      return pickKey(.b_bb, .a, .a, .a)
    case .nine:
      return .bB
    case .ten:
      return pickKey(.cB, .b, .b, .b)
    case .eleven:
      return pickKey(.d_bb, .c, .c, .c)
    }
  }
  
  func major9th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.d, .cX, .d, .d)
    case .one:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .two:
      return .e
    case .three:
      return pickKey(.f, .eSh, .f, .f)
    case .four:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .five:
      return pickKey(.g, .fX, .g, .g)
    case .six:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .seven:
      return .a
    case .eight:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .nine:
      return .b
    case .ten:
      return pickKey(.c, .bSh, .c, .c)
    case .eleven:
      return pickKey(.dB, .cSh, .dB, .cSh)
    }
  }
  
  func sharp9th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return .dSh
    case .one:
      return pickKey(.e, .dX, .e, .e)
    case .two:
      return .eSh
    case .three:
      return pickKey(.fSh, .eX, .fSh, .eX)
    case .four:
      return pickKey(.g, .fX, .g, .g)
    case .five:
      return .gSh
    case .six:
      return pickKey(.a, .gX, .a, .a)
    case .seven:
      return .aSh
    case .eight:
      return pickKey(.b, .aX, .b, .b)
    case .nine:
      return .bSh
    case .ten:
      return pickKey(.cSh, .bX, .cSh, .bX)
    case .eleven:
      return pickKey(.d, .cX, .d, .d)
    }
  }
  
  func minor3rd(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .one:
      return pickKey(.fB, .e, .e, .e)
    case .two:
      return .f
    case .three:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .four:
      return pickKey(.a_bb, .g, .g, .g)
    case .five:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .six:
      return pickKey(.b_bb, .a, .a, .a)
    case .seven:
      return .bB
    case .eight:
      return pickKey(.cB, .b, .b, .b)
    case .nine:
      return .c
    case .ten:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .eleven:
      return pickKey(.e_bb, .d, .d, .d)
    }
  }
  
  func major3rd(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.e, .dX, .e, .e)
    case .one:
      return pickKey(.f, .eSh, .f, .f)
    case .two:
      return .fSh
    case .three:
      return pickKey(.g, .fX, .g, .g)
    case .four:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .five:
      return pickKey(.a, .gX, .a, .a)
    case .six:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .seven:
      return .b
    case .eight:
      return pickKey(.c, .bSh, .c, .c)
    case .nine:
      return .cSh
    case .ten:
      return pickKey(.d, .cX, .d, .d)
    case .eleven:
      return pickKey(.eB, .dSh, .eB, .dSh)
    }
  }
  
  func perfect4th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.f, .eSh, .f, .f)
    case .one:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .two:
      return .g
    case .three:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .four:
      return pickKey(.b_bb, .a, .a, .a)
    case .five:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .six:
      return pickKey(.cB, .b, .b, .b)
    case .seven:
      return .c
    case .eight:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .nine:
      return .d
    case .ten:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .eleven:
      return pickKey(.fB, .e, .e, .e)
    }
  }
  
  func sharp4th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.fSh, .eX, .fSh, .eX)
    case .one:
      return pickKey(.g, .fX, .g, .g)
    case .two:
      return .gSh
    case .three:
      return pickKey(.a, .gX, .a, .a)
    case .four:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .five:
      return pickKey(.b, .aX, .b, .b)
    case .six:
      return pickKey(.c, .bSh, .c, .c)
    case .seven:
      return .cSh
    case .eight:
      return pickKey(.d, .cX, .d, .d)
    case .nine:
      return .dSh
    case .ten:
      return pickKey(.e, .dX, .e, .e)
    case .eleven:
      return pickKey(.f, .eSh, .f, .f)
    }
  }
  
  func dim5th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .one:
      return pickKey(.a_bb, .g, .g, .g)
    case .two:
      return .aB
    case .three:
      return pickKey(.b_bb, .a, .a, .a)
    case .four:
      return pickKey(.c_bb, .bB, .c_bb, .bB)
    case .five:
      return pickKey(.cB, .b, .b, .b)
    case .six:
      return pickKey(.d_bb, .c, .c, .c)
    case .seven:
      return .dB
    case .eight:
      return pickKey(.e_bb, .d, .d, .d)
    case .nine:
      return .eB
    case .ten:
      return pickKey(.fB, .e, .e, .e)
    case .eleven:
      return pickKey(.g_bb, .f, .f, .f)
    }
  }
  
  func perfect5th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.g, .fX, .g, .g)
    case .one:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .two:
      return .a
    case .three:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .four:
      return pickKey(.cB, .b, .b, .b)
    case .five:
      return pickKey(.c, .bSh, .c, .c)
    case .six:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .seven:
      return .d
    case .eight:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .nine:
      return .e
    case .ten:
      return pickKey(.f, .eSh, .f, .f)
    case .eleven:
      return pickKey(.gB, .fSh, .gB, .fSh)
    }
  }
  
  func sharp5th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return .gSh
    case .one:
      return pickKey(.a, .gX, .a, .a)
    case .two:
      return .aSh
    case .three:
      return pickKey(.b, .aX, .b, .b)
    case .four:
      return pickKey(.c, .bSh, .c, .c)
    case .five:
      return pickKey(.cSh, .bX, .cSh, .bX)
    case .six:
      return pickKey(.d, .cX, .d, .d)
    case .seven:
      return .dSh
    case .eight:
      return pickKey(.e, .dX, .e, .e)
    case .nine:
      return .eSh
    case .ten:
      return pickKey(.fSh, .eX, .fSh, .eX)
    case .eleven:
      return pickKey(.g, .fX, .g, .g)
    }
  }
  
  func minor6th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .one:
      return pickKey(.b_bb, .a, .a, .a)
    case .two:
      return .bB
    case .three:
      return pickKey(.cB, .b, .b, .b)
    case .four:
      return pickKey(.d_bb, .c, .c, .c)
    case .five:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .six:
      return pickKey(.e_bb, .d, .d, .d)
    case .seven:
      return .eB
    case .eight:
      return pickKey(.fB, .e, .e, .e)
    case .nine:
      return .f
    case .ten:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .eleven:
      return pickKey(.a_bb, .g, .g, .g)
    }
  }
  
  func major6th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.a, .gX, .a, .a)
    case .one:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .two:
      return .b
    case .three:
      return pickKey(.c, .bSh, .c, .c)
    case .four:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .five:
      return pickKey(.d, .cX, .d, .d)
    case .six:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .seven:
      return .e
    case .eight:
      return pickKey(.f, .eSh, .f, .f)
    case .nine:
      return .fSh
    case .ten:
      return pickKey(.g, .fX, .g, .g)
    case .eleven:
      return pickKey(.aB, .gSh, .aB, .gSh)
    }
  }
  
  func dim7th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.b_bb, .a, .a, .a)
    case .one:
      return pickKey(.c_bb, .bB, .c_bb, .bB)
    case .two:
      return .cB
    case .three:
      return pickKey(.d_bb, .c, .c, .c)
    case .four:
      return .dB
    case .five:
      return pickKey(.e_bb, .d, .d, .d)
    case .six:
      return pickKey(.f_bb, .eB, .f_bb, .eB)
    case .seven:
      return .fB
    case .eight:
      return pickKey(.g_bb, .f, .f, .f)
    case .nine:
      return .gB
    case .ten:
      return pickKey(.a_bb, .g, .g, .g)
    case .eleven:
      return .aB
    }
  }
  
  func minor7th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.bB, .aSh, .bB, .aSh)
    case .one:
      return pickKey(.cB, .b, .b, .b)
    case .two:
      return .c
    case .three:
      return pickKey(.dB, .cSh, .dB, .cSh)
    case .four:
      return pickKey(.e_bb, .d, .d, .d)
    case .five:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .six:
      return pickKey(.fB, .e, .e, .e)
    case .seven:
      return .f
    case .eight:
      return pickKey(.gB, .fSh, .gB, .fSh)
    case .nine:
      return .g
    case .ten:
      return pickKey(.aB, .gSh, .aB, .gSh)
    case .eleven:
      return pickKey(.b_bb, .a, .a, .a)
    }
  }
  
  func major7th(rootNumber: NoteNumber) -> KeyName {
    switch rootNumber {
    case .zero:
      return pickKey(.b, .aX, .b, .b)
    case .one:
      return pickKey(.c, .bSh, .c, .c)
    case .two:
      return .cSh
    case .three:
      return pickKey(.d, .cX, .d, .d)
    case .four:
      return pickKey(.eB, .dSh, .eB, .dSh)
    case .five:
      return pickKey(.e, .dX, .e, .e)
    case .six:
      return pickKey(.f, .eSh, .f, .f)
    case .seven:
      return .fSh
    case .eight:
      return pickKey(.g, .fX, .g, .g)
    case .nine:
      return .gSh
    case .ten:
      return pickKey(.a, .gX, .a, .a)
    case .eleven:
      return pickKey(.bB, .aSh, .bB, .aSh)
    }
  }
}

/// a protocol to allow notes to adopt `EnharmonicSymbol` and `KeySwitch` variables
protocol KeySwitch: Enharmonic {
  var keySwitcher: KeySwitcher { get }
}
