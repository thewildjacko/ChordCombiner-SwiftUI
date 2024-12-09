//
//  ChordGrapherAttributes.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/6/24.
//


import Foundation

struct ChordGrapherAttributes {
  var elementsContained: ElementsContained
  
  init(elementsContained: ElementsContained) { self.elementsContained = elementsContained }
  
  let digraph = String.GrapherConstants.digraph.rawValue
  let charSet = "charset=\"utf8\""
  
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
    
    return "ordering=out ratio=0.5 \(edge) \(charSet)"
  }
}
