//
//  RootNote.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 9/6/24.
//

import Foundation

struct RootNote {
  var root: RootGen
  var note: Note {
    Note(root)
  }
  
  init(_ root: RootGen) {
    self.root = root
  }
}
