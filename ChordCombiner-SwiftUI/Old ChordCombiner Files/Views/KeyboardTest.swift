//
//  KeyboardTest.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 8/16/24.
//

import SwiftUI

struct KeyboardTest: View {
  @State var portrait: Bool = true
  @State var geoSize: CGSize = .zero
  @State var kb1: Keyboard = Keyboard(title: "Base Chord", geoWidth: 351, initialKey: .C, startingOctave: 4, octaves: 1)
  @State var kb2: Keyboard = Keyboard(title: "UST", geoWidth: 351, initialKey: .C, startingOctave: 4, octaves: 1)
  @State var kb3: Keyboard = Keyboard(title: "Combined Chord", geoWidth: 351, keyCount: 36, initialKey: .F, startingOctave: 3)
  
  var body: some View {
    GeometryReader { geo in
      VStack(alignment: .center) {
        HStack(spacing: 0) {
          VStack {
            Spacer(minLength: geo.size.height * 0.3)
            kb1
          }
          .padding()
          
          VStack {
            Spacer(minLength: geo.size.height * 0.3)
            kb2
          }
          .padding()
        }
        Spacer()
          VStack {
            kb3
            Spacer(minLength: geo.size.height * 0.05)
          }
          .padding()
        Spacer()
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      .onAppear(perform: {
//        print("geo size: \(geo.size)")
      })
    }
    .background(
      GeometryReader { geo in
        Color.indigo
          .onAppear(perform: {
//            print("background geoSize: \(geo.size)")
            geoSize = geo.size
            kb1 = kb1.resize(geoWidth: geo.size.width * 0.85 * 0.5)
            kb2 = kb2.resize(geoWidth: geo.size.width * 0.85 * 0.5)
            kb3 = kb3.resize(geoWidth: geo.size.width * 0.9)
            
            let degs1 = [0, 4, 7, 10].map { $0.toPitch(startingOctave: kb1.startingOctave) }
            let degs2 = [2, 6, 9].map { $0.toPitch(startingOctave: kb2.startingOctave) }
            
            kb1.highlightKeys(degs: degs1, color: .cyan)
            kb2.highlightKeys(degs: degs2, color: .orange)
            kb3.highlightKeys(degs: degs1, degs2: degs2.map({ $0 + 12 }), color: .cyan, color2: .orange)
          })
      }
    )
    .ignoresSafeArea(.all)
  }
}

#Preview {
  KeyboardTest()
}
