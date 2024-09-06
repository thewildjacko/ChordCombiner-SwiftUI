//
//  RootNote.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct RootNote {
  var note: Note
  
  init(_ note: Note = Note(.c)) {
    self.note = note
  }
}
