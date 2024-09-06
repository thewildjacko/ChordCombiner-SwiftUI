//
//  Root.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct Root {
  var rootKey: RootGen
  var note: Note {
    get { Note(rootKey) }
    set { }
  }
  
  init(_ rootKey: RootGen) {
    self.rootKey = rootKey
  }
  
  init(_ note: Note) {
    self.rootKey = RootGen(note.key)
  }
}
