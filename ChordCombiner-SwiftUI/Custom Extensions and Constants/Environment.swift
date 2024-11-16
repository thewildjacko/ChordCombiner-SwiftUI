//
//  Environment.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/12/24.
//

import SwiftUI

struct LowerKeyboardColorKey: EnvironmentKey {
  static let defaultValue: Color = .yellow
}

struct UpperKeyboardColorKey: EnvironmentKey {
  static let defaultValue: Color = .cyan
}

extension EnvironmentValues {
  var lowerKeyboardColor: Color {
    get { self[LowerKeyboardColorKey.self] }
    set { self[LowerKeyboardColorKey.self] = newValue }
  }
  
  var upperKeyboardColor: Color {
    get { self[UpperKeyboardColorKey.self] }
    set { self[UpperKeyboardColorKey.self] = newValue }
  }
}

