//
//  KeyShape.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/7/24.
//

import Foundation
import SwiftUI

protocol KeyShapeProtocol: Shape {
  var finalKey: Bool { get }
  var width: CGFloat { get }
  var height: CGFloat { get }
  var radius: CGFloat { get }
  var widthMultiplier: CGFloat { get }
  var keyShapePathType: KeyShapePathType { get }
}
