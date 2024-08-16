//
//  DeviceRotationViewModifier.swift
//  KeyboardGeometry
//
//  Created by Jake Smolowe on 7/10/24.
// from https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
//

import Foundation
import SwiftUI

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
