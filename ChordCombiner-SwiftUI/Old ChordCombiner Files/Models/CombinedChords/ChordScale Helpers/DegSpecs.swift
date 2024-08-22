//
//  DegSpecs.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/19/24.
//  Copyright © 2024 Jake Smolowe. All rights reserved.
//

import Foundation

struct DegSpecs {
  let degSet: Set<Int>
  var degs: [Int] {
    return degSet.sorted()
  }
  let type: FNCType
  let is_maj7: Bool
  let is_dom7: Bool
  let is_mi7: Bool
  let is_mi7_b5: Bool
  let is_dim: Bool
  let is_maj6: Bool
  
  var has: (min3rd: Bool, maj3rd: Bool, b5: Bool, P5: Bool) {
    let maj3rd = (is_maj7 || is_dom7 || is_maj6)
    let min3rd = (is_mi7 || is_mi7_b5 || is_dim)
    let P5 = (maj3rd || is_mi7)
    let b5 = (is_mi7_b5 || is_dim)
    
    return (min3rd: min3rd, maj3rd: maj3rd, b5: b5, P5: P5)
  }
  
  var contains: (b9: Bool, sh9: Bool, maj3rd: Bool, P4: Bool, tritone: Bool, P5: Bool, min6_sh5: Bool, min7: Bool, maj7: Bool) {
    let b9 = degSet.contains(1)
    let sh9 = degSet.contains(3) && has.maj3rd
    let maj3rd = degSet.contains(4)
    let p4 = degSet.contains(5)
    let tritone = degSet.contains(6)
    let p5 = degSet.contains(7)
    let min6_sh5 = degSet.contains(8)
    let min7 = degSet.contains(10)
    let maj7 = degSet.contains(11)
    
    return (b9: b9, sh9: sh9, maj3rd: maj3rd, P4: p4, tritone: tritone, P5: p5, min6_sh5: min6_sh5, min7: min7, maj7: maj7)
  }
  
  var rootNum: Int
  
  init(rootNum: Int, degSet: Set<Int>, type: FNCType) {
    self.rootNum = rootNum
    self.degSet = degSet
    self.type = type
    
    is_maj7 = type == .ma7
    is_dom7 = type == .dom7
    is_mi7 = type == .mi7
    is_mi7_b5 = type == .mi7_b5
    is_dim = type == .dim7
    is_maj6 = type == .ma6
    
    self.tensionScore = getTensionScore()
  }
  
  var extensions: Set<Int> {
    let exts: Set<Int>
    switch degSet {
    case _ where has.maj3rd:
      exts = !is_maj6 ? Extensions.ma7.extensions : Extensions.ma6.extensions
    case _ where has.min3rd && !is_dim:
      exts = Extensions.mi7.extensions
    default:
      exts = Extensions.dim7.extensions
    }
    return exts
  }
  
  var maxUnalteredExtension: Int {
    let extSet = degSet.intersection(extensions)
    return extSet.max() ?? 0
  }
  
  var upperExtNum: Int? {
    return maxUnalteredExtension != 0 ? maxUnalteredExtension : nil
  }
  
  var alterations: Set<Int> {
    switch type {
    case .ma7:
      return Alterations.ma7.alterations
    case .dom7:
      return Alterations.dom7.alterations
    case .mi7, .mi7_b5:
      return Alterations.mi7.alterations
    case .dim7:
      return Alterations.dim7.alterations
    case .ma6:
      return Alterations.ma6.alterations
    }
  }
  
  var altSet: Set<Int> {
    return degSet.intersection(alterations)
  }
  
  var guideTones: Set<Int> {
    switch type {
    case .ma7:
      return GuideTones.ma7.guideTones
    case .dom7:
      return GuideTones.dom7.guideTones
    case .mi7, .mi7_b5:
      return GuideTones.mi7.guideTones
    case .dim7:
      return GuideTones.dim7.guideTones
    case .ma6:
      return GuideTones.ma6.guideTones
    }
  }
  
  var gtSet: Set<Int> {
    return degSet.intersection(guideTones)
  }
  
  var outNotesScore: Int = 0
  var tritoneScore: Int = 0
  var hsScore: Int = 0
  
  var multiHS: (present: Bool, longestGroup: Int) = (present: false, longestGroup: 0)
  
  var tensionTones: Set<Int> {
    switch type {
    case .ma7:
      return TensionTones.ma7.tensionTones
    case .dom7:
      return TensionTones.dom7.tensionTones
    case .mi7:
      return TensionTones.mi7.tensionTones
    case .mi7_b5:
      return TensionTones.mi7_b5.tensionTones
    case .dim7:
      return TensionTones.dim7.tensionTones
    case .ma6:
      return TensionTones.ma6.tensionTones
    }
  }
  
  var tensionSet: Set<Int> {
    return degSet.intersection(tensionTones)
  }
  
  var tensionScore: Int = 0
  
  mutating func getTensionScore() -> Int {
    //        mutating get {
    var myTensionScore = 0
    
    guard degSet.count > 1 else {
      return 0
    }
    
    var outScore: Int = 0
    let tensions = degSet.intersection(tensionTones)
    if !tensions.isEmpty {
      outScore += 3 * tensions.count
      myTensionScore += outScore
      outNotesScore = outScore
    }
    
    var myTritoneScore = 0
    for i in 0...degs.count - 2 {
      for j in (i + 1)...degs.count - 1 {
        let (deg1, deg2) = (degs[i], degs[j])
        if deg1.isTritone(from: deg2) {
          //                        print("tritone!")
          myTritoneScore += 1
        }
      }
    }
    myTensionScore += myTritoneScore
    tritoneScore = myTritoneScore
    
    var myHSScore: Int = 0
    var hsGroup: [Int] = []
    var longestGroup: Int = 0
    
    func hsGroups(myDegs: [Int]) {
      var ind = 1
      
      func mutipleHS() {
        if hsGroup.count > 2 {
          multiHS.present = true
          
          let multiHSScore = hsGroup.count - 1
          myHSScore += multiHSScore
          
          if multiHSScore > longestGroup {
            longestGroup = multiHSScore
          }
          
          //                        print("multiple half steps! \(hsGroup)\nadding \(multiHSScore). new score: \(myHSScore)")
        }
      }
      while ind < myDegs.endIndex {
        let deg = myDegs[ind - 1]
        let nextDeg = myDegs[ind]
        
        if nextDeg - deg == 1 {
          if !hsGroup.contains(deg) {
            hsGroup.append(deg)
          }
          hsGroup.append(nextDeg)
          myHSScore += 1
          //                        print("HS b/n \(deg)-\(nextDeg), new score: \(myHSScore)")
          
          if ind == myDegs.endIndex - 1 {
            mutipleHS()
          }
        } else {
          mutipleHS()
          hsGroup.removeAll()
        }
        ind += 1
      }
    }
    
    if degSet.isSuperset(of: [0, 11]) {
      var newDegs = degs
      let degsReversed = Array(degs.reversed())
      //                print("initial hsScore = \(myHSScore)")
      //                print("overlap HS b/n 11-0, new score: \(myHSScore)")
      hsGroup.append(11)
      myHSScore += 1
      newDegs.remove(at: newDegs.endIndex - 1)
      
      var j = 10
      for nextRDeg in degsReversed[1...degsReversed.count - 1] {
        if nextRDeg == j {
          hsGroup.append(nextRDeg)
          newDegs.remove(at: newDegs.endIndex - 1)
          myHSScore += 1
          //                        print("reverse HS b/n \(nextRDeg)-\(nextRDeg + 1), new score: \(myHSScore)")
          j -= 1
        } else {
          break
        }
      }
      
      hsGroups(myDegs: newDegs)
    } else {
      hsGroups(myDegs: degs)
    }
    
    multiHS.longestGroup = longestGroup > 0 ? longestGroup : 0
    myTensionScore += myHSScore
    hsScore = myHSScore
    
    return myTensionScore
    //        }
  }
  
  var isTension: Bool {
    return (outNotesScore != 0 || multiHS.present == true)
  }
  
  var verdict: Verdict = .goodToGo
}
