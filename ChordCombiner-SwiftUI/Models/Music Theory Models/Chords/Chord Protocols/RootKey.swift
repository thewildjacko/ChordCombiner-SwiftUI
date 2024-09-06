//
//  RootKey.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol RootKey {
  var rootNote: RootNote { get set }
  var root: Note { get }
  var rootKey: RootGen { get }
}

extension RootKey {
  var rootKey: RootGen {
    return rootNote.rootKey
  }
}
