//
//  GraphImagePlacerView.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 12/19/24.
//
// Zoom & scroll implementation from: https://codewithchris.com/photo-gallery-app-swiftui-part-4/

/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ChordGraphImageView: View {
  @State private var shouldPresentGraphHelpView = false
  @State private var zoomScale: CGFloat = 1
  @State private var previousZoomScale: CGFloat = 1
  private let minZoomScale: CGFloat = 1
  private let maxZoomScale: CGFloat = 5

  var chordGrapher: ChordGrapher = ChordGrapher(chord: Chord(.c, .ma9))

  @State private var imageService = ImageService()

  var body: some View {
    VStack {
      innerView()
        .padding()
        .background(.primaryBackground)
        .navigationTitle(chordGrapher.chordGrapherRelationships.parentChord.chord.details.preciseName)
        .task {
          try? await imageService.downloadImage(url: chordGrapher.makeURL())
        }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          shouldPresentGraphHelpView.toggle()
        } label: {
          Image(systemName: "questionmark.circle")
        }
        .sheet(isPresented: $shouldPresentGraphHelpView) {
          GraphHelpView()
            .presentationDetents([.fraction(0.8)])
        }
      }
    }
  }

  @MainActor
  @ViewBuilder
  private func innerView() -> some View {
    if imageService.image != nil {
      VStack {
        TitleView(
          text: "Double tap or pinch to zoom",
          font: .headline,
          weight: .heavy,
          color: .title)
        TitleView(
          text: "Drag or swipe to scroll.",
          font: .headline,
          weight: .heavy,
          color: .title)
        chordGraphView
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.primaryBackground)
    } else {
      if imageService.progress == 0 {
        VStack(spacing: 10) {
          ProgressView()
          TitleView(
            text: "Connecting to the network...",
            font: .body,
            weight: .regular)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryBackground)
      } else if imageService.progress < 1 {
        GraphImagePlacerPyramidView(progress: $imageService.progress)
      } else {
        VStack {
          Image(systemName: "pianokeys")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryBackground)
      }
    }
  }
}

extension ChordGraphImageView {
  /// Resets the zoom scale back to 1 – the photo scale at 1x zoom
  func resetImageState() {
    withAnimation(.interactiveSpring()) {
      zoomScale = 1
    }
  }

  /// On double tap
  func onImageDoubleTapped() {
    /// Zoom the photo to 5x scale if the photo isn't zoomed in
    if zoomScale == 1 {
      withAnimation(.spring()) {
        zoomScale = 5
      }
    } else {
      /// Otherwise, reset the photo zoom to 1x
      resetImageState()
    }
  }

  var chordGraphView: some View {
    GeometryReader { proxy in
      ScrollView([.vertical, .horizontal], showsIndicators: false) {
        imageService.image?
          .resizable()
          .aspectRatio(contentMode: .fit)
          .onTapGesture(count: 2, perform: onImageDoubleTapped)
          .gesture(zoomGesture) // Add it here
          .frame(width: proxy.size.width * max(minZoomScale, zoomScale))
          .frame(maxHeight: .infinity)
      }
    }
  }
}

extension ChordGraphImageView {
  func onZoomGestureStarted(value: MagnificationGesture.Value) {
    withAnimation(.easeIn(duration: 0.1)) {
      let delta = value / previousZoomScale
      previousZoomScale = value
      let zoomDelta = zoomScale * delta
      var minMaxScale = max(minZoomScale, zoomDelta)
      minMaxScale = min(maxZoomScale, minMaxScale)
      zoomScale = minMaxScale
    }
  }

  func onZoomGestureEnded(value: MagnificationGesture.Value) {
    previousZoomScale = 1
    if zoomScale <= 1 {
      resetImageState()
    } else if zoomScale > 5 {
      zoomScale = 5
    }
  }
}

extension ChordGraphImageView {
  var zoomGesture: some Gesture {
    MagnificationGesture()
      .onChanged(onZoomGestureStarted)
      .onEnded(onZoomGestureEnded)
  }
}

#Preview {
  let chordGrapher = ChordGrapher(chord: Chord(.c, .ma9))

  ChordGraphImageView(chordGrapher: chordGrapher)
}
