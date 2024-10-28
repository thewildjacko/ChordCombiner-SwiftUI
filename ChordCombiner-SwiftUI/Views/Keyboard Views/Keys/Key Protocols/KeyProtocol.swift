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
  
  var geoWidth: CGFloat { get set }
  var widthMod: CGFloat { get set }
  var initialKey: Bool { get set }
  var finalKey: Bool { get set }
  var keyPosition: CGFloat { get set }
  var highlighted: Bool { get set }
  var letterTextColor: Color { get }
  
  var widthMultiplier: CGFloat { get }
  var radius: CGFloat { get }
  var width: CGFloat { get }
  var height: CGFloat { get }
  var fill: any ShapeStyle { get set }
  var stroke: Color { get set }
  var lineWidth: CGFloat { get set }
  var z_Index: Double { get }
  var lettersOn: Bool { get set }
  
  init(pitch: Int, keyType: KeyType, note: Note?, geoWidth: CGFloat, widthMod: CGFloat, fill: any ShapeStyle, stroke: Color, lineWidth: CGFloat, lettersOn: Bool)
}

extension KeyProtocol {
  var widthMultiplier: CGFloat { geoWidth / widthMod }
  
  var radius: CGFloat {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return Radius.whiteKey.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return Radius.blackKey.rawValue * widthMultiplier
    }
  }
  
  var width: CGFloat {
    switch keyType {
    case .C, .E, .G, .A:
      return Width.whiteKeyCEGA.rawValue * widthMultiplier
    case .D, .F, .B:
      return Width.whiteKeyDFB.rawValue * widthMultiplier
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return Width.blackKey.rawValue * widthMultiplier
    }
  }
  
  var height: CGFloat {
    switch keyType {
    case .C, .D, .E, .F, .G, .A, .B:
      return widthMultiplier * Height.whiteKey.rawValue
    case .Db, .Eb, .Gb, .Ab, .Bb:
      return widthMultiplier * Height.blackKey.rawValue
    }
  }
  
  var fill: any ShapeStyle {
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
    geoWidth.getKeyPosition(position: keyPosition, widthMod: widthMod)
  }
  
  var KeyWidthAddend: CGFloat { Width.getAddend(keyType) }
  
  init(pitch: Int, _ keyType: KeyType = .C, note: Note? = nil, geoWidth: CGFloat, widthMod: CGFloat = 23, fill: any ShapeStyle, stroke: Color = .black, lineWidth: CGFloat = 1, initialKey: Bool = false, finalKey: Bool = false, keyPosition: CGFloat = 0, lettersOn: Bool = false) {
    self.init(pitch: pitch, keyType: keyType, note: note, geoWidth: geoWidth, widthMod: widthMod, fill: fill, stroke: stroke, lineWidth: lineWidth, lettersOn: lettersOn)
    
    self.initialKey = initialKey
    self.finalKey = finalKey
    self.keyPosition = keyPosition
  }
  
  init(pitch: Int, _ keyType: KeyType = .C, note: Note? = nil, geoWidth: CGFloat, widthMod: CGFloat = 23, initialKey: Bool = false, finalKey: Bool = false, keyPosition: CGFloat = 0, lettersOn: Bool = false) {
    
    self.init(pitch: pitch, keyType: keyType, note: note, geoWidth: geoWidth, widthMod: widthMod, fill: keyType.defaultFillColor, stroke: .black, lineWidth: 1, lettersOn: lettersOn)
    
    self.initialKey = initialKey
    self.finalKey = finalKey
    self.keyPosition = keyPosition
  }

}
