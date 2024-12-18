//
//  KeyCircle.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/10/24.
//

import SwiftUI

typealias KeyCircleType = KeyCircle.CircleType

struct KeyCircle: Shape {
  var width: CGFloat
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool

  private var radius: CGFloat { width/2 }

  init(width: CGFloat, startAngle: Angle, endAngle: Angle, clockwise: Bool) {
    self.width = width
    self.startAngle = startAngle
    self.endAngle = endAngle
    self.clockwise = clockwise
  }

  func path(in rect: CGRect) -> Path {
    Path { path in
      let rotationAdjustment = Angle.degrees(180)
      let modifiedStart = startAngle - rotationAdjustment
      let modifiedEnd = endAngle - rotationAdjustment

      path.addArc(
        center: CGPoint(x: rect.midX, y: rect.midY),
        radius: radius,
        startAngle: modifiedStart,
        endAngle: modifiedEnd,
        clockwise: clockwise)

      path.closeSubpath()
    }
  }
}

extension KeyCircle {
  enum CircleType {
    case lower, upper, common

    var startAngle: Angle {
      switch self {
      case .upper:
          .degrees(180)
      default:
          .degrees(0)
      }
    }

    var endAngle: Angle {
      switch self {
      case .lower:
          .degrees(180)
      case .upper:
          .degrees(0)
      case .common:
          .degrees(360)
      }
    }

    var color: Color {
      switch self {
      case .common:
          .upperChordHighlight
      default:
          .black
      }
    }

    var strokeColor: Color {
      switch self {
      case .common:
          .black
      default:
          .black
      }
    }
  }
}

#Preview {
  KeyCircle(width: 100, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
}
