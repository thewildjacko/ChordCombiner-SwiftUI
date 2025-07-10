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
  @StateObject var conductor = InstrumentEXSConductor()
  @StateObject var seqConductor = SFZSequencerConductor()

  var body: some Scene {
    WindowGroup {
      ViewCoordinator()
        .environmentObject(conductor)
        .environmentObject(seqConductor)
        .onAppear {
          UIWindow.showTouches()
        }
    }
  }
}

extension Logger {
  static let main = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "main")
}
