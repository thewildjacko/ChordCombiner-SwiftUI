//
//  GraphImagePlacerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/24/24.
//

import SwiftUI

struct GraphImagePlacerView: View {
  var image: Image
  var columns: UInt
  var spacing: CGFloat = 10

  @ViewBuilder
  var body: some View {
    if columns > 0 {
      HStack(spacing: spacing) {
        ForEach((1...columns), id: \.self) { _ in
          image
        }
      }
    }
  }
}
