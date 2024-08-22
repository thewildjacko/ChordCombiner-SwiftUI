//
//  Suffix.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/3/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import Foundation

/// Giant enum to contain all suffixes for lower chords and upper structure triads
enum Suffix: String, CustomStringConvertible, Codable {
  var description: String {
    return self.rawValue
  }
  
  /// contains allCases arrays for lowerQualities, shorthand upper and longhand upper qualities
  struct QualArray: Codable {
    static var lowerQualities: [String] = Lower.allCases.map { String($0.qualStr) }
    static var upperQualities: [String] = Upper.allCases.map { String($0.qualStr) }
    static var longUpperQualities: [String] = LongUpper.allCases.map { String($0.qualStr) }
  }
  
  /// not sure why this is here, seems redundant...
  struct Blank: QualProtocol, Codable {
    var name: String = "blank"
    
    var quality: Suffix = .blank
    var qualStr: String {
      return quality.rawValue
    }
    static var qualities: [String] = []
  }
  
  enum Lower: String, QualProtocol, CaseIterable {
    case dom7, ma7, mi7, mi7_b5, dim7
    
    var quality: Suffix {
      switch self {
      case .dom7:
        return .sev
      case .ma7:
        return .ma7
      case .mi7:
        return .mi7
      case .mi7_b5:
        return .mi7_b5
      case .dim7:
        return .dim7
      }
    }
    
    var name: String {
      return qualStr
    }
    
    static var qualities: [String] {
      return Lower.allCases.map {$0.rawValue}
    }
  }
  
  enum Upper: String, QualProtocol, CaseIterable {
    case ma, mi, aug, dim, sus4, sus2
    
    var quality: Suffix {
      switch self {
      case .ma:
        return .ma
      case .mi:
        return .mi
      case .aug:
        return .aug
      case .dim:
        return .dim
      case .sus4:
        return .sus4
      case .sus2:
        return .sus2
      }
    }
    
    var name: String {
      return qualStr
    }
    
    static var qualities: [String] {
      return Upper.allCases.map {$0.rawValue}
    }
  }
  
  enum LongUpper: String, QualProtocol, CaseIterable {
    case maj, min, aug, dim, sus4, sus2
    
    var quality: Suffix {
      switch self {
      case .maj:
        return .maj
      case .min:
        return .min
      case .aug:
        return .aug
      case .dim:
        return .dimSymb
      case .sus4:
        return .sus4
      case .sus2:
        return .sus2
      }
    }
    
    var name: String {
      return qualStr
    }
    
    static var qualities: [String] {
      return LongUpper.allCases.map {$0.rawValue}
    }
    
    init(type: TriadType) {
      switch type {
      case .ma:
        self =  .maj
      case .mi:
        self =  .min
      case .aug:
        self =  .aug
      case .dim:
        self =  .dim
      case .sus4:
        self =  .sus4
      case .sus2:
        self =  .sus2
      }
    }
    
    init(_ num: Int) {
      switch num {
      case 0:
        self = .maj
      case 1:
        self = .min
      case 2:
        self = .aug
      case 3:
        self = .dim
      case 4:
        self = .sus4
      case 5:
        self = .sus2
      default:
        self = .maj
      }
    }
  }
  
  case blank = ""
  
  case ma
  case maj
  case mi
  case min
  case aug
  case dim
  case dimSymb = "˚"
  case sus4
  case sus2
  // done
  
  // MARK: Major 6
  case ma6 = "6"
  case ma6_sh9 = "6(♯9)"
  case ma6_b9 = "6(♭9)"
  case ma6_sh9sh11 = "6(♯9♯11)"
  case ma6_b9sh11 = "6(♭9♯11)"
  case ma6_sh11 = "6(♯11)"
  case ma6_9 = "⁶/₉"
  case ma6_9sh11 = "⁶/₉(♯11)"
  // done
  
  case b5 = "♭5"
  case sh5 = "♯5"
  case b7 = "♭7"
  case b9 = "♭9"
  case sh9 = "♯9"
  case sh11 = "♯11"
  case b13 = "♭13"
  
  // MARK: Dominant 7th Chords
  case sev = "7"
  case sev_b9 = "7(♭9)"
  case sev_sh9 = "7(♯9)"
  case sev_sh11 = "7(♯11)"
  case sev_b5 = "7(♭5)"
  case sev_sh5 = "7(♯5)"
  case sev_b13 = "7(♭13)"
  case sev_b9sh11 = "7(♭9♯11)"
  case sev_sh9sh11 = "7(♯9♯11)"
  case sev_b9b13 = "7(♭9♭13)"
  case sev_sh9b13 = "7(♯9♭13)"
  case sev_alt = "7alt"
  
  case nine = "9"
  case nine_sh11 = "9(♯11)"
  
  case xiii = "13"
  case xiii_sh9 = "13(♯9)"
  case xiii_sh11 = "13(♯11)"
  case xiii_sh11_omit7 = "13(♯11omit7)"
  case xiii_b9 = "13(♭9)"
  case xiii_b9sh11 = "13(♭9♯11)"
  case xiii_sh9sh11 = "13(♯9♯11)"
  
  case eleven = "11"
  
  // MARK: Major Lydian 7th Chords
  case ma7
  case ma9
  case ma13
  case ma13_no9
  case ma7_sh11 = "ma7(♯11)"
  case ma9_sh11 = "ma9(♯11)"
  case ma13_sh11 = "ma13(♯11)"
  case ma13_sh11_no9
  // done
  
  // MARK: Minor Dorian 7th Chords
  case mi7
  case mi9
  case mi11
  case mi11_no9
  case mi13
  case mi13_no9
  case mi13_no11
  case mi13_no9_no11
  //done
  
  // MARK: Min(b13)
  case mi_b6 = "mi(♭6)"
  case mi7_b13 = "mi7(♭13)"
  case mi9_b13 = "mi9(♭13)"
  case mi11_b13 = "mi11(♭13)"
  // done
  
  // MARK: Phrygian
  case mi7_b9 = "mi7(♭9)"
  case mi7_b9b13  = "mi7(♭9♭13)"
  case mi11_b9 = "mi11(♭9)"
  case mi11_b9b13 = "mi11(♭9♭13)"
  case mi13_b9 = "mi13(♭9)"
  // done
  
  // MARK: mi7(b5)
  case mi7_b5 = "mi7(♭5)"
  case b5_noCloseParen = "(♭5"
  case mi7_b5b9 = "mi7(♭5♭9)"
  case mi7_b5b13 = "mi7(♭5♭13)"
  case mi7_b5add11 = "mi7(♭5add11)"
  case mi9_b5 = "mi9(♭5)"
  case mi11_b5 = "mi11(♭5)"
  case mi11_b5b9 = "mi11(♭5♭9)"
  case mi11_b5b13 = "mi11(♭5♭13)"
  case locrian = " locrian"
  // done
  
  // MARK: diminished
  case dim7 = "˚7"
  case dim7_b13 = "˚7(♭13)"
  case dim7_add_ma7 = "˚7(add∆7)"
  case dim7_b13_add_ma7 = "˚7(♭13add∆7)"
  case dim9 = "˚9"
  case dim9_add_ma7 = "˚9(add∆7)"
  case dim9_b13_add_ma7 = "˚9(♭13add∆7)"
  case dim11 = "˚11"
  case dim11_b13 = "˚11(♭13)"
  case dim11_add_ma7 = "˚11(add∆7)"
  case dim11_b13_add_ma7 = "˚11(♭13add∆7)"
  
  case tension = "tension!"
  case errorRCNotFound = "error! result chord not found!"
  
  init(type: String) {
    switch type {
      
    case "♭5":
      self = .b5
    case "♯5":
      self = .sh5
    case "♭7":
      self  = .b7
    case "♭9":
      self = .b9
    case "♯9":
      self = .sh9
    case "♯11":
      self = .sh11
    case "♭13":
      self = .b13
      
    case "6":
      self = .ma6
    case "6(♯9)":
      self = .ma6_sh9
    case "6(♭9)":
      self = .ma6_b9
    case "6(♯9♯11)":
      self = .ma6_sh9sh11
    case "6(♭9♯11)":
      self = .ma6_b9sh11
    case "6(♯11)":
      self = .ma6_sh11
      
    case "6/9":
      self = .ma6_9
    case "6/9(♯11)":
      self = .ma6_9sh11
      
    case "7":
      self = .sev
    case "7(♭9)":
      self = .sev_b9
    case "7(♯9)":
      self = .sev_sh9
    case "7(♯11)":
      self = .sev_sh11
    case "7(♭5)":
      self = .sev_b5
    case "7(♯5)":
      self = .sev_sh5
    case "7(♭13)":
      self = .sev_b13
    case "7(♭9♯11)":
      self = .sev_b9sh11
    case "7(♯9♯11)":
      self = .sev_sh9sh11
    case "7(♭9♭13)":
      self = .sev_b9b13
    case "7(♯9♭13)":
      self = .sev_sh9b13
    case "7alt":
      self = .sev_alt
      
    case "9":
      self = .nine
    case "9(♯11)":
      self = .nine_sh11
      
    case "11":
      self = .eleven
      
    case "13":
      self = .xiii
    case "13(♯9)":
      self = .xiii_sh9
    case "13(♯11)":
      self = .xiii_sh11
    case "13(♭9)":
      self = .xiii_b9
    case "13(♭9♯11)":
      self = .xiii_b9sh11
    case "13(♯9♯11)":
      self = .xiii_sh9sh11
    case "13(♯11omit7)":
      self = .xiii_sh11_omit7
      
    case "ma7":
      self = .ma7
    case "ma9":
      self = .ma9
    case "ma13", "ma13_no9":
      self = .ma13
    case "ma7(♯11)":
      self = .ma7_sh11
    case "ma9(♯11)":
      self = .ma9_sh11
    case "ma13(♯11)", "ma13_sh11_no9":
      self = .ma13_sh11
      
    case "mi7":
      self = .mi7
    case "mi9":
      self = .mi9
    case "mi11", "mi11_no9":
      self = .mi11
    case "mi13", "mi13_no9", "mi13_no11", "mi13_no9_no11":
      self = .mi13
      
    case "mi7(♭5)":
      self = .mi7_b5
    case "(♭5":
      self = .b5_noCloseParen
    case "mi7(♭5♭9)":
      self = .mi7_b5b9
    case "mi7(♭5♭13)":
      self = .mi7_b5b13
    case "mi7(♭5add 11)":
      self = .mi7_b5add11
    case "mi9(♭5)":
      self = .mi9_b5
    case "mi11(♭5)":
      self = .mi11_b5
    case "mi11(♭5♭9)":
      self = .mi11_b5b9
    case "mi11(♭5♭13)":
      self = .mi11_b5b13
    case "mi13(♭9)":
      self = .mi13_b9
    case " locrian":
      self = .locrian
      
    case "˚7":
      self = .dim7
    case "˚7(♭13)":
      self = .dim7_b13
    case "˚7(add∆7)":
      self = .dim7_add_ma7
    case "˚7(♭13add∆7)":
      self = .dim7_b13_add_ma7
    case "˚9":
      self = .dim9
    case "˚9(add∆7)":
      self = .dim9_add_ma7
    case "˚9(♭13add∆7)":
      self = .dim9_b13_add_ma7
    case "˚11":
      self = .dim11
    case "˚11(♭13)":
      self = .dim11_b13
    case "˚11(add∆7)":
      self = .dim11_add_ma7
    case "˚11(♭13add∆7)":
      self = .dim11_b13_add_ma7
    case "tension!":
      self = .tension
    case "errorRCNotFound":
      self = .errorRCNotFound
    case "":
      self = .blank
      
    default:
      self = .sev
    }
  }
}
