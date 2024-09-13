//
//  Root.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct Root {
  var rootKeyNote: RootKeyNote
  var note: Note {
    get { Note(rootKeyNote) }
    set { }
  }
  
  init(_ rootKeyNote: RootKeyNote) {
    self.rootKeyNote = rootKeyNote
  }
  
  init(_ note: Note) {
    self.rootKeyNote = RootKeyNote(note.keyName)
  }
}
