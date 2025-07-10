//
//  ViewCoordinator.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/23/24.
//

import SwiftUI

struct ViewCoordinator: View {
  @State private var isActive = false
  @State private var size = CGSize()

  var body: some View {
//    SFZSequencerView()
      if isActive {
        GeometryReader { proxy in
          ChordCombinerView(size: $size)
            .onAppear {
              size = proxy.size
            }
        }
      } else {
          SplashScreen(isActive: $isActive)
      }
  }
}

#Preview {
    ViewCoordinator()
}
