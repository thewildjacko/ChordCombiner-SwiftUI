// Copyright (c) 2024 Kodeco Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// This project and source code may use libraries or frameworks that are
// released under various Open-Source licenses. Use of those libraries and
// frameworks are governed by their own individual licenses.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// ImageService.swift
//  ChordCombiner-SwiftUI
//

import Foundation
import SwiftUI
import OSLog

@Observable
class ImageService {
  var progress: Double = 0
  var image: Image?

  func downloadImage(url: URL?) async throws {
    guard let url else {
      Logger.main.error("URL is nil returning empty image")
      return
    }

    progress = 0
    image = nil

    let (bytes, response) = try await URLSession.shared.bytes(for: URLRequest(url: url))

    guard let httpResponse  = response as? HTTPURLResponse, httpResponse.isOK else {
      Logger.main.error("Network response error")
      return
    }

    let length = Int(httpResponse.expectedContentLength)
    var data = Data(capacity: length)
    var bytesAccumulator = 0
    let bytesForUpdate = length / 100

    for try await byte in bytes {
      data.append(byte)
      bytesAccumulator += 1

      if bytesAccumulator > bytesForUpdate {
        progress = Double(data.count) / Double(length)
        bytesAccumulator = 0
      }
    }

    progress = 1
    image = Image(uiImage: UIImage(data: data) ?? UIImage())
  }
}

extension HTTPURLResponse {
  var isOK: Bool { statusCode == 200}
}
