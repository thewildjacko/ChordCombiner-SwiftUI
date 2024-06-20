//
//  ChordInversion.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol ChordInversion {
  var name: (short: String, long: String) { get }
  var num: FNCInversion { get }
}
