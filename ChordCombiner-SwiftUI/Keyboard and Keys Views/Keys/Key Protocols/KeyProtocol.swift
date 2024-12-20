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
  var radius: CGFloat { get }
  var width: CGFloat { get }
  var height: CGFloat { get }
  var fill: Color { get set }
  var stroke: Color { get set }
  var lineWidth: CGFloat { get set }
  var z_Index: Double { get }
  var lettersOn: Bool { get set }
  var circlesOn: Bool { get set }
  
  init(pitch: Int, keyType: KeyType, note: Note?, baseWidth: CGFloat, widthDivisor: CGFloat, fill: Color, stroke: Color, lineWidth: CGFloat, lettersOn: Bool, circlesOn: Bool, circleType: KeyCirclesView.CircleType)
}

extension KeyProtocol {
  var widthMultiplier: CGFloat { baseWidth / widthDivisor }
  
  var radius: CGFloat {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return KeyRadius.whiteKey.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return KeyRadius.blackKey.rawValue * widthMultiplier
    }
  }
  
  var width: CGFloat {
    switch keyType {
    case .C, .E, .G, .A:
      return KeyWidth.whiteKeyCEGA.rawValue * widthMultiplier
    case .D, .F, .B:
      return KeyWidth.whiteKeyDFB.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return KeyWidth.blackKey.rawValue * widthMultiplier
    }
  }
  
  var height: CGFloat {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return widthMultiplier * KeyHeight.whiteKey.rawValue
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return widthMultiplier * KeyHeight.blackKey.rawValue
    }
  }
  
  var fill: Color {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return .white
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return .black
    }
  }
  
  var z_Index: Double {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return 0
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return 1.0
    }
  }
  
  var position: CGFloat {
    baseWidth.getKeyPosition(position: keyPosition, widthDivisor: widthDivisor)
  }
  
  var keyWidthAddend: CGFloat { KeyWidth.getAddend(keyType) }
  
  init(pitch: Int, _ keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat = 23, fill: Color, stroke: Color = .black, lineWidth: CGFloat = 1, initialKey: Bool = false, finalKey: Bool = false, keyPosition: CGFloat = 0, lettersOn: Bool = false, circlesOn: Bool = false,  circleType: KeyCirclesView.CircleType = .common) {
    self.init(pitch: pitch, keyType: keyType, note: note, baseWidth: baseWidth, widthDivisor: widthDivisor, fill: fill, stroke: stroke, lineWidth: lineWidth, lettersOn: lettersOn, circlesOn: circlesOn, circleType: circleType)
    
    self.initialKey = initialKey
    self.finalKey = finalKey
    self.keyPosition = keyPosition
  }
  
  init(pitch: Int, _ keyType: KeyType = .C, note: Note? = nil, baseWidth: CGFloat, widthDivisor: CGFloat = 23, initialKey: Bool = false, finalKey: Bool = false, keyPosition: CGFloat = 0, lettersOn: Bool = false, circlesOn: Bool = false,  circleType: KeyCirclesView.CircleType = .common) {
    
    self.init(pitch: pitch, keyType: keyType, note: note, baseWidth: baseWidth, widthDivisor: widthDivisor, fill: keyType.defaultFillColor, stroke: .black, lineWidth: 1, lettersOn: lettersOn, circlesOn: circlesOn, circleType: circleType)
    
    self.initialKey = initialKey
    self.finalKey = finalKey
    self.keyPosition = keyPosition
  }

}
