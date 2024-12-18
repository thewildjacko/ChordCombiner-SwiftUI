//
//  KeyShapePath.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 10/8/24.
//

import SwiftUI

enum KeyShapePathType {
  case CShape, DShape, EShape, FShape, GShape, AShape, BShape, blackAndEdgeWhiteKeyShape
}

struct KeyShapePath {
  private let finalKey: Bool
  private let width: CGFloat
  private let height: CGFloat
  private let radius: CGFloat
  private let widthMultiplier: CGFloat
  private let keyShapePathType: KeyShapePathType

  private(set) var path: Path = Path()

  init(
    finalKey: Bool,
    width: CGFloat,
    height: CGFloat,
    radius: CGFloat,
    widthMultiplier: CGFloat,
    keyShapePathType: KeyShapePathType) {
      self.finalKey = finalKey
      self.width = width
      self.height = height
      self.radius = radius
      self.widthMultiplier = widthMultiplier
      self.keyShapePathType = keyShapePathType

      path = getPathType()
    }

  func getPathType() -> Path {
    let pathType: KeyShapePathType = finalKey
    && keyShapePathType == .CShape ?
      .blackAndEdgeWhiteKeyShape
    : keyShapePathType

    return getPath(
      width: width,
      height: height,
      radius: radius,
      widthMultiplier: widthMultiplier,
      keyShapePathType: pathType)
  }

  func cefbPath(width: CGFloat,
                height: CGFloat,
                radius: CGFloat,
                widthMultiplier: CGFloat,
                keyShapePathType: KeyShapePathType) -> Path {
    return Path { path in
      // swiftlint:disable identifier_name
      let x0 = 0.0
      let x1 = KeyWidth.blackKey.rawValue * widthMultiplier
      let x2 = width
      let x3 = radius

      let y0 = 0.0
      let y1 = x1 * KeyConstants.blackKeyHeightToWidthRatio
      let y2 = height - radius
      let y3 = height
      // swiftlint:enable identifier_name
      path.addLines(
        [
          CGPoint(x: x0, y: y0), // start at top left
          CGPoint(x: x1, y: y0), // over to top right edge adjacent to next black key
          CGPoint(x: x1, y: y1), // down to black key base
          CGPoint(x: x2, y: y1), // over to lower right edge adjacent to next white key
          CGPoint(x: x2, y: y2) // down to lower right corner at white key base
        ]
      )

      // lower right corner radius
      path.addArc(
        tangent1End: CGPoint(x: x2, y: y3),
        tangent2End: CGPoint(x: x2 - radius, y: y3),
        radius: radius
      )

      // over to lower left corner
      path.addLine(to: CGPoint(x: x3, y: y3))

      // lower right corner radius
      path.addArc(
        tangent1End: CGPoint(x: x0, y: y3),
        tangent2End: CGPoint(x: x0, y: y2),
        radius: radius
      )

      path.closeSubpath() // back to top left
    }
  }

  func dgaPath(width: CGFloat,
               height: CGFloat,
               radius: CGFloat,
               widthMultiplier: CGFloat,
               keyShapePathType: KeyShapePathType) -> Path {
    return Path { path in
      let blackKeyWidth = KeyWidth.blackKey.rawValue * widthMultiplier // 14
      let keyAddendMod = (keyShapePathType == .GShape
                          || keyShapePathType == .AShape) ? KeyAddendMod.Gb.rawValue : KeyAddendMod.Db.rawValue

      // swiftlint:disable identifier_name
      let x0 = keyAddendMod * widthMultiplier

      let x1PositionMod = (keyShapePathType == .GShape || keyShapePathType == .AShape) ? x0/2 : x0 * 2
      let x1 = x1PositionMod + blackKeyWidth // 16

      let x2 = width // 23
      let x3 = radius
      let x4 = 0.0

      let y0 = 0.0
      let y1 = blackKeyWidth * KeyConstants.blackKeyHeightToWidthRatio
      let y2 = height - radius
      let y3 = height
      // swiftlint:enable identifier_name

      path.addLines(
        [
          CGPoint(x: x0, y: y0), // start at top left corner adjacent to previous black key
          CGPoint(x: x1, y: y0), // over to top right corner adjacent to next black key
          CGPoint(x: x1, y: y1), // down to black key base
          CGPoint(x: x2, y: y1), // over to outer middle right corner adjacent to next white key
          CGPoint(x: x2, y: y2) // down to lower right corner at white key base
        ])

      // lower right corner radius
      path.addArc(
        tangent1End: CGPoint(x: x2, y: y3),
        tangent2End: CGPoint(x: x2 - radius, y: y3),
        radius: radius
      )

      // over to lower left corner
      path.addLine(to: CGPoint(x: x3, y: y3))

      // lower right corner radius
      path.addArc(
        tangent1End: CGPoint(x: x4, y: y3),
        tangent2End: CGPoint(x: x4, y: y3 - radius),
        radius: radius
      )

      path.addLine(to: CGPoint(x: x4, y: y1)) // up to outer middle left corner adjacent to previous white key
      path.addLine(to: CGPoint(x: x0, y: y1)) // over to inner middle left corner adjacent to previous black key

      // back to top left corner
      path.closeSubpath()
    }
  }

  func blackAndEdgeWhiteKeyPath(width: CGFloat,
                                height: CGFloat,
                                radius: CGFloat,
                                widthMultiplier: CGFloat,
                                keyShapePathType: KeyShapePathType) -> Path {
    return Path { path in
      let rect = CGRect(x: 0, y: 0, width: width, height: height)

      path.addRoundedRect(
        in: rect,
        cornerRadii: RectangleCornerRadii(
          topLeading: 0,
          bottomLeading: radius,
          bottomTrailing: radius,
          topTrailing: 0))
    }
  }

  func getPath(
    width: CGFloat,
    height: CGFloat,
    radius: CGFloat,
    widthMultiplier: CGFloat,
    keyShapePathType: KeyShapePathType) -> Path {
      switch keyShapePathType {
      case .CShape, .EShape, .FShape, .BShape:
        return cefbPath(
          width: width,
          height: height,
          radius: radius,
          widthMultiplier: widthMultiplier,
          keyShapePathType: keyShapePathType)
      case .DShape, .GShape, .AShape:
        return dgaPath(
          width: width,
          height: height,
          radius: radius,
          widthMultiplier: widthMultiplier,
          keyShapePathType: keyShapePathType)
      case .blackAndEdgeWhiteKeyShape:
        return blackAndEdgeWhiteKeyPath(
          width: width,
          height: height,
          radius: radius,
          widthMultiplier: widthMultiplier,
          keyShapePathType: keyShapePathType)
      }
    }
}
