//
//  Root.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct Root {
  var rootKeyNote: RootKeyNote { didSet { note = Note(rootKeyNote) } }
  private(set) var note: Note

  init(_ rootKeyNote: RootKeyNote) {
    self.rootKeyNote = rootKeyNote
    note = Note(rootKeyNote)
  }

  init(_ note: Note) {
    self.rootKeyNote = RootKeyNote(note.keyName)
    self.note = Note(rootKeyNote)
  }
}
