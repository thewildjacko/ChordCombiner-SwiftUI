//
//  SuffixGenerator.swift
//  ChordCombiner
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

struct SuffixGenerator {
  let degSpecs: DegSpecs
  var suffix: String = ""
  
  init(degSpecs: DegSpecs) {
    self.degSpecs = degSpecs
    self.suffix = getSuffix()
  }
  
  var chordNum: Suffix {
    switch degSpecs.maxUnalteredExtension {
    case 9:
      return Suffix.xiii
    case 5:
      return Suffix.eleven
    case 2:
      return degSpecs.type != .ma6 ? Suffix.nine : Suffix.ma6_9
    default:
      return degSpecs.type != .ma6 ? Suffix.sev : Suffix.ma6
    }
  }
  
  mutating func getSuffix() -> String {
    
    let noTensionOrAlterations = degSpecs.altSet.isEmpty && degSpecs.tensionSet.isEmpty
    
    func openParen() {
      suffix += "("
    }
    func closeParen() {
      suffix += ")"
    }
    
    switch degSpecs.type {
    case .ma7:
      suffix += Suffix.ma.rawValue + chordNum.rawValue
      
      if noTensionOrAlterations {
        return suffix
      } else {
        var checkedFor9ths = false
        if !degSpecs.altSet.isEmpty {
          openParen()
          b9_Sh9()
          checkedFor9ths = true
          TTone()
        }
        if !degSpecs.tensionSet.isEmpty {
          if !suffix.contains("(") {
            openParen()
          }
          if !checkedFor9ths {
            b9_Sh9()
          }
          
          min6_sh5()
          P4_ma7_mi7(tensions: degSpecs.tensionTones)
        }
        closeParen()
        return suffix
      }
    case .dom7:
      suffix += chordNum.rawValue
      let altCount = degSpecs.altSet.count
      
      if noTensionOrAlterations {
        return suffix
      } else {
        if !degSpecs.altSet.isEmpty {
          if altCount > 2 {
            suffix += "alt"
            if degSpecs.degSet.isSuperset(of: Set([6, 7, 8])) {
              suffix += "(add P5)"
            }
            return suffix
          } else {
            openParen()
            b9_Sh9()
            TTone()
            min6_sh5()
          }
        }
        if !degSpecs.tensionSet.isEmpty {
          if !suffix.contains("(") {
            openParen()
          }
          P4_ma7_mi7(tensions: degSpecs.tensionTones)
        }
        closeParen()
        return suffix
      }
    case .mi7:
      suffix += Suffix.mi.rawValue + chordNum.rawValue
      
      if noTensionOrAlterations {
        return suffix
      } else {
        if !degSpecs.altSet.isEmpty {
          openParen()
          b9_Sh9()
          min6_sh5()
        }
        if !degSpecs.tensionSet.isEmpty {
          if !suffix.contains("(") {
            openParen()
          }
          add_maj3rd()
          TTone()
          P4_ma7_mi7(tensions: degSpecs.tensionTones)
        }
        closeParen()
        return suffix
      }
    case .mi7_b5:
      if degSpecs.tensionSet.isEmpty && degSpecs.degSet.isSuperset(of: [1, 8]) {
        return " locrian"
      } else {
        suffix += Suffix.mi.rawValue + chordNum.rawValue + Suffix.b5_noCloseParen.rawValue
        
        if noTensionOrAlterations {
          closeParen()
          return suffix
        } else {
          if !degSpecs.altSet.isEmpty {
            b9_Sh9()
            min6_sh5()
          }
          if !degSpecs.tensionSet.isEmpty {
            if !suffix.contains("(") {
              openParen()
            }
            add_maj3rd()
            add_P5()
            P4_ma7_mi7(tensions: degSpecs.tensionTones)
          }
          closeParen()
          return suffix
        }
      }
    case .dim7:
      suffix += Suffix.dimSymb.rawValue + chordNum.rawValue
      if noTensionOrAlterations {
        return suffix
      } else {
        openParen()
        b9_Sh9()
        min6_sh5()
        add_maj3rd()
        add_P5()
        P4_ma7_mi7(tensions: degSpecs.tensionTones)
        closeParen()
        return suffix
      }
    case .ma6:
      suffix += chordNum.rawValue
      
      if noTensionOrAlterations {
        return suffix
      } else {
        openParen()
        b9_Sh9()
        TTone()
        min6_sh5()
        P4_ma7_mi7(tensions: degSpecs.tensionTones)
        closeParen()
        return suffix
      }
    }
  }
  
  mutating func b9_Sh9() {
    if degSpecs.contains.b9 {
      suffix += Suffix.b9.rawValue
    }
    if degSpecs.contains.sh9 {
      suffix += Suffix.sh9.rawValue
    }
  }
  
  mutating func add_maj3rd() {
    if degSpecs.contains.maj3rd {
      suffix += "add∆3"
    }
  }
  
  mutating func add_P5() {
    if degSpecs.contains.P5 {
      let spacer: String = degSpecs.contains.maj3rd ? " " : ""
      suffix += "\(spacer)addP5"
    }
  }
  
  mutating func TTone() {
    if degSpecs.has.maj3rd {
      let tritone: Suffix = degSpecs.contains.tritone ?
      degSpecs.has.P5 ? Suffix.sh11 : Suffix.b5 : Suffix.blank
      suffix += tritone.rawValue
    } else {
      if degSpecs.has.P5 {
        let tritone = degSpecs.contains.tritone ?
        "add\(Suffix.sh11.rawValue)" : ""
        suffix += tritone
      }
    }
  }
  
  mutating func min6_sh5() {
    let min6: Suffix
    if degSpecs.contains.min6_sh5 {
      if degSpecs.has.P5 {
        min6 = .b13
      } else {
        if !degSpecs.has.b5 {
          min6 = .sh5
        } else {
          min6 = .b13
        }
      }
    } else {
      min6 = .blank
    }
    suffix += min6.rawValue
  }
  
  mutating func P4_ma7_mi7(tensions: Set<Int>){
    let seventhNum: Int = tensions.contains(10) ? 10 : 11
    if degSpecs.has.maj3rd {
      if degSpecs.degSet.isSuperset(of: [5, seventhNum]) {
        let both = seventhNum == 10 ? "add11 add\(Suffix.b7)" : "add11 add∆7"
        suffix += both
      } else {
        if degSpecs.contains.P4 {
          suffix += "add11"
        }
        if degSpecs.degSet.contains(seventhNum) {
          let seventh = seventhNum == 10 ? "add\(Suffix.b7)" : "add∆7"
          suffix += seventh
        }
      }
    } else {
      let has_maj3rd_or_P5 = (degSpecs.contains.maj3rd || degSpecs.contains.P5)
      if degSpecs.contains.maj7 {
        if degSpecs.has.b5 {
          let spacer: String = has_maj3rd_or_P5 ? " " : ""
          suffix += "\(spacer)add∆7"
        } else {
          suffix += "add∆7"
        }
      }
      if degSpecs.is_dim && degSpecs.contains.min7 {
        let spacer: String = has_maj3rd_or_P5 ? " " : ""
        suffix += "\(spacer)add\(Suffix.b7)"
      }
    }
  }
}
