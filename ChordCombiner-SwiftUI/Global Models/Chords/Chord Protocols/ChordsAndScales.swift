//
//  ChordsAndScales.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

/// Protocol to use for both ``Chord`` and Scale objects—essentially any multi-note object.
///
/// - Note: Scale hasn't been implemented yet, beyond the scope of the project
protocol ChordsAndScales: RootNote, GettableKeyName, EnharmonicID {
  var rootKeyNote: RootKeyNote { get }
  var notes: [Note] { get set }
  var rootKeyNotes: [RootKeyNote] { get set }
  var noteNumbers: [NoteNumber] { get set }
}
