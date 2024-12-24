//
//  SplashScreen.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/23/24.
//

import SwiftUI

struct SplashScreen: View {
  @State private var scale = 0.4
      @Binding var isActive: Bool
      var body: some View {
          VStack {
              VStack {
                Image(.chordCombinerSplashIconLargeKeyboards)
                  .resizable()
                  .frame(width: 150, height: 150)

                TitleView(
                  text: "Chord Combiner",
                  font: .system(size: 20),
                  color: .title)
              }
              .ignoresSafeArea()
              .background(.clear)
              .scaleEffect(scale)
              .onAppear {
                  withAnimation(.easeIn(duration: 0.7)) {
                    self.scale = 1.5
                  }
              }
          }
          .ignoresSafeArea()
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
              withAnimation {
                      self.isActive = true
                  }
              }
          }
      }}

#Preview {
  SplashScreen(isActive: .constant(false))
}
