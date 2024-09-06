//
//  RootNote.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct RootNote: Codable {
  var note: Note
  
  /// The `KeyName` of the root; use to initiate other roots or scale/chord degrees
  var keyName: KeyName {
    switch note {
    case let note where note == Note(.c):
      return .c
    case let note where note == Note(.d):
      return .d
    case let note where note == Note(.e):
      return .e
    case let note where note == Note(.f):
      return .f
    case let note where note == Note(.g):
      return .g
    case let note where note == Note(.a):
      return .a
    case let note where note == Note(.b):
      return .b
    case let note where note == Note(.cB):
      return .cB
    case let note where note == Note(.dB):
      return .dB
    case let note where note == Note(.eB):
      return .eB
    case let note where note == Note(.fB):
      return .fB
    case let note where note == Note(.gB):
      return .gB
    case let note where note == Note(.aB):
      return .aB
    case let note where note == Note(.bB):
      return .bB
    case let note where note == Note(.cSh):
      return .cSh
    case let note where note == Note(.dSh):
      return .dSh
    case let note where note == Note(.eSh):
      return .eSh
    case let note where note == Note(.fSh):
      return .fSh
    case let note where note == Note(.gSh):
      return .gSh
    case let note where note == Note(.aSh):
      return .aSh
    case let note where note == Note(.bSh):
      return .bSh
    }
  }
  
  init(_ note: Note = Note(.c)) {
    self.note = note
  }
  
  init(_ key: KeyName) {
    self.note = Note(key)
  }
  
  init(_ letter: Letter, _ accidental: RootAcc) {
    switch accidental {
    case .flat:
      switch letter {
      case .c:
        self.note = Note(.cB)
      case .d:
        self.note = Note(.dB)
      case .e:
        self.note = Note(.eB)
      case .f:
        self.note = Note(.fB)
      case .g:
        self.note = Note(.gB)
      case .a:
        self.note = Note(.aB)
      case .b:
        self.note = Note(.bB)
      }
    case .natural:
      switch letter {
      case .c:
        self.note = Note(.c)
      case .d:
        self.note = Note(.d)
      case .e:
        self.note = Note(.e)
      case .f:
        self.note = Note(.f)
      case .g:
        self.note = Note(.g)
      case .a:
        self.note = Note(.a)
      case .b:
        self.note = Note(.b)
      }
    case .sharp:
      switch letter {
      case .c:
        self.note = Note(.cSh)
      case .d:
        self.note = Note(.dSh)
      case .e:
        self.note = Note(.eSh)
      case .f:
        self.note = Note(.fSh)
      case .g:
        self.note = Note(.gSh)
      case .a:
        self.note = Note(.aSh)
      case .b:
        self.note = Note(.bSh)
      }
    }
  }
}
