//
//  Mode.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// to enumerate modes for single-mode, 2-mode and 7-mode scales
enum Mode {
  case seven, two, one
  
  /// for scales with no other common named modes
  enum SingleDeg: Int, CaseIterable, ModeProtocol {
    var mode: SingleDeg {
      return self
    }
    case one = 0
  }
  
  /// for 2-mode scales like diminished scales
  enum TwoDeg: Int, CaseIterable, ModeProtocol {
    case one = 0, two
    
    var mode: TwoDeg {
      return self
    }
    
    init(_ num: Int) {
      switch num {
      case 0:
        self = .one
      case 1:
        self = .two
      default:
        self = .one
      }
    }
  }
  
  /// for major scales, harmonic minor, melodic minor and other 7-mode scales
  enum SevenDeg: Int, CaseIterable, ModeProtocol { //
    case one = 0, two, three, four, five, six, seven
    
    var mode: SevenDeg {
      return self
    }
    
    var name: String {
      switch self {
      case .one:
        return "one"
      case .two:
        return "two"
      case .three:
        return "three"
      case .four:
        return "four"
      case .five:
        return "five"
      case .six:
        return "six"
      case .seven:
        return "seven"
      }
    }
    
    init(_ num: Int) {
      switch num {
      case 0:
        self = .one
      case 1:
        self = .two
      case 2:
        self = .three
      case 3:
        self = .four
      case 4:
        self = .five
      case 5:
        self = .six
      case 6:
        self = .seven
      default:
        self = .one
      }
    }
  }
}

/// not sure why this is here, so far haven't used it...
protocol ModeProtocol {
  associatedtype ScaleMode where ScaleMode: RawRepresentable // or this...
  var mode: ScaleMode { get }
}
