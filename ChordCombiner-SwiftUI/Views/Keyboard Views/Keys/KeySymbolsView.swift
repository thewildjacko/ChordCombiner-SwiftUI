//
//  KeySymbolsView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 11/20/24.
//

import SwiftUI

struct KeyLetterView: View {
  let width: CGFloat
  let sizeMultiplier: CGFloat
  let textColor: Color
  var note: Note?
  var lettersOn: Bool
  
  @ViewBuilder
  var body: some View {
    if lettersOn {
      if let note = note {
        TitleView(
          text: note.noteName,
          font: .system(size: width * sizeMultiplier),
          color: textColor
        )
      }
    }
  }
}

struct KeyCirclesView: View {
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
  
  let width: CGFloat
  let sizeMultiplier: CGFloat
  var diameter: CGFloat { width * sizeMultiplier * 0.85 }
  
  var circlesOn: Bool
  var circleType: CircleType
  var lineWidth: CGFloat
  
  @ViewBuilder
  var body: some View {
    if circlesOn {
      KeyCircle(width: diameter, startAngle: circleType.startAngle, endAngle: circleType.endAngle, clockwise: true)
        .foregroundStyle(circleType.color)
        .frame(width: diameter, height: diameter)
        .overlay {
          Circle()
            .strokeBorder(circleType.strokeColor, lineWidth: lineWidth)
            .foregroundStyle(.clear)
            
        }
    }
  }
}

#Preview {
  VStack {
    KeyCirclesView(width: 100, sizeMultiplier: 0.7, circlesOn: true,  circleType: .lower, lineWidth: 1)
    KeyCirclesView(width: 100, sizeMultiplier: 0.7, circlesOn: true,  circleType: .upper, lineWidth: 1)
    KeyCirclesView(width: 100, sizeMultiplier: 0.7, circlesOn: true,  circleType: .common, lineWidth: 1)
  }
}

struct KeyCircle: Shape {
  var width: CGFloat
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  var radius: CGFloat { width/2 }
  
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
      
      path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
      path.closeSubpath()
    }
  }
}


#Preview {
  KeyCircle(width: 100, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
}
