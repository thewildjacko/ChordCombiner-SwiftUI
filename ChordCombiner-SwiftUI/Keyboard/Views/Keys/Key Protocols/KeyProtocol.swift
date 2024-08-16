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
  var type: KeyType { get set }
  var geoWidth: CGFloat { get set }
  var widthMod: CGFloat { get set }
  var initialKey: Bool { get set }
  var keyPosition: CGFloat { get set }
  
  var widthMultiplier: CGFloat { get }
  var radius: CGFloat { get }
  var width: CGFloat { get }
  var height: CGFloat { get }
  var fill: Color { get set }
  var stroke: Color { get set }
  var lineWidth: CGFloat { get set }
  var z_Index: Double { get }
  
  init(pitch: Int, type: KeyType, geoWidth: CGFloat, widthMod: CGFloat, fill: Color, stroke: Color, lineWidth: CGFloat)
}

extension KeyProtocol {
  var widthMultiplier: CGFloat { geoWidth / widthMod }
  
  var radius: CGFloat {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B, .endingC, .endingE:
      return Radius.whiteKey.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return Radius.blackKey.rawValue * widthMultiplier
    }
  }
  
  var width: CGFloat {
    switch type {
    case .C, .E, .G, .A, .endingC, .endingE:
      return Width.whiteKeyCEGA.rawValue * widthMultiplier
    case .D, .F, .B:
      return Width.whiteKeyDFB.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return Width.blackKey.rawValue * widthMultiplier
    }
  }
  
  var height: CGFloat {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B, .endingC, .endingE:
      return widthMultiplier * Height.whiteKey.rawValue
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return widthMultiplier * Height.blackKey.rawValue
    }
  }
  
  var fill: Color {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B, .endingC, .endingE:
      return .white
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return .black
    }
  }
  
  var z_Index: Double {
    switch type {
    case .C, .D, .E, .F, .G, .A, .B, .endingC, .endingE:
      return 0
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return 1.0
    }
  }
  
  var position: CGFloat {
    geoWidth.getKeyPosition(position: keyPosition, widthMod: widthMod)
  }
  
  var KeyWidthAddend: CGFloat { Width.getAddend(type) }
  
  init(pitch: Int, _ type: KeyType = .C, geoWidth: CGFloat, widthMod: CGFloat = 23, fill: Color, stroke: Color = .black, lineWidth: CGFloat = 1, initialKey: Bool = false, keyPosition: CGFloat = 0) {
    self.init(pitch: pitch, type: type, geoWidth: geoWidth, widthMod: widthMod, fill: fill, stroke: stroke, lineWidth: lineWidth)
    
    self.initialKey = initialKey
    self.keyPosition = keyPosition
  }
}
