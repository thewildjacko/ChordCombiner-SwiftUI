//
//  RootKey.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol RootKey {
  var root: RootNote { get set }
  var rootKey: KeyName { get }
}

extension RootKey {
  var rootKey: KeyName {
    return root.note.key
  }
}
