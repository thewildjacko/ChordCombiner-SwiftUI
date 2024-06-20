//
//  QualProtocol.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

protocol QualProtocol {
  var quality: Suffix { get }
  var qualStr: String { get }
  var name: String { get }
  static var qualities: [String] { get }
}

extension QualProtocol {
  var qualStr: String {
    return quality.rawValue
  }
}
