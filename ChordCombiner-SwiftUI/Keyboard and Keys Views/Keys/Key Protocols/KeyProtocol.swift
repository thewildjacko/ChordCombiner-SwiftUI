//
//  KeyProtocol.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/2/24.
//

import Foundation
import SwiftUI

protocol KeyProtocol {
  var id: UUID { get set }
  var pitch: Int { get set }
  var keyType: KeyType { get set }
  var note: Note? { get set }

  var baseWidth: CGFloat { get set }
  var widthDivisor: CGFloat { get set }
  var initialKey: Bool { get set }
  var finalKey: Bool { get set }
  var keyPosition: CGFloat { get set }
  var highlighted: Bool { get set }
  var letterTextColor: Color { get }

  var widthMultiplier: CGFloat { get }

  var fill: Color { get set }
  var stroke: Color { get set }
  var lineWidth: CGFloat { get set }
  var lettersOn: Bool { get set }
  var circlesOn: Bool { get set }

  init(
    pitch: Int,
    keyType: KeyType,
    note: Note?,
    baseWidth: CGFloat,
    widthDivisor: CGFloat,
    keyPosition: CGFloat,
    fill: Color,
    stroke: Color,
    lineWidth: CGFloat,
    initialKey: Bool,
    finalKey: Bool,
    lettersOn: Bool,
    circlesOn: Bool,
    circleType: KeyCircleType)

  func radius() -> CGFloat
  func width() -> CGFloat
  func height() -> CGFloat
}
