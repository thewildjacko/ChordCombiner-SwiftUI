//
//  AppMain.swift
//  ChordCombiner-SwiftUI
//
//  Created by Jake Smolowe on 6/20/24.
//

import SwiftUI
import OSLog
import ShowTouches

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
          ViewCoordinator()
            .onAppear {
              UIWindow.showTouches()
            }
        }
    }
}

extension Logger {
  static let main = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "main")
}
