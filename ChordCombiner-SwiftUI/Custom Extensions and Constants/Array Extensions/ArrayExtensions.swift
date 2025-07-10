//
//  Array Extensions.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 2/2/22.
//  Copyright © 2022 Jake Smolowe. All rights reserved.
//

import SwiftUI
import Algorithms

// Batch calculations for DispatchQueue.concurrentPerform()
extension Array {
  func calculateBatch() -> Int {
    return self.count <= 5 ? self.count : 5
  }

  func calculateStartPoint(batch: Int, iteration: Int, elementsInBatch: Int) -> Int {
    guard !self.isEmpty && self.count != 0 else {
      return 0
    }

    let count = self.count
    let endPoint = count - 1

    var startPoint = iteration * elementsInBatch
    startPoint = startPoint <= endPoint ? startPoint : endPoint

    return startPoint
  }

  func calculateEndPoint(startPoint: Int, elementsInBatch: Int) -> Int {
    guard !self.isEmpty && self.count != 0 else {
      return 0
    }

    let count = self.count
    let arrayEnd = count - 1

    var endPoint = startPoint + elementsInBatch
    endPoint = endPoint <= arrayEnd ? endPoint : arrayEnd

    return endPoint
  }

  func elementsInBatch(batch: Double) -> Int {
    let elementsDouble = Double(Double(self.count) / batch).rounded(.up)
    return Int(elementsDouble)
  }
}
