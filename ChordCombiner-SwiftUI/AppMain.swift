//
//  AppMain.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI
import OSLog

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
          ChordCombinerView()
        }
    }
}

extension Logger {
  static let main = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "main")
}
