//
//  KeyboardLayoutTestView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//

import SwiftUI

struct KeyboardLayoutTestView: View {
  @State var size: CGSize = CGSize(width: 0, height: 0)
  @State var keyboard = Keyboard2(
    baseWidth: 164*2,
    keyCount: 12,
    initialKeyType: .c,
    startingOctave: 4)

  var body: some View {
    GeometryReader { proxy in

      keyboard
        .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
        .onAppear {
          size = proxy.size
          keyboard = Keyboard2(
            baseWidth: proxy.size.width/2,
            keyCount: 12,
            initialKeyType: .c,
            startingOctave: 4)
        }
    }
  }
}

#Preview {
  KeyboardLayoutTestView()
}
