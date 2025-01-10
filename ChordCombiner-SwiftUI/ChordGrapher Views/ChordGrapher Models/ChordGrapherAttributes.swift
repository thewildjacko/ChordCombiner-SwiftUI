//
//  ChordGrapherAttributes.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/6/24.
//

import Foundation

struct ChordGrapherAttributes {
  var elementsContained: ElementsContained
  var rowElementsMax: Int

  var rankSep: Double {
    switch rowElementsMax {
    case let max where max < 5:
      return 0.25
    case let max where max <= 10:
      return 0.5
    case let max where max <= 20:
      return 0.75
    default:
      return 1.5
    }
  }

  init(elementsContained: ElementsContained, rowElementsMax: Int) { self.elementsContained = elementsContained
    self.rowElementsMax = rowElementsMax
  }

  let digraph = String.GrapherConstants.digraph.rawValue
  let charSet = "charset=\"utf8\""
  let fontSize = "node [fontsize=\"10pt\"]"

  var firstChildLevelNodeShape: String {
    var firstNodeShape = ""
    switch elementsContained {
    case .all:
      firstNodeShape = "rectangle"
    case .triadsAndNotes:
      firstNodeShape = "oval"
    case .notes:
      firstNodeShape = "circle"
    }

    return nodeShape(shape: firstNodeShape, width: 0.5)
  }

  func fontSize(_ pts: CGFloat = 10) -> String {
    return "node [fontsize=\(pts)]"
  }

  /// returns a dot-notation string describing the shape of a node
  func nodeShape(shape: String, width: CGFloat? = nil) -> String {
    if let width = width {
      return "node [shape=\(shape) width=\(width)]"
    } else {
      return "node [shape=\(shape)]"
    }
  }

  /// returns a dot-notation string describing the color and penWidth of an edge
  func edge(color: String, penWidth: CGFloat? = nil) -> String {
    if let penWidth = penWidth {
      return "edge [color=\"\(color)\" width=\(penWidth)]"
    } else {
      return "edge [color=\"\(color)\"]"
    }
  }

  func arrowHead(type: String) -> String { return "edge [arrowhead=\(type)]" }

  func graphPrefix(edgeColor: String) -> String {
    let edge = edge(color: edgeColor)

    return "ordering=out concentrate=true nodesep=0.1 ranksep=\(rankSep) \(edge) \(charSet) \(fontSize)"
  }
}
