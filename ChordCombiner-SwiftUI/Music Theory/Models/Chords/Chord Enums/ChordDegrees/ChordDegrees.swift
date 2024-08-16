//
//  ChordDegrees.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/**
 enum encompassing the fundamental characteristics of a chord
 
 - guide tones
 - extensions
 - alterations
 - tensions
 - tension chords
 
 */

enum ChordDegrees {
  
  /// chord degrees that imply light tension or a change in the chord's "flavor" without conflicting with its fundamental quality
  enum Alterations {
    case ma7, dom7, mi7, mi7_b5, dim7, ma6
    
    var alterations: Set<Int> {
      switch self {
      case .ma7:
        return [Interval.sh4_d5.rawValue] // [6]: #11 <-- EDIT add a #5 here?
      case .dom7:
        return [Interval.mi9.rawValue, Interval.sh9_mi3.rawValue, Interval.sh4_d5.rawValue, Interval.sh5_mi6.rawValue] // b9/#9, b5/#5 (or #11/b13) [1, 3, 6, 8]
      case .mi7, .mi7_b5:
        return [Interval.mi9.rawValue, Interval.sh5_mi6.rawValue] // [1, 8]: b9, b13 --> [1, 11]
      case .dim7:
        return [Interval.sh5_mi6.rawValue, Interval.ma7.rawValue] // [8, 11]: b13, ma7 --> [11, 15]
      case .ma6:
        return [Interval.sh9_mi3.rawValue, Interval.sh4_d5.rawValue] // [3, 6]: #9, #11 --> [3, 7]
      }
    }
  }
  
  /// degrees extending a chord while adding minimal extra tension (or none at all); typically, 9ths, 11ths and 13ths
  enum Extensions {
    case ma7, dom7, mi7, mi7_b5, dim7, ma6
    
    var extensions: Set<Int> {
      switch self {
      case .ma7, .dom7:
        return [Interval.ma2.rawValue, Interval.ma6_d7.rawValue] // 9, 13
      case .mi7, .mi7_b5:
        return [Interval.ma2.rawValue, Interval.p4.rawValue, Interval.ma6_d7.rawValue] // 9, 11, 13
      case .dim7:
        return [Interval.ma2.rawValue, Interval.p4.rawValue] // 9, 11
      case .ma6:
        return [Interval.ma2.rawValue] // 9
      }
    }
  }
  
  /// the degrees that most strongly imply a given chord category (usually 3rds & 7ths; in the case of 6th chords, 3rds and 6ths)
  enum GuideTones {
    case ma7, dom7, mi7, mi7_b5, dim7, ma6
    
    var guideTones: Set<Int> {
      switch self {
      case .ma7:
        return [Interval.ma3.rawValue, Interval.ma7.rawValue] // [4, 11]
      case .dom7:
        return [Interval.ma3.rawValue, Interval.mi7.rawValue] // [4, 10]
      case .mi7, .mi7_b5:
        return [Interval.sh9_mi3.rawValue, Interval.mi7.rawValue] // [3, 10]
      case .dim7:
        return [Interval.sh9_mi3.rawValue, Interval.ma6_d7.rawValue] // [3, 9]
      case .ma6:
        return [Interval.ma3.rawValue, Interval.ma6_d7.rawValue] // [4, 9]
      }
    }
  }
  
  /// chord degrees that are "outside" their respective chord categories and imply either a polychord or potentially a slash chord in a different key
  enum TensionTones {
    case ma7, dom7, mi7, mi7_b5, dim7, ma6
    
    var tensionTones: Set<Int> {
      switch self {
      case .ma7:
        return [Interval.mi9.rawValue, Interval.sh9_mi3.rawValue, Interval.p4.rawValue, Interval.sh5_mi6.rawValue, Interval.mi7.rawValue] // [1, 3, 5, 8, 10] <-- EDIT maybe take out b13?
      case .dom7:
        return [Interval.p4.rawValue, Interval.ma7.rawValue] // [p4, ma7]
        //                return [Interval.p4.rawValue, Interval.ma7.rawValue] // [5, 11]
      case .mi7:
        return [Interval.ma3.rawValue, Interval.sh4_d5.rawValue, Interval.ma7.rawValue] // [4, 6, 11]
      case .mi7_b5:
        return [Interval.ma3.rawValue, Interval.p5.rawValue, Interval.ma7.rawValue] // [4, 7, 11]
      case .dim7:
        return [Interval.mi9.rawValue, Interval.ma3.rawValue, Interval.p5.rawValue, Interval.mi7.rawValue] // [1, 4, 7, 10]
      case .ma6:
        return [Interval.p4.rawValue, Interval.sh5_mi6.rawValue] // [5, 8]
      }
    }
  }
}
