//
//  ViewCoordinator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/23/24.
//

import SwiftUI

struct ViewCoordinator: View {
  @State private var isActive = false
  var body: some View {
      if isActive {
        ChordCombinerView()
      } else {
          SplashScreen(isActive: $isActive)
      }
  }
}

#Preview {
    ViewCoordinator()
}
